-- NOTE you will need to create this table today
-- you must send a GET request to the accounts endpoint with your bearer token in order to add your user to the sql database
CREATE TABLE IF NOT EXISTS accounts (
    id VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'primary key',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Time Created',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Last Update',
    name VARCHAR(255) COMMENT 'User Name',
    email VARCHAR(255) UNIQUE COMMENT 'User Email',
    picture VARCHAR(255) COMMENT 'User Picture'
) default charset utf8mb4 COMMENT '';

CREATE TABLE cars (
    -- NOTE make sure your id column is the first column you define
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    make TINYTEXT NOT NULL,
    model TINYTEXT NOT NULL,
    year INT UNSIGNED NOT NULL,
    color TINYTEXT NOT NULL,
    price MEDIUMINT UNSIGNED NOT NULL,
    mileage MEDIUMINT UNSIGNED NOT NULL,
    engine_type ENUM(
        'small',
        'medium',
        'large',
        'super-size',
        'battery'
    ),
    img_url TEXT NOT NULL,
    has_clean_title BOOLEAN NOT NULL DEFAULT true,
    creator_id VARCHAR(255) NOT NULL,
    -- NOTE this will validate that an actual id for an account was used when INSERTING a car into the data base
    -- this will also delete an accounts created cars if the user deletes their account
    FOREIGN KEY (creator_id) REFERENCES accounts (id) ON DELETE CASCADE
);

INSERT INTO
    cars (
        make,
        model,
        year,
        price,
        color,
        mileage,
        engine_type,
        img_url,
        has_clean_title,
        creator_id
    )
VALUES (
        'honda',
        's2000',
        2008,
        20000,
        'silver',
        200000,
        'medium',
        'https://images.unsplash.com/photo-1723407338018-709fbf9ed494?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHMyMDAwfGVufDB8fDB8fHww',
        false,
        '67e32349d1583cd79fcfd0a4'
    );

INSERT INTO
    houses (
        bedrooms,
        bathrooms,
        levels,
        year,
        price,
        description,
        img_url,
        creator_id
    )
VALUES (
        '5',
        '2',
        '3',
        1969,
        400000,
        'big hoose',
        'https://images.unsplash.com/photo-1570129477492-45c003edd2be?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        '67e32349d1583cd79fcfd0a4'
    )

SELECT * FROM accounts;

SELECT * FROM cars;

SELECT * FROM houses;

-- NOTE JOIN is how we include multiple rows of data on the same row
-- INNER JOIN denotes that there must be a match between the two columns, or no data is returned
-- ON tells our database when to match up data, otherwise it will match everything to everything
SELECT cars.*, accounts.*
FROM cars
    INNER JOIN accounts ON accounts.id = cars.creator_id;

SELECT cars.*, accounts.*
FROM cars
    INNER JOIN accounts ON accounts.id = cars.creator_id
WHERE
    cars.id = 3;

SELECT houses.*, accounts.*
FROM houses
    INNER JOIN accounts ON accounts.id = houses.creator_id;

UPDATE cars SET make = "mazda", model = "miata" WHERE id = 5 LIMIT 1;

SELECT * FROM houses;

-- Add Car 1: Honda Civic
-- Add House 1
INSERT INTO
    houses (
        bedrooms,
        bathrooms,
        levels,
        year,
        price,
        description,
        img_url,
        creator_id,
        color
    )
VALUES (
        3,
        2.5,
        2,
        2005,
        350000.00,
        'Spacious family home in a quiet neighborhood.',
        'https://example.com/images/house1.jpg',
        '67e32349d1583cd79fcfd0a4',
        '#f0f0f0'
    );

-- Add House 2
INSERT INTO
    houses (
        bedrooms,
        bathrooms,
        levels,
        year,
        price,
        description,
        img_url,
        creator_id,
        color
    )
VALUES (
        4,
        3.0,
        1,
        1998,
        420000.00,
        'Ranch style house with a large backyard.',
        'https://example.com/images/house2.jpg',
        '67e32349d1583cd79fcfd0a4',
        '#a0522d'
    );

-- Add House 3
INSERT INTO
    houses (
        bedrooms,
        bathrooms,
        levels,
        year,
        price,
        description,
        img_url,
        creator_id,
        color
    )
VALUES (
        2,
        1.0,
        1,
        2015,
        280000.00,
        'Cozy starter home near downtown.',
        'https://example.com/images/house3.jpg',
        '67e32349d1583cd79fcfd0a4',
        '#b0c4de'
    );