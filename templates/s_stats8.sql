SELECT EXTRACT(year FROM assignor.exec_dt) as year, assignment_conveyance.convey_ty, COALESCE(COUNT(DISTINCT documentid.rf_id), 0) as patent_count
FROM (((assignment
INNER JOIN assignment_conveyance ON assignment_conveyance.rf_id = assignment.rf_id)
LEFT JOIN assignor ON assignor.rf_id = assignment.rf_id)
RIGHT JOIN documentid ON documentid.rf_id = assignment.rf_id)
WHERE NOT documentid.appno_doc_num in (SELECT documentid.appno_doc_num
										FROM (documentid
										LEFT JOIN assignment_conveyance ON documentid.rf_id = assignment_conveyance.rf_id)
										WHERE assignment_conveyance.convey_ty = 'release')
GROUP BY EXTRACT(year FROM assignor.exec_dt), assignment_conveyance.convey_ty
ORDER BY EXTRACT(year FROM assignor.exec_dt), assignment_conveyance.convey_ty;
-- s_stats8-form-handler
--Fig8--
