SELECT EXTRACT(year FROM assignment.record_dt) as year, COUNT(DISTINCT assignment.rf_id) as transection_count
FROM assignment
GROUP BY EXTRACT(year FROM assignment.record_dt);
-- s_stats1-form-handler
--Year-wise number transactions filed--
