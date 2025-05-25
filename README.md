# Here are some PostgreSQL questions and answers.

### 1. What is PostgreSQL?

PostgreSQL is a powerfull open-source (RDBMS) Relational Database Management System. It's used to store and manage structure data.

### 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

#### **Primary Key**

A Primary key in PostgreSQL (and any relational database) is used to uniquely identify a record in a table.
Each table _should_ have one primary key.

- Uniqueness: The value in the primary key column(s) must be unique across all rows.

- Not Null: It cannot be NULL — because how would you identify something uniquely if it's unknown?

- Only one per table: A table can have only one primary key, but it can be composite (i.e., span multiple columns).

```
CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      full_name VARCHAR(60),
      email VARCHAR(70) UNIQUE
);
```

#### **Foreign Key**

A Foreign key is a column (or group of columns) that establishes to link **between two tables**.It "points to" primary key in another table.

- ON DELETE CASCADE: Delete the child rows too.

- ON DELETE SET NULL: Set the foreign key in the child to NULL.

- ON DELETE RESTRICT: Disallow deletion.

```

CREATE TABLE orders (
      id SERIAL PRIMARY KEY,
      user_id INT REFERENCES users(id) ON DELETE CASCADE,
      amount NUMERIC
);
// user_id is a Foreign key in order table

```

This means each order must belong to a user — and if the user is deleted, their orders go with them (because of ON DELETE CASCADE).

#### In Short:

| Concept     | Purpose                               | Uniqueness | NULL Allowed  | Multiple per Table? |
| ----------- | ------------------------------------- | ---------- | ------------- | ------------------- |
| Primary Key | Uniquely identifies a row             | Yes        | No            | Only one            |
| Foreign Key | Links to a primary key in another row | No         | Yes (usually) | Yes                 |

### 3. What is the difference between the VARCHAR and CHAR data types?

- VARCHAR data type is used to variable-length character strings "text". It allowing store strings of varying lengths without padding.

- CHAR data type is a fixed-length data type. It always stores a string in defined length, even if actual string is shorter.

### 4. Explain the purpose of the WHERE clause in a SELECT statement.

The WHERE clause in a SELECT statement filters which rows should be returned — it’s like saying, “Only give me the rows, Those age over 22 years old”.

Example:

```
SELECT * FROM person
      WHERE age > 22;
```

### 5. What are the LIMIT and OFFSET clauses used for?

The LIMIT and OFFSET clauses are used in SQL to control number of rows by returned a query. Especially for pagination.

- LIMIT : How many rows to return, It restricts the maximum number of records the query will return.

- OFFSET : Where to start returning, It tells SQL to skip a certain number of rows before starting to return results.

### 6. How can you modify data using UPDATE statements?

UPDATE statements it changes existing row in a table.

**Basic syntex:**

```
UPDATE table_name
SET colum = value
WHERE condition;
```

**Usage example:**

```
-- Single Column

UPDATE users
SET email = 'new@gmail.com'
WHERE id = 3;
      ✅ Updates the email address for the user with ID 3.

-- Multiple Columns

UPDATE products
SET price = price * 1.10, stock = stock - 2
WHERE category = 'electronics';
      ✅ Increases prices by 10% and reduces stock for all electronics.

-- Without WHERE (dangerous)

UPDATE users
set role = 'admin';
      ⚠️ Updates every row in the users table, making everyone an admin.

```