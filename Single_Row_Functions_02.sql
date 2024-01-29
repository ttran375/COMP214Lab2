-- 2. Create a list of all customer numbers along with text indicating whether the customer has been referred by another customer. Display the text “NOT REFERRED” if the customer wasn’t referred to JustLee Books by another customer or “REFERRED” if the customer was referred.
SELECT
    Customer#,
    CASE
        WHEN Referred IS NULL THEN 'NOT REFERRED'
        ELSE 'REFERRED'
    END AS ReferralStatus
FROM
    Customers;
