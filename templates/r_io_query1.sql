SELECT fin.rf_id, fin.title, fin.convey_ty, fin.assignor_name, anee.ee_name AS assignee_name, fin.trans_date FROM
(SELECT ans.rf_id, ans.title, ans.convey_ty, anor.or_name AS assignor_name, anor.exec_dt AS trans_date FROM
(SELECT ids.rf_id, ids.title, con.convey_ty FROM
(SELECT rf_id, title FROM DOCUMENTID WHERE grant_doc_num = {}::text) AS ids
INNER JOIN assignment_conveyance AS con
ON con.rf_id = ids.rf_id) AS ans
INNER JOIN assignor AS anor 
ON anor.rf_id = ans.rf_id) AS fin
INNER JOIN assignee AS anee 
ON anee.rf_id = fin.rf_id
ORDER BY fin.trans_date;
--4--
--Tracking a patent by its number. Input is the patent number(data type string) you want to search for. Output: Transaction records with assignor and assignee name and date of transaction
