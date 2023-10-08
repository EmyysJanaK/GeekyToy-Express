-- Function to get the category heirachy names of a given cateegory id
DROP FUNCTION IF EXISTS GetCategoryHierarchyNames;
DELIMITER //

CREATE FUNCTION GetCategoryHierarchyNames(p_Category_id INT) RETURNS TEXT
READS SQL DATA
BEGIN

    DECLARE v_result TEXT DEFAULT '';
    DECLARE done INT DEFAULT 0;
    DECLARE v_name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT Name FROM temp_hierarchy;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Create a temporary table to store the results
    DROP TEMPORARY TABLE IF EXISTS temp_hierarchy;
    CREATE TEMPORARY TABLE temp_hierarchy(Name VARCHAR(255));

    -- Insert the category names into the temporary table
    INSERT INTO temp_hierarchy
    WITH RECURSIVE CategoryHierarchy AS (
        -- Base Case
        SELECT Category_id, Name, Parent_Category_id
        FROM `group32`.`category`
        WHERE Category_id = p_Category_id

        UNION ALL

        -- Recursive Step
        SELECT c.Category_id, c.Name, c.Parent_Category_id
        FROM `group32`.`category` c
        JOIN CategoryHierarchy ch ON c.Category_id = ch.Parent_Category_id
    )
    SELECT Name FROM CategoryHierarchy;

    -- Convert the temporary table rows to a single TEXT result
    -- You can adjust this section based on your preferred format
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET v_result = CONCAT(v_result, v_name, ',');  -- Add each name to the result with a comma separator
    END LOOP;
    CLOSE cur;

    -- Return the result
    RETURN v_result;

END //

DELIMITER ;



-- Function to get the category hierarchy IDs of a given cateegory id
DROP FUNCTION IF EXISTS GetCategoryHierarchyIDs;
DELIMITER //

CREATE FUNCTION GetCategoryHierarchyIDs(p_Category_id INT) RETURNS TEXT
READS SQL DATA
BEGIN

    DECLARE v_result TEXT DEFAULT '';
    DECLARE done INT DEFAULT 0;
    DECLARE v_name VARCHAR(255);
    DECLARE cur CURSOR FOR SELECT Name FROM temp_hierarchy;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Create a temporary table to store the results
    DROP TEMPORARY TABLE IF EXISTS temp_hierarchy;
    CREATE TEMPORARY TABLE temp_hierarchy(Name VARCHAR(255));

    -- Insert the category names into the temporary table
    INSERT INTO temp_hierarchy
    WITH RECURSIVE CategoryHierarchy AS (
        -- Base Case
        SELECT Category_id, Name, Parent_Category_id
        FROM `group32`.`category`
        WHERE Category_id = p_Category_id

        UNION ALL

        -- Recursive Step
        SELECT c.Category_id, c.Name, c.Parent_Category_id
        FROM `group32`.`category` c
        JOIN CategoryHierarchy ch ON c.Category_id = ch.Parent_Category_id
    )
    SELECT category_id FROM CategoryHierarchy;

    -- Convert the temporary table rows to a single TEXT result
    -- You can adjust this section based on your preferred format
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET v_result = CONCAT(v_result, v_name, ',');  -- Add each name to the result with a comma separator
    END LOOP;
    CLOSE cur;

    -- Return the result
    RETURN v_result;

END //

DELIMITER ;


-- When the email is given this function returns
-- -1 if the user is a new guest
-- 0 if the user has bought something as a guest
-- 1 if the user is registered
DROP FUNCTION IF EXISTS isTheUserRegistered;

DELIMITER //
CREATE FUNCTION isTheUserRegistered(p_email VARCHAR(255)) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE result INT;
    SELECT Is_registered INTO result
    FROM customer
    WHERE email = p_email;
    
    RETURN IFNULL(result, -1);
END //
DELIMITER ;