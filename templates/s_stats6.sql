SELECT EXTRACT(year FROM assignor.exec_dt) as year, assignment_conveyance.convey_ty, COALESCE(COUNT(DISTINCT documentid.rf_id), 0) as patent_count
FROM ((assignment
LEFT JOIN assignment_conveyance ON assignment_conveyance.rf_id = assignment.rf_id)
LEFT JOIN assignor ON assignor.rf_id = assignment.rf_id)
GROUP BY EXTRACT(year FROM assignor.exec_dt), assignment_conveyance.convey_ty;
-- s_stats6-form-handler
--11 : Fig6--
