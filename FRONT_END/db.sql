CREATE or replace FUNCTION add_to_all() RETURNS TRIGGER AS $add_to_all$
	BEGIN
		INSERT INTO ASSIGNMENT_CONVEYANCE (RF_ID, Convey_TY, EMPLOYER_ASSIGN)
		VALUES(NEW.RF_ID, NEW.Convey_Text,0);

		INSERT INTO ASSIGNOR (RF_ID, OR_NAME)
		VALUES(NEW.RF_ID, 'TEMP');

		INSERT INTO ASSIGNEE (RF_ID, EE_NAME)
		VALUES(NEW.RF_ID, 'TEMP');		

		INSERT INTO DOCUMENTID (RF_ID, APPNO_DOC_NUM, GRANT_DOC_NUM)
		VALUES(NEW.RF_ID, 'TEMP', 'TEMP');

		INSERT INTO DOCUMENTED_ADMIN (RF_ID, APPNO_DOC_NUM, GRANT_DOC_NUM)
		VALUES(NEW.RF_ID, 'TEMP', 'TEMP');

		RETURN NEW;
	END;
$add_to_all$ LANGUAGE plpgsql;		
