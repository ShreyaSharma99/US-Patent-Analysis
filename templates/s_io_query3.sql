SELECT DB1.name as name, DB1.transaction_count, DB2.patent_count, COALESCE(COUNT(DB3.error_count), 0) as error_count, 1 - (COALESCE(COUNT(DB3.error_count), 0)/DB1.transaction_count) as efficiency
FROM 
(((SELECT assignment.cname as name, COUNT(DISTINCT assignment.rf_id) as transaction_count
FROM assignment
WHERE assignment.cname LIKE '{}'
GROUP BY assignment.cname) as DB1
LEFT JOIN 
(SELECT assign.cname as name, COUNT(DISTINCT documentid.appno_doc_num) as patent_count
FROM ((SELECT assignment.rf_id, assignment.cname FROM assignment WHERE assignment.cname = '{}') as assign
RIGHT JOIN documentid ON assign.rf_id = documentid.rf_id)
GROUP BY assign.cname) as DB2 
ON DB1.name = DB2.name)
LEFT JOIN
(SELECT assign.cname as name, COALESCE(COUNT(documented_admin.error), 0) as error_count
FROM (( (SELECT assignment.rf_id, assignment.cname FROM assignment WHERE assignment.cname = '{}') as assign
LEFT JOIN documentid ON assign.rf_id = documentid.rf_id)
LEFT JOIN documented_admin ON documentid.rf_id = documented_admin.rf_id AND documentid.appno_doc_num = documented_admin.appno_doc_num AND documentid.grant_doc_num = documented_admin.grant_doc_num)
WHERE NOT documented_admin.error = 'none'
GROUP BY assign.cname) as DB3 
ON DB1.name = DB3.name)
GROUP BY DB1.name, DB1.transaction_count, DB2.patent_count, DB3.error_count
ORDER BY DB1.name;
-- Correspondent Query --
-- Input : Assignor name. EX: BANK OF BOSTON
-- Output : Name | Traqnsaction_count | Patent_count
