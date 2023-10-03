const express = require('express');
const app = express();

require('express-async-errors');
require('body-parser');

const db = require('./db');

const productRoutes = require('./controllers/products');
const customerRoutes = require('./controllers/customers');
const cartRoutes = require('./controllers/carts');
const orderRoutes = require('./controllers/orders');

const bodyParser = require('body-parser');

app.use(bodyParser.json());

app.use('/shop', productRoutes);
app.use('/customers', customerRoutes);
app.use('/carts', cartRoutes);
app.use('/orders', orderRoutes);

app.use((err,req,res,next)=>{
    console.log(err);
    res.status(err.status || 500).send("Something went wrong.");
})

db.query("SELECT * FROM admin")
    .then(data => {
        console.log("DB connection succeeded.")
        console.log(data)
        app.listen(8000,()=>{
            console.log("Server running on 8000.")
        })
    })
    .catch(err => console.log("DB connection failed. " + err));

