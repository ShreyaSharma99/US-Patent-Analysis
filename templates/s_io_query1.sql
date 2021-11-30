SELECT DB1.name as name, DB1.transaction_count, COALESCE(COUNT(DB2.patent_count), 0) as patent_count
FROM 
((SELECT assignee.ee_name as name, COUNT(DISTINCT assignee.rf_id) as transaction_count
FROM assignee
WHERE (CASE WHEN LENGTH(assignee.ee_name) > 0 THEN (LEFT(assignee.ee_name, 1) = '{}') OR (LEFT(assignee.ee_name, 1) = '{}') ELSE false END) AND assignee.ee_country LIKE '{}'
GROUP BY assignee.ee_name) as DB1
INNER JOIN (SELECT assignee.ee_name as name, COUNT(DISTINCT documentid.appno_doc_num) as patent_count
FROM (documentid
LEFT JOIN assignee ON assignee.rf_id = documentid.rf_id)
WHERE (CASE WHEN LENGTH(assignee.ee_name) > 0 THEN (LEFT(assignee.ee_name, 1) = '{}') OR (LEFT(assignee.ee_name, 1) = '{}') ELSE false END) AND assignee.ee_country LIKE '{}'
GROUP BY assignee.ee_name) as DB2 ON DB1.name = DB2.name)
GROUP BY DB1.name, DB1.transaction_count, DB2.patent_count
ORDER BY DB1.name;
-- Assignee Query --
-- Input : alphabet, country (All capital)
-- Output : Name | Traqnsaction_count | Patent_count
-- a A INDIA a A INDIA
