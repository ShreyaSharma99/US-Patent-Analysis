WITH ids AS(
	SELECT DISTINCT rf_id FROM 
	DOCUMENTID WHERE GRANT_DOC_NUM = '{}'
)
DELETE FROM ASSIGNMENT
WHERE RF_ID IN (SELECT * FROM ids);
--DELETE--
--Input: PATENT_NUMBER
-- Action: Delete all transactions corresponding to it.
-- Delete CASCADE. All tables refer to DOCUMENTID
