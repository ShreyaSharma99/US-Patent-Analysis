CREATE or replace VIEW assignor_assignee_edge AS 
SELECT did.grant_doc_num AS patent_number, ans.or_name, ans.ee_name FROM
(SELECT anor.rf_id, anor.or_name, anee.ee_name FROM
(SELECT rf_id, or_name FROM
assignor) AS anor
INNER JOIN
(SELECT rf_id, ee_name FROM
assignee) AS anee
ON anor.rf_id = anee.rf_id) AS ans 
INNER JOIN DOCUMENTID as did
ON did.rf_id = ans.rf_id
WHERE did.grant_doc_num IS NOT NULL;

WITH RECURSIVE Path AS(
	SELECT aae.patent_number, aae.or_name AS assignor_name, aae.ee_name AS assignee_name
	FROM assignor_assignee_edge AS aae WHERE aae.or_name = '{}'
	UNION
	SELECT Path.patent_number, Path.assignor_name, aae.ee_name AS assignee_name FROM
	Path, assignor_assignee_edge AS aae
	WHERE (Path.assignee_name = aae.or_name OR (Path.assignee_name LIKE '%' || aae.or_name || '%') OR (aae.or_name LIKE '%' || Path.assignee_name || '%')) AND Path.patent_number = aae.patent_number
)
SELECT patent_number, assignee_name FROM Path
ORDER BY patent_number, assignee_name;

--7--
-- Input: Assignor Name. Ex: 'BUTLER, DOUGLAS'
-- Output: (patent_number, assignee_name)
