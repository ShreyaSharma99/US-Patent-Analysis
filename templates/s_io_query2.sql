SELECT DB1.name as name, DB1.transaction_count, COALESCE(COUNT(DB2.patent_count), 0) as patent_count
FROM 
((SELECT assignor.or_name as name, COUNT(DISTINCT assignor.rf_id) as transaction_count
FROM assignor
WHERE assignor.or_name LIKE '{}'
GROUP BY assignor.or_name) as DB1
LEFT JOIN (SELECT assignor.or_name as name, COUNT(DISTINCT documentid.appno_doc_num) as patent_count
FROM (documentid
LEFT JOIN assignor ON assignor.rf_id = documentid.rf_id)
WHERE assignor.or_name LIKE '{}'
GROUP BY assignor.or_name) as DB2 ON DB1.name = DB2.name)
GROUP BY DB1.name, DB1.transaction_count, DB2.patent_count
ORDER BY DB1.name;
-- Assignor Query --
-- Input : Assignor name. EX: ATALA, ANTHONY
-- Output : Name | Traqnsaction_count | Patent_count
