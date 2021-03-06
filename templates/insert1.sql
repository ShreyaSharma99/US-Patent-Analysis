WITH MAX_VAL AS (SELECT MAX(RF_ID) + 1 FROM ASSIGNMENT)
INSERT INTO ASSIGNMENT (RF_ID, CNAME, CADDRESS_1, CADDRESS_2, CADDRESS_3, CADDRESS_4, Convey_Text, RECORD_DT, LAST_UPDATE_DT, PAGE_COUNT)
VALUES((SELECT * FROM MAX_VAL), '{}', '{}', '{}', '{}', '{}', '{}', CURRENT_DATE, CURRENT_DATE, {});

UPDATE ASSIGNOR SET OR_NAME = '{}', EXEC_DT = '{}'::DATE WHERE RF_ID = (SELECT MAX(RF_ID) FROM ASSIGNMENT);

UPDATE ASSIGNEE SET EE_NAME = '{}', EE_CITY = '{}', EE_STATE = '{}', EE_POSTCODE = '{}', EE_COUNTRY = '{}' WHERE RF_ID = (SELECT MAX(RF_ID) FROM ASSIGNMENT);

UPDATE DOCUMENTID SET TITLE = '{}', APPNO_DOC_NUM = '{}', APPNO_DATE = '{}'::DATE, APPNO_COUNTRY = '{}', GRANT_DOC_NUM = '{}', grant_date = '{}'::DATE 
		WHERE RF_ID = (SELECT MAX(RF_ID) FROM ASSIGNMENT);

UPDATE DOCUMENTED_ADMIN SET APPNO_DOC_NUM = '{}', GRANT_DOC_NUM = '{}', ADMIN_APPL_ID_FOR_GRANT = '{}', ADMIN_PAT_NO_FOR_APPNO = '{}', ERROR = '{}' WHERE RF_ID = (SELECT MAX(RF_ID) FROM ASSIGNMENT);
