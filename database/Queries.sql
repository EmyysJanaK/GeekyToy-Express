-- Get all the details of a single product using given product_id
SELECT *
FROM product
WHERE product_id = ?; -- replace ? with the product_id


-- Get the leaf categories of a single product using given product_id
SELECT c.name
FROM product_category pc
JOIN category c USING(category_id)
WHERE product_id = ?; -- replace ? with the product_id


-- Get the category hierarchy names for a given product_id
SELECT GetCategoryHierarchyNames(category_id) AS category_hierachy
FROM product_category
WHERE Product_id = ?; -- replace ? with the product_id 


-- Get the category hierarchy IDs for a given product_id
SELECT GetCategoryHierarchyIDs(category_id) AS category_hierachy
FROM product_category
WHERE Product_id = ?; -- replace ? with the product_id 


-- Get all the item IDs in the cart for a given customer_id
SELECT ci.Item_id, ci.Quantity, i.price
FROM cart_item ci
JOIN cart c USING (cart_id)
JOIN item i USING (Item_id)
WHERE Customer_id = 1; -- replace ? with the Customer_id 