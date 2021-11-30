SELECT start.year, AVG(record_dt - execn_date) AS avg_lag FROM
(SELECT rf_id, MAX(exec_dt) AS execn_date FROM
assignor 
WHERE exec_dt IS NOT NULL
GROUP BY rf_id) AS fin
INNER JOIN
(SELECT rf_id, record_dt, EXTRACT(YEAR FROM record_dt) AS year
FROM assignment
WHERE record_dt IS NOT NULL) AS start
ON start.rf_id = fin.rf_id
GROUP BY start.year
ORDER BY start.year;
--2--
-- Average lag in recording of transaction at USPTO averaged over all the transactions in the year.
