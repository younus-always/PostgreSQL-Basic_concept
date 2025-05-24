## Here are some PostgreSQL questions and answers.

#### What is PostgreSQL?
PostgreSQL is a powerfull open-source relational database management system. It's used to store and manage structure data.

#### What is the purpose of a database schema in PostgreSQL?
--
#### Explain the Primary Key and Foreign Key concepts in PostgreSQL.


#### What is the difference between the VARCHAR and CHAR data types?
-- VARCHAR
The VARCHAR data type is used to variable-length character strings "text". It allowing store strings of varying lengths without padding.
-- CHAR
The CHAR data type is a fixed-length data type. It always stores a string in defined length, even if actual string is shorter.

#### Explain the purpose of the WHERE clause in a SELECT statement.
The WHERE clause in a SELECT statement filters which rows should be returned — it’s like saying, “Only give me the rows, Those aged are greater than 22 years old”
Example :
```
SELECT * FROM person
      WHERE age > 22;
```

#### What are the LIMIT and OFFSET clauses used for?
The LIMIT and OFFSET clauses are used in SQL to control number of rows by returned a query. Especially for pagination.
-- LIMIT : How many rows to return, It restricts the maximum number of records the query will return.
-- OFFSET : Where to start returning, It tells SQL to skip a certain number of rows before starting to return results.

#### How can you modify data using UPDATE statements?
-- UPDATE statements it changes existing row in a table.
Basic syntex:
UPDATE table_name
SET colum = value
WHERE condition;

```
Single Column
UPDATE users
      SET email = 'new@gmail.com'
      WHERE id = 3;
✅ Updates the email address for the user with ID 3.

Multiple Columns
UPDATE products
      SET price = price * 1.10, stock = stock - 2
      WHERE category = 'electronics'; 
✅ Increases prices by 10% and reduces stock for all electronics.

Without WHERE (dangerous)
UPDATE users
      set role = 'admin';
⚠️ Updates every row in the users table, making everyone an admin.

```

#### What is the significance of the JOIN operation, and how does it work in PostgreSQL?
--
#### Explain the GROUP BY clause and its role in aggregation operations.
--
#### How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
--