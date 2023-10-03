const express = require('express');
const router = express();

const cartServices = require('../services/cartServices');

let carts;
router.get('/', async (req,res)=>{
    carts = await cartServices.getAllCarts();
    res.send(carts);
});

let unique_cart;
router.get('/:id', async (req,res)=>{
    unique_cart = await cartServices.getUniqueCart(req.params.id);
    if (unique_cart.length == 0)
        res.status(404).json("No cart with the given id " + req.params.id);
    else
        res.send(unique_cart); 
});

router.delete('/:id', async (req,res)=>{
    let affectedRows = await cartServices.deleteUniqueCart(req.params.id);
    if( affectedRows == 0 ) res.status(404).json("No cart with the given id " + req.params.id);
    else res.send("Cart deleted successfully.");
});

router.post('/', async (req,res)=>{
    await cartServices.addOrUpdateCart(req.body);
    res.status(201).send("A new cart added successfully.");
});

router.put('/:id', async (req,res)=>{
    const affectedRows = await cartServices.addOrUpdateCart(req.body, req.params.id);
    if( affectedRows == 0 ) res.status(404).json("No cart with the given id " + req.params.id);
    else res.send("Cart updated successfully.");
});


module.exports = router;