const express = require('express');
const router = express();

const db = require('../db');

router.post('/', async (req,res)=>{
    const sql1 = `SELECT Customer_id FROM Customers
        WHERE Email = ? AND Is_registered = 1`;
    const sql2 = `INSERT INTO Customers (Password, First_name, Last_name, Email, Phone_number, Address_line1, Address_line2, City, Province, Zipcode, Is_registered)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE
        Password = VALUES(Password),
        First_name = VALUES(First_name),
        Last_name = VALUES(Last_name),
        Phone_number = VALUES(Phone_number),
        Address_line1 = VALUES(Address_line1),
        Address_line2 = VALUES(Address_line2),
        City = VALUES(City),
        Province = VALUES(Province),
        Zipcode = VALUES(Zipcode),
        Is_registered = VALUES(Is_registered)`;
    const values = [
        req.body.Password, req.body.First_name, req.body.Last_name, req.body.Email, req.body.Phone_number,
        req.body.Address_line1, req.body.Address_line2, req.body.City, req.body.Province, req.body.Zipcode,
        req.body.Is_registered
    ];
    const [details1] = await db.query(sql1, req.body.Email);
    if(details1.affectedRows == 0) res.send("You're already registered. Please log in.");
    else {
        await db.query(sql2,values);
    }
});

module.exports = router;