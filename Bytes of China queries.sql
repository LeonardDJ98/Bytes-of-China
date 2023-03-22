CREATE TABLE restaurant ( 
    id integer PRIMARY KEY,
    name varchar(20),
    description varchar(100),
    rating decimal,   
    telephone char(10),
    hours varchar(100)
);

CREATE TABLE address(
   id integer PRIMARY KEY,
  street_number varchar(10),
  street_name varchar(20),
  city varchar(20),
  state varchar(15),
  google_map_link varchar(50),
  restaurant_id integer REFERENCES restaurant(id)
);

CREATE TABLE category( 
  id char(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
);

CREATE TABLE dish(
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(200),
  hot_and_spicy boolean
);

CREATE TABLE review(
  id integer PRIMARY KEY,
  rating decimal, 
  description varchar(100),
  date date,
  restaurant_id integer REFERENCES restaurant(id)
);

create table categories_dishes(
  category_id char(2) REFERENCES category(id),
  dish_id integer REFERENCES  dish(id),
  price money,
  PRIMARY KEY (category_id, dish_id)
);

/* 
 *--------------------------------------------
 Insert values for restaurant
 *--------------------------------------------
 */
INSERT INTO restaurant VALUES (
  1,
  'Bytes of China',
  'Delectable Chinese Cuisine',
  3.9,
  '6175551212',
  'Mon - Fri 9:00 am to 9:00 pm, Weekends 10:00 am to 11:00 pm'
);

/* 
 *--------------------------------------------
 Insert values for address
 *--------------------------------------------
 */
INSERT INTO address VALUES (
  1,
  '2020',
  'Busy Street',
  'Chinatown',
  'MA',
  'http://bit.ly/BytesOfChina',
  1
);

/* 
 *--------------------------------------------
 Insert values for review
 *--------------------------------------------
 */
INSERT INTO review VALUES (
  1,
  5.0,
  'Would love to host another birthday party at Bytes of China!',
  '05-22-2020',
  1
);

INSERT INTO review VALUES (
  2,
  4.5,
  'Other than a small mix-up, I would give it a 5.0!',
  '04-01-2020',
  1
);

INSERT INTO review VALUES (
  3,
  3.9,
  'A reasonable place to eat for lunch, if you are in a rush!',
  '03-15-2020',
  1
);

/* 
 *--------------------------------------------
 Insert values for category
 *--------------------------------------------
 */
INSERT INTO category VALUES (
  'C',
  'Chicken',
  null
);

INSERT INTO category VALUES (
  'LS',
  'Luncheon Specials',
  'Served with Hot and Sour Soup or Egg Drop Soup and Fried or Steamed Rice  between 11:00 am and 3:00 pm from Monday to Friday.'
);

INSERT INTO category VALUES (
  'HS',
  'House Specials',
  null
);

/* 
 *--------------------------------------------
 Insert values for dish
 *--------------------------------------------
 */
INSERT INTO dish VALUES (
  1,
  'Chicken with Broccoli',
  'Diced chicken stir-fried with succulent broccoli florets',
  false
);

INSERT INTO dish VALUES (
  2,
  'Sweet and Sour Chicken',
  'Marinated chicken with tangy sweet and sour sauce together with pineapples and green peppers',
  false
);

INSERT INTO dish VALUES (
  3,
  'Chicken Wings',
  'Finger-licking mouth-watering entree to spice up any lunch or dinner',
  true
);

INSERT INTO dish VALUES (
  4,
  'Beef with Garlic Sauce',
  'Sliced beef steak marinated in garlic sauce for that tangy flavor',
  true
);

INSERT INTO dish VALUES (
  5,
  'Fresh Mushroom with Snow Peapods and Baby Corns',
  'Colorful entree perfect for vegetarians and mushroom lovers',
  false
);

INSERT INTO dish VALUES (
  6,
  'Sesame Chicken',
  'Crispy chunks of chicken flavored with savory sesame sauce',
  false
);

INSERT INTO dish VALUES (
  7,
  'Special Minced Chicken',
  'Marinated chicken breast sauteed with colorful vegetables topped with pine nuts and shredded lettuce.',
  false
);

INSERT INTO dish VALUES (
  8,
  'Hunan Special Half & Half',
  'Shredded beef in Peking sauce and shredded chicken in garlic sauce',
  true
);

/*
 *--------------------------------------------
 Insert valus for cross-reference table, categories_dishes
 *--------------------------------------------
 */
INSERT INTO categories_dishes VALUES (
  'C',
  1,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'C',
  3,
  6.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  1,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  4,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'LS',
  5,
  8.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  6,
  15.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  7,
  16.95
);

INSERT INTO categories_dishes VALUES (
  'HS',
  8,
  17.95
);

--10. Displaying column using a custom header --

SELECT id AS description
from review;

--11.Displaying Highest Value in a Colmn --

SELECT MAX(price)
from categories_dishes;

-- Displaying the Dish who Id number is 8 using a Where clause--

SELECT name 
FROM dish
WHERE id = 8 ;

--Displays the names of the specails and put them in Alphebetical order using the order by clause--
SELECT name 
FROM category
order by name ASC ;

--12.Displays the dish name price and category sorted by the dish name --

select d.name as dish_name , c.name as category  , cd.price
from dish d
join categories_dishes cd on d.id = cd.dish_id
join category c on c.id = cd.category_id;

--13. Displays category dish name and price sorted by category names --

select c.name as category , d.name as dish_name , cd.price
from dish d
join categories_dishes cd on d.id = cd.dish_id
join category c on c.id = cd.category_id
order by c.name;

--14 displays all the spicy dishes, their prices and category.-- 

select c.name as spicy_dish_name , cd.category_id as category , cd.price
from dish d 
join categories_dishes cd on d.id = cd.dish_id
join category c on c.id = cd.category_id;


-- 15. Write a query that displays the dish_id and COUNT(dish_id) as dish_count from the categories_dishes table. When we are displaying dish_id along with an aggregate function such as COUNT(), we have to also add a GROUP BY clause which includes dish_id --

select dish_id , count(dish_id) as dish_count 
from categories_dishes
group by dish_id ;


-- 16. adjust the previous query to display only the dish(es) from the categories_dishes table which appears more than once. We can use the aggregate function, COUNT() as a condition. But instead of using the WHERE clause, we use the HAVING clause together with COUNT().--

select dish_id , count(dish_id) as dish_count 
from categories_dishes
group by dish_id 
having count(dish_id) > 1;

--17. Excellent! The previous two queries only give us a dish_id which is not very informative. We should write a better query which tells us exactly the name(s) of the dish that appears more than once in the categories_dishes table. Write a query that incorporates multiple tables that display the dish name as dish_name and dish count as dish_count --

select dish_id, d.name , count(dish_id) as dish_count 
from categories_dishes
join dish d on dish_id = d.id
group by dish_id, d.name
having count(dish_id) > 1;

--18. Our last task is an improvement on Task 11 which was to display the highest rating from the review table using an aggregate function, MAX(column_name). Since the result returned only one column, it is not very informative.--

--best_rating
--5.0
--(1 row
--It would be better if we can also see the actual review itself. Write a query that displays the best rating as best_rating and the description too. In order to do this correctly, we need to have a nested query or subquery. We would place this query in the WHERE clause.--
--Select rating as best_rating , description

Select description, rating as best_rating
from review 
where rating = (select max(rating) from review);