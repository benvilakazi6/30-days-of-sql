# PostgreSQL Relational Database Cheatsheet

Based directly on the uploaded **“Learn Relational Databases by Building a Database of Video Game Characters”** material. 

## 1. PostgreSQL Terminal

### Connect to PostgreSQL

```bash
psql --username=freecodecamp --dbname=postgres
```

### PostgreSQL meta-commands

```sql
\l                  -- List databases
\c database_name    -- Connect to database
\d                  -- List tables
\d table_name       -- Show table details
```

> PostgreSQL commands such as `\l` and `\d` do **not** need `;`.

---

# 2. Databases

### Create a database

```sql
CREATE DATABASE database_name;
```

Example:

```sql
CREATE DATABASE mario_database;
```

### Connect to a database

```sql
\c mario_database
```

### Rename a database

```sql
ALTER DATABASE database_name
RENAME TO new_database_name;
```

### Delete a database

```sql
DROP DATABASE database_name;
```

### List databases

```sql
\l
```

---

# 3. Tables

### Create an empty table

```sql
CREATE TABLE table_name();
```

### Create a table with columns

```sql
CREATE TABLE table_name (
    column_name DATATYPE CONSTRAINTS
);
```

Example:

```sql
CREATE TABLE characters (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    homeland VARCHAR(60),
    favorite_color VARCHAR(30)
);
```

### List tables

```sql
\d
```

### View table structure

```sql
\d table_name
```

### Delete a table

```sql
DROP TABLE table_name;
```

---

# 4. Data Types

| Data type      | Purpose                   | Example        |
| -------------- | ------------------------- | -------------- |
| `INT`          | Whole numbers             | `25`           |
| `SERIAL`       | Auto-incrementing integer | `1, 2, 3...`   |
| `VARCHAR(n)`   | Text with maximum length  | `VARCHAR(30)`  |
| `DATE`         | Date                      | `'1990-04-13'` |
| `NUMERIC(4,1)` | Decimal number            | `59.1`         |

### Example

```sql
birthday DATE
height INT
weight NUMERIC(4,1)
name VARCHAR(30)
```

---

# 5. ALTER TABLE

### Add a column

```sql
ALTER TABLE table_name
ADD COLUMN column_name DATATYPE;
```

Example:

```sql
ALTER TABLE characters
ADD COLUMN age INT;
```

### Drop a column

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

### Rename a column

```sql
ALTER TABLE table_name
RENAME COLUMN old_name TO new_name;
```

Example:

```sql
ALTER TABLE more_info
RENAME COLUMN height TO height_in_cm;
```

### Add a primary key

```sql
ALTER TABLE table_name
ADD PRIMARY KEY(column_name);
```

### Drop a constraint

```sql
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
```

### Add UNIQUE

```sql
ALTER TABLE table_name
ADD UNIQUE(column_name);
```

### Add NOT NULL

```sql
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;
```

---

# 6. INSERT

### Insert one row

```sql
INSERT INTO table_name(column1, column2)
VALUES(value1, value2);
```

Example:

```sql
INSERT INTO characters(name, homeland, favorite_color)
VALUES('Mario', 'Mushroom Kingdom', 'Red');
```

### Insert multiple rows

```sql
INSERT INTO characters(name, homeland, favorite_color)
VALUES
('Mario', 'Mushroom Kingdom', 'Red'),
('Luigi', 'Mushroom Kingdom', 'Green'),
('Peach', 'Mushroom Kingdom', 'Pink');
```

### Important

Text needs single quotes:

```sql
'Mario'
'Red'
'1990-04-13'
```

Numbers do not:

```sql
155
64.5
7
```

---

# 7. SELECT

### Select everything

```sql
SELECT *
FROM table_name;
```

### Select specific columns

```sql
SELECT column1, column2
FROM table_name;
```

Example:

```sql
SELECT character_id, name
FROM characters;
```

### SELECT with WHERE

```sql
SELECT columns
FROM table_name
WHERE condition;
```

Example:

```sql
SELECT character_id, name
FROM characters
WHERE name = 'Toad';
```

---

# 8. WHERE Conditions

### Text

```sql
WHERE name = 'Mario'
```

### Number

```sql
WHERE character_id = 1
```

### Multiple conditions

```sql
WHERE name = 'Mario'
AND homeland = 'Mushroom Kingdom';
```

---

# 9. UPDATE

### Change existing data

```sql
UPDATE table_name
SET column_name = new_value
WHERE condition;
```

Example:

```sql
UPDATE characters
SET favorite_color = 'Orange'
WHERE name = 'Daisy';
```

### ⚠️ Very important

Always be careful with:

```sql
UPDATE characters
SET favorite_color = 'Blue';
```

Without `WHERE`, **every row is updated**.

---

# 10. DELETE

### Delete a specific row

```sql
DELETE FROM table_name
WHERE condition;
```

Example:

```sql
DELETE FROM characters
WHERE name = 'Luigi';
```

### ⚠️ Dangerous

```sql
DELETE FROM characters;
```

This deletes **all rows** from the table.

---

# 11. ORDER BY

### Sort results

```sql
SELECT *
FROM table_name
ORDER BY column_name;
```

Example:

```sql
SELECT *
FROM characters
ORDER BY character_id;
```

### Descending

```sql
SELECT *
FROM characters
ORDER BY character_id DESC;
```

### Ascending

```sql
SELECT *
FROM characters
ORDER BY character_id ASC;
```

---

# 12. Constraints

Constraints control what data can be stored.

### PRIMARY KEY

Uniquely identifies each row.

```sql
character_id SERIAL PRIMARY KEY
```

Only **one primary key** per table.

---

### NOT NULL

Requires a value.

```sql
name VARCHAR(30) NOT NULL
```

---

### UNIQUE

Prevents duplicate values.

```sql
filename VARCHAR(40) UNIQUE
```

---

### FOREIGN KEY

Connects one table to another.

```sql
character_id INT
REFERENCES characters(character_id)
```

Or:

```sql
ALTER TABLE table_name
ADD FOREIGN KEY(column_name)
REFERENCES referenced_table(referenced_column);
```

---

# 13. SERIAL

`SERIAL` automatically creates an integer value that increments when rows are inserted.

```sql
character_id SERIAL PRIMARY KEY
```

Typical values:

```text
1
2
3
4
5
```

PostgreSQL also creates a sequence to generate the next value. 

---

# 14. Foreign Keys

A foreign key connects tables.

Example:

### characters

```text
character_id
name
```

### more_info

```text
more_info_id
character_id
birthday
height
weight
```

The relationship:

```text
characters.character_id
          ↓
more_info.character_id
```

Create it:

```sql
ALTER TABLE more_info
ADD COLUMN character_id INT
REFERENCES characters(character_id);
```

---

# 15. One-to-One Relationship

Example:

```text
characters  ───────  more_info
    1                    1
```

One character has one `more_info` record.

To enforce this:

```sql
ALTER TABLE more_info
ADD UNIQUE(character_id);
```

And:

```sql
ALTER TABLE more_info
ALTER COLUMN character_id SET NOT NULL;
```

The tutorial uses this structure for `characters` and `more_info`. 

---

# 16. One-to-Many Relationship

Example:

```text
characters
     1
     |
     |
     ∞
   sounds
```

One character can have many sounds.

```text
Mario
 ├── its-a-me.wav
 ├── yippee.wav
 └── yahoo.wav
```

The `sounds` table contains:

```sql
character_id INT NOT NULL
REFERENCES characters(character_id)
```



---

# 17. Many-to-Many Relationship

Example:

```text
characters  ←→  actions
```

Many characters can perform many actions.

Instead of connecting them directly, create a **junction table**:

```text
characters
     ↓
character_actions
     ↑
actions
```

The tutorial uses:

```text
characters
actions
character_actions
```



---

# 18. Junction Table

### Create it

```sql
CREATE TABLE character_actions();
```

### Add character foreign key

```sql
ALTER TABLE character_actions
ADD COLUMN character_id INT NOT NULL;
```

```sql
ALTER TABLE character_actions
ADD FOREIGN KEY(character_id)
REFERENCES characters(character_id);
```

### Add action foreign key

```sql
ALTER TABLE character_actions
ADD COLUMN action_id INT NOT NULL;
```

```sql
ALTER TABLE character_actions
ADD FOREIGN KEY(action_id)
REFERENCES actions(action_id);
```

---

# 19. Composite Primary Key

A primary key can use **two columns together**.

```sql
ALTER TABLE character_actions
ADD PRIMARY KEY(character_id, action_id);
```

This means:

```text
character_id + action_id
```

must be unique as a combination.

Example:

```text
character_id | action_id
-------------+----------
1            | 1
1            | 2
1            | 3
2            | 1
2            | 2
2            | 3
```

A character can appear multiple times, and an action can appear multiple times, but the **same combination** cannot appear twice. 

---

# 20. JOIN

JOIN combines related tables.

### Basic JOIN

```sql
SELECT columns
FROM table_1
FULL JOIN table_2
ON table_1.primary_key = table_2.foreign_key;
```

Example:

```sql
SELECT *
FROM characters
FULL JOIN more_info
ON characters.character_id = more_info.character_id;
```

---

# 21. Joining Three Tables

For:

```text
characters
actions
character_actions
```

Use:

```sql
SELECT *
FROM character_actions
FULL JOIN characters
ON character_actions.character_id = characters.character_id
FULL JOIN actions
ON character_actions.action_id = actions.action_id;
```

This lets you see:

```text
Character → Action
```

For example:

```text
Mario → run
Mario → jump
Mario → duck
```



---

# 22. Complete Database Structure

The final database contains five main tables:

```text
characters
    │
    ├────────── more_info
    │
    └────────── sounds
                 
actions
    │
    └────────── character_actions
                     │
                     └──── characters
```

### `characters`

```text
character_id
name
homeland
favorite_color
```

### `more_info`

```text
more_info_id
birthday
height_in_cm
weight_in_kg
character_id
```

### `sounds`

```text
sound_id
filename
character_id
```

### `actions`

```text
action_id
action
```

### `character_actions`

```text
character_id
action_id
```

---

# 23. Most Important Commands to Memorize

If you're studying for practical SQL work, memorize these first:

```sql
-- DATABASE
CREATE DATABASE database_name;
DROP DATABASE database_name;
ALTER DATABASE database_name RENAME TO new_name;

-- TABLE
CREATE TABLE table_name (...);
DROP TABLE table_name;

-- INSPECT
\l
\c database_name
\d
\d table_name

-- ALTER
ALTER TABLE table_name ADD COLUMN column_name DATATYPE;
ALTER TABLE table_name DROP COLUMN column_name;
ALTER TABLE table_name RENAME COLUMN old_name TO new_name;

-- INSERT
INSERT INTO table_name(column1, column2)
VALUES(value1, value2);

-- SELECT
SELECT * FROM table_name;
SELECT column1, column2 FROM table_name;
SELECT * FROM table_name WHERE condition;

-- UPDATE
UPDATE table_name
SET column = value
WHERE condition;

-- DELETE
DELETE FROM table_name
WHERE condition;

-- SORT
SELECT *
FROM table_name
ORDER BY column_name;

-- PRIMARY KEY
ALTER TABLE table_name
ADD PRIMARY KEY(column_name);

-- FOREIGN KEY
ALTER TABLE table_name
ADD FOREIGN KEY(column_name)
REFERENCES other_table(other_column);

-- UNIQUE
ALTER TABLE table_name
ADD UNIQUE(column_name);

-- NOT NULL
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;

-- JOIN
SELECT *
FROM table1
FULL JOIN table2
ON table1.id = table2.id;
```

## 🧠 Relationship Cheat Sheet

| Relationship      | Meaning                         | Typical implementation    |
| ----------------- | ------------------------------- | ------------------------- |
| **One-to-one**    | 1 character → 1 extra record    | Foreign key + `UNIQUE`    |
| **One-to-many**   | 1 character → many sounds       | Foreign key               |
| **Many-to-many**  | Many characters ↔ many actions  | Junction table            |
| **Primary key**   | Uniquely identifies a row       | `PRIMARY KEY`             |
| **Foreign key**   | Links tables                    | `REFERENCES`              |
| **Composite key** | Multiple columns identify a row | `PRIMARY KEY(col1, col2)` |

### The key pattern to remember

```text
PRIMARY KEY
     ↓
FOREIGN KEY
     ↓
RELATIONSHIP
     ↓
JOIN
```

This is the core concept running through the entire tutorial. 
