const express = require('express');
const router = express();

const CategoryServices = require('../services/categoryServices');

let orders;
router.get('/', async (req,res)=>{
    orders = await CategoryServices.getAllCategories();
    res.send(orders);
});

let unique_order;
router.get('/:id', async (req,res)=>{
    unique_order = await CategoryServices.getUniqueCategory(req.params.id);
    if (unique_order.length == 0)
        res.status(404).json("No category with the given id " + req.params.id);
    else
        res.send(unique_order); 
});

router.delete('/:id', async (req,res)=>{
    let affectedRows = await CategoryServices.deleteUniqueCategory(req.params.id);
    if( affectedRows == 0 ) res.status(404).json("No category with the given id " + req.params.id);
    else res.send("Category deleted successfully.");
});

router.post('/', async (req,res)=>{
    await CategoryServices.addOrUpdateCategory(req.body);
    res.status(201).send("A new category added successfully.");
});

router.put('/:id', async (req,res)=>{
    const affectedRows = await CategoryServices.addOrUpdateCategory(req.body, req.params.id);
    if( affectedRows == 0 ) res.status(404).json("No category with the given id " + req.params.id);
    else res.send("Category updated successfully.");
});


module.exports = router;