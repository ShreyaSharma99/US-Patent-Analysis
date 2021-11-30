SELECT assignor.or_name as Assignor_name, assignee.ee_name as Assignee_name, documentid.rf_id, documentid.title as patent, assignor.exec_dt as date, assignment_conveyance.convey_ty
FROM (((assignor  
INNER JOIN assignee ON assignee.rf_id = assignor.rf_id)
LEFT JOIN assignment_conveyance ON assignment_conveyance.rf_id = assignor.rf_id)
INNER JOIN documentid ON documentid.rf_id = assignment_conveyance.rf_id)
WHERE assignor.or_name LIKE '{}' AND assignee.ee_name LIKE '{}'
GROUP BY assignor.or_name, assignee.ee_name, documentid.rf_id, documentid.title, assignor.exec_dt, assignment_conveyance.convey_ty
ORDER BY assignor.exec_dt;
-- Assignor - Assignee Query --
-- Input : Assignor name, Assignee name EX: GOULD INC., ELECTRIC POWER RESEARCH INSTITUTE
-- Output : Assignor_name, Assignee_name, documentid.rf_id, patent, date, convey_type
