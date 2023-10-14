const db = require('../db');

module.exports.getAllProducts = async () => {
    const [products] = await db.query("SELECT * FROM products");
    return products;
}

module.exports.getUniqueProduct = async (id) => {
    const [unique_product] = await db.query(`
        SELECT Product_id,Title,SKU,Weight,Description,p.Image,Main_category,
                    MIN(price) as Min_price
        FROM products p
        JOIN unique_products up using(product_id)
        WHERE Product_id = ?`, [id]);
    const [items] = await db.query(`
        SELECT * FROM unique_products WHERE Product_id = ?`, [id]);
    return [unique_product,items];
}

module.exports.deleteUniqueProduct = async (id) => {
    const [details] = await db.query("DELETE FROM products WHERE Product_id = ?", [id]);
    return details.affectedRows;
}

module.exports.addOrUpdateProduct = async (obj, id=0) => {
    const [[[{affectedRows}]]] = await db.query("CALL products_add_or_update(?,?,?,?,?,?,?)", 
        [id, obj.Title, obj.SKU, obj.Weight, obj.Description, obj.Image, obj.main_category]);
    return affectedRows;
}