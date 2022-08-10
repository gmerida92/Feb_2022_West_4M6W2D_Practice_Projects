-- Balance Transfer Transactions
-- Rollback SQL Statements
BEGIN TRANSACTION;

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  -- Update balance for Rose Tyle to 800
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Amy'
      AND last_name = 'Pond'
    );
  -- Update balance for Amy Pond to 2300

  SAVEPOINT amy_to_rose;
  -- Save the previous data from the users Amy and Rose

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  -- Update balance for Rose Tyle to 1000
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Martha'
      AND last_name = 'Jones'
    );
  -- Update balance for Martha Jones to 2800

  SAVEPOINT martha_to_rose;
  -- Save the previous data from the users Martha and Rose

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  -- Update balance for Rose Tyle to 1200
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'Donna'
      AND last_name = 'Noble'
    );
  -- Update balance for Donna Noble to 0

  SAVEPOINT donna_to_rose;
  -- Save the previous data from the users Donna and Rose

  ROLLBACK TO martha_to_rose;
  -- All transaccions did not happen after the savepoint martha_to_rose
  -- Rose balance will be back to 1000
  -- Donna balance will back to 200

  UPDATE accounts
  SET balance = balance + 200
  WHERE (
      first_name = 'Rose'
      AND last_name = 'Tyler'
    );
  -- Update balance for Rose Tyle to 1200
  UPDATE accounts
  SET balance = balance - 200
  WHERE (
      first_name = 'River'
      AND last_name = 'Song'
    );
  -- Update balance for River Song to 1000
  SAVEPOINT river_to_rose;
  -- Save the previous data from the users River and Rose

COMMIT;
-- Save all the transaccions
-- Check results of SQL statements
SELECT * 
FROM accounts;

-- After executing:
-- | `id` | `first_name` | `last_name` | `balance` |
-- | ---- | ------------ | ----------- | --------- |
-- | 1    | Amy          | Pond        | 2300      |
-- | 2    | Rose         | Tyler       | 1200      |
-- | 3    | Martha       | Jones       | 2800      |
-- | 4    | Donna        | Nobles      | 200      |
-- | 5    | River        | Song        | 1000      |
