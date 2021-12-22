-- Task: Find the unique number of accounts
-- for each participant either sender or receiver
SELECT
  participant,
  count(DISTINCT iban) AS nb_of_unique_accounts
FROM
  (
    SELECT
      sender AS participant,
      sender_iban AS iban
    FROM
      messages
    UNION ALL
    SELECT
      receiver AS participant,
      receiver_iban AS iban
    FROM
      messages
  ) AS tbl
GROUP BY
  participant;
