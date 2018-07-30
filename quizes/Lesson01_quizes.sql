/*
 * A quick note about this file. I only started taking detailed notes about
 * halfway into the lesson. So the first half of quiz answers are not in here
 * and the first few quizes that are dont have their questions written donw.
 */

SELECT occurred_at, account_id, channel
FROM web_events
ORDER BY occurred_at
LIMIT 1000;

/***********************************************
   Lesson 1.19 | Quiz: ORDER BY 
 ***********************************************/
/* Question 1 */
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/* Question 2 */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* Question 3 */
/* Note that 'ASC' is not strictly necessary here */
SELECT id, account_id, total
FROM orders
ORDER BY total ASC
LIMIT 20;


/***********************************************
   Lesson 1.22 | Quiz: ORDER BY Part II
 ***********************************************/

/* Question 1 */
SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;

/* Question 2 */
SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;


/***********************************************
   Lesson 1.25 | Quiz: WHERE
 ***********************************************/

/* Question 1:
   Pull the first 5 rows and all columns from the orders table that have a 
   dollar amount of gloss_amt_usd greater than or equal to 1000.
 */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* Question 2:
   Pull the first 10 rows and all columns from the orders table that have a 
   total_amt_usd less than 500.
 */
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;


/***********************************************
   Lesson 1.28 | Quiz: WHERE with Non-numeric data
 ***********************************************/

/* Question 1:
   Filter the accounts table to include the company name, website, and the 
   primary point of contact (primary_poc) for Exxon Mobil in the accounts table.
 */
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


/***********************************************
   Lesson 1.31 | Quiz: Arithmetic operators
 ***********************************************/

/* Question 1:
   Create a column that divides the standard_amt_usd by the standard_qty to find
   the unit price for standard paper for each order. Limit the results to the 
   first 10 orders, and include the id and account_id fields.
*/
SELECT id, account_id, standard_amt_usd / standard_qty AS new_column
FROM orders
LIMIT 10;

/* Question 2:
   Write a query that finds the percentage of revenue that comes from poster 
   paper for each order. You will need to use only the columns that end with 
   _usd. (Try to do this without using the total column). Include the id and 
   account_id fields.
*/
SELECT id, account_id, poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_pcnt
FROM orders;


/***********************************************
   Lesson 1.35 | Quiz: LIKE
 ***********************************************/

/* Question 1:
   Use the accounts table to find all the companies whose names start with 'C'
 */
SELECT name
FROM accounts
WHERE name LIKE 'C%';

/* Question 2:
   Use the accounts table to find all companies whose names contain the string 
   'one' somewhere in the name
 */
SELECT name
FROM accounts
WHERE name LIKE '%one%';

/* Question 3:
   Use the accounts table to find all companies whose names end with 's'.
 */
SELECT name
FROM accounts
WHERE name LIKE '%s';


/***********************************************
   Lesson 1.38 | Quiz: IN
 ***********************************************/

/* Question 1:
   Use the accounts table to find the account name, primary_poc, and 
   sales_rep_id for Walmart, Target, and Nordstrom.
 */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* Question 2:
   Use the web_events table to find all information regarding individuals who 
   were contacted via the channel of organic or adwords.
 */
SELECT * 
FROM web_events
WHERE channel IN ('organic', 'adwords');


/***********************************************
   Lesson 1.41 | Quiz: NOT
 ***********************************************/

/*** PART 1 ***/

/* Question 1:
   Use the accounts table to find the account name, primary poc, and sales rep 
   id for all stores except Walmart, Target, and Nordstrom.
 */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/* Question 2:
   Use the web_events table to find all information regarding individuals who 
   were contacted via any method except using organic or adwords methods.
 */
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/*** PART 2 ***/

/* Question 1:
   Use the accounts table to find all the companies whose names do not start 
   with 'C'.
 */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%'
ORDER BY name;  /* this line is not part of the answer, but more useful to make sure it's correct' */

/* Question 2:
   Use the accounts table to find all companies whose names do not contain the 
   string 'one' somewhere in the name.
 */
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

/* Question 3:
   Use the accounts table to find all companies whose names do not end with 's'.
 */
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';


/***********************************************
   Lesson 1.44 | Quiz: AND and BETWEEN
 ***********************************************/

/* Question 1:
   Write a query that returns all the orders where the standard_qty is over 
   1000, the poster_qty is 0, and the gloss_qty is 0.
 */
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

/* Question 2:
   Using the accounts table find all the companies whose names do not start with
   'C' and end with 's'.
 */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/* Question 3:
   Use the web_events table to find all information regarding individuals who 
   were contacted via organic or adwords and started their account at any point 
   in 2016 sorted from newest to oldest.
 */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;
/* Note in the above that the timestamp is a little special and so we extend it 
   by one day to ensure it encloses the full day of december 31. */


/***********************************************
   Lesson 1.47 | Quiz: OR
 ***********************************************/

/* Question 1:
   Find list of orders ids where either gloss_qty or poster_qty is greater than 
   4000. Only include the id field in the resulting table.
 */
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/* Question 2:
   Write a query that returns a list of orders where the standard_qty is zero 
   and either the gloss_qty or poster_qty is over 1000.
 */
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

/* Question 3:
   Find all the company names that start with a 'C' or 'W', and the primary 
   contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
 */
SELECT name, primary_poc
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
  AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
       AND primary_poc NOT LIKE '%eana%');
       