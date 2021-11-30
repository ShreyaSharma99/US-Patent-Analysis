SELECT start.convey_ty, start.year, AVG(record_dt - execn_date) AS avg_lag FROM
(SELECT rf_id, MAX(exec_dt) AS execn_date FROM
assignor 
WHERE exec_dt IS NOT NULL
GROUP BY rf_id) AS fin
INNER JOIN
(SELECT asgn.rf_id, asgn.record_dt, EXTRACT(YEAR FROM asgn.record_dt) AS year, ac.convey_ty
FROM assignment AS asgn 
INNER JOIN assignment_conveyance AS ac
ON ac.rf_id = asgn.rf_id
WHERE asgn.record_dt IS NOT NULL) AS start
ON start.rf_id = fin.rf_id
GROUP BY start.convey_ty, start.year
ORDER BY start.convey_ty,start.year;
--3-- By Conveyance Type
-- Average lag in the recording of transaction at USPTO for different types of transactions over the years.
