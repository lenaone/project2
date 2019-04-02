CREATE DATABASE reviews_db;

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(400),
    image_url VARCHAR(500),
    price VARCHAR(300) 
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(600),
    password_digest VARCHAR(400)
);

ALTER TABLE products ADD COLUMN user_id INTEGER;
ALTER TABLE users ADD COLUMN name VARCHAR(200);
ALTER TABLE products DROP COLUMN price;

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    star_rating INTEGER,
    description TEXT,
    user_id INTEGER,
    Product_id INTEGER
);



INSERT INTO products (name, image_url, price) VALUES ('WOMEN''S AXILUS 2 ENERGIZED', 'https://fila.com.au/wp-content/uploads/2018/10/5tm00044_103-150x150.jpg' ,'$120');


INSERT INTO products (name, image_url, price) VALUES ('WOMEN''S MEMORY WYNNE', 'https://fila.com.au/wp-content/uploads/2018/10/wt6116_nc2-150x150.jpg' ,'$100');
