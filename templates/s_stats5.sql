SELECT EXTRACT(year FROM assignor.exec_dt) as year, COALESCE(COUNT(DISTINCT documentid.rf_id), 0) as patent_count
FROM ((assignment
LEFT JOIN assignor ON assignor.rf_id = assignment.rf_id)
RIGHT JOIN documentid ON documentid.rf_id = assignment.rf_id)
GROUP BY EXTRACT(year FROM assignor.exec_dt);
-- s_stats5-form-handler
--Fig 2 (b)
