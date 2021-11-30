WITH pats AS (
	SELECT COALESCE(did.grant_doc_num, '--MISSING--') AS patent_number, did.title, did.rf_id FROM
	DOCUMENTID as did
	WHERE (did.title LIKE '%' || '{}'::text || '%')	
), anor AS (
	SELECT rf_id, or_name, exec_dt FROM assignor
)
SELECT qfin.patent_number, qfin.title, STRING_AGG(qfin.owners, ', ' ORDER BY qfin.owners) AS patent_owners FROM
(SELECT distinct fin.patent_number, fin.title, fin.ee_name AS owners FROM
(SELECT anees.patent_number, anees.title, anees.ee_name, anors.or_name, anors.last_trans_date, anees.last_assign_date FROM
(SELECT anor.or_name, MAX(anor.rf_id) AS last_trans_date, pats.patent_number, pats.title FROM 
pats INNER JOIN anor
ON anor.rf_id = pats.rf_id
GROUP BY pats.patent_number, pats.title, anor.or_name) AS anors
RIGHT JOIN 
(SELECT anee.ee_name, pats.patent_number, pats.title, MAX(anee.rf_id) AS last_assign_date FROM
pats INNER JOIN assignee AS anee
ON anee.rf_id = pats.rf_id
GROUP BY pats.patent_number, pats.title, anee.ee_name) AS anees
ON (anees.ee_name = anors.or_name) OR (anees.ee_name LIKE '%' || anors.or_name || '%') OR (anors.or_name LIKE '%' || anees.ee_name || '%')) AS fin
WHERE fin.or_name IS NULL OR (fin.last_assign_date > fin.last_trans_date)) AS qfin
WHERE qfin.owners IS NOT NULL
GROUP BY qfin.patent_number, qfin.title;
