const express = require('express');
const router = express();

const db = require('../db');

let cart_item;

// Get all items and total value in the cart of a user
router.get('/:id', async (req,res)=>{
    const sql = `select pr.title,up.price,ci.quantity,up.image,
                        sum(up.price * ci.quantity) as total_value
                    from cart_items ci
                    join unique_products up using(unique_product_id)
                    join products pr using(product_id)
                    join carts ca using(cart_id)
                    join customers cu using(customer_id)
                    where cu.customer_id = ?
                    group by pr.title,up.price,ci.quantity,up.image`;
    [cart_item] = await db.query(sql,req.params.id);
    res.send(cart_item);
    console.log(cart_item);
});

// Add a new item to the cart of a user
router.post('/:id/:item', async (req,res)=>{
    const sql1 = `select is_registered from customers where customer_id = ?`;
    const sql2 = `select cart_id from carts where customer_id = ?`;
    const sql3 = `insert into carts values(?,0)`;
    const sql4 = `insert into cart_items(cart_id, unique_product_id, quantity)
                        values(?,?,1)
                    on duplicate key
                        update quantity = quantity + 1 where cart_id = ?`;
    let is_registered = await db.query(sql1,req.params.id);
    if(!is_registered) res.send("You are not registered yet. Please get registered.");
    else{
        let cart_id = await db.query(sql2,req.params.id);
        if(!cart_id) db.query(sql3,req.params.id);
        cart_id = await db.query(sql2,req.params.id);
        db.query(sql4,[cart_id,req.params.item,cart_id]);
    }
}); 

module.exports = router;