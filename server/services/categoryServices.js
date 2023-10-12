const db = require('../db');

module.exports.getAllCategories = async () => {
    const [main_categories] = await db.query("SELECT * FROM main_categories");
    return main_categories;
}

module.exports.getUniqueCategory = async (id) => {
    const [unique_main_category] = await db.query("SELECT * FROM products WHERE main_category = ?", [id]);
    return unique_main_category;
}

module.exports.deleteUniqueCategory = async (id) => {
    const [details] = await db.query("DELETE FROM main_categories WHERE Order_id = ?", [id]);
    return details.affectedRows;
}

module.exports.addOrUpdateCategory = async (obj, id=0) => {
    const [[[{affectedRows}]]] = await db.query("CALL categories_add_or_update(?,?,?)", 
        [id, obj.Name, obj.Image]);
    return affectedRows;
}