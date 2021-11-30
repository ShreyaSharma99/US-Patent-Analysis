SELECT * 
FROM (
	SELECT EXTRACT(year FROM documentid.appno_date) as year, EXTRACT(month FROM documentid.appno_date) as month, COUNT(DISTINCT documentid.rf_id) as patent_count, ROW_NUMBER() OVER (PARTITION BY EXTRACT(year FROM documentid.appno_date) ORDER BY COUNT(DISTINCT documentid.rf_id) DESC) as rank
	FROM (documentid
	LEFT JOIN assignment_conveyance ON assignment_conveyance.rf_id = documentid.rf_id)
	WHERE assignment_conveyance.convey_ty LIKE 'assignment'
	GROUP BY EXTRACT(year FROM documentid.appno_date), EXTRACT(month FROM documentid.appno_date)
	ORDER BY EXTRACT(year FROM documentid.appno_date), ROW_NUMBER() OVER (PARTITION BY EXTRACT(year FROM documentid.appno_date) ORDER BY COUNT(DISTINCT documentid.rf_id) DESC)) as DB1
WHERE DB1.rank < 3;

-- s_stats2-form-handler
-- Top 2 months in each year in the order of number of patents filed --
