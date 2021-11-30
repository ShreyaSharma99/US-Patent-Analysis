SELECT EXTRACT(year FROM assignor.exec_dt) as year, COUNT(DISTINCT documentid.rf_id) as patent_count
FROM (((assignment
LEFT JOIN assignor ON assignor.rf_id = assignment.rf_id)
LEFT JOIN assignment_conveyance ON assignment_conveyance.rf_id = assignment.rf_id)
RIGHT JOIN documentid ON documentid.rf_id = assignment.rf_id)
WHERE NOT (assignment_conveyance.convey_ty = 'release')
GROUP BY EXTRACT(year FROM assignor.exec_dt);
-- s_stats3-form-handler
--count of patents-in-fore yearwise--
