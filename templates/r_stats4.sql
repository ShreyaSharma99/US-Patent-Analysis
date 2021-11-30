SELECT qfin.convey_ty AS type_of_transaction, qfin.error, COALESCE(fin.frequency,0) AS case_count FROM
(SELECT ans.type_of_transaction, ans.error, COUNT(*) AS frequency FROM
(SELECT ac.convey_ty AS type_of_transaction, dadmin.rf_id, dadmin.error FROM
DOCUMENTED_ADMIN as dadmin 
INNER JOIN assignment_conveyance AS ac 
ON ac.rf_id = dadmin.rf_id) AS ans
GROUP BY ans.type_of_transaction, ans.error) AS fin
RIGHT JOIN
(SELECT conv.convey_ty, dadmin.error FROM
(SELECT DISTINCT ac.convey_ty FROM 
assignment_conveyance AS ac) AS conv,
(SELECT DISTINCT error FROM DOCUMENTED_ADMIN) as dadmin) AS qfin
ON fin.type_of_transaction = qfin.convey_ty AND fin.error = qfin.error
ORDER BY qfin.convey_ty, qfin.error;
--6--
-- Returns the frequency of each type of error for each type of transaction
