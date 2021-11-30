SELECT EXTRACT(year FROM assignor.exec_dt) as year, COALESCE(COUNT(DISTINCT assignment.rf_id), 0) as rf_count
FROM (assignment
LEFT JOIN assignor ON assignor.rf_id = assignment.rf_id)
GROUP BY EXTRACT(year FROM assignor.exec_dt);
--Fig 2 (a)--
-- s_stats4-form-handler
