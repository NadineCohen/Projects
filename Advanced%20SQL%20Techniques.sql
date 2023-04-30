-- Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.
select PS.NAME_OF_SCHOOL, CD.COMMUNITY_AREA_NAME, PS.AVERAGE_STUDENT_ATTENDANCE
from CHICAGO_PUBLIC_SCHOOLS PS
	left join CENSUS_DATA CD 
	 on PS.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
	where CD. HARDSHIP_INDEX = 98;

-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.
select CRD.CASE_NUMBER, CRD.PRIMARY_TYPE, CD.COMMUNITY_AREA_NAME, CRD.LOCATION_DESCRIPTION
from CHICAGO_CRIME_DATA as CRD
	left join CENSUS_DATA as CD
		on CRD.COMMUNITY_AREA_NUMBER = CD.COMMUNITY_AREA_NUMBER
	where CRD.LOCATION_DESCRIPTION like '%SCHOOL%';
	
-- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
create view School_Info(School_Name,Safety_Rating,Family_Rating,Environment_Rating,Instruction_Rating,Leaders_Rating,Teachers_Rating)
	as select NAME_OF_SCHOOL, Safety_Icon, Family_Involvement_Icon, Environment_Icon, Instruction_Icon, Leaders_Icon, Teachers_Icon
	from CHICAGO_PUBLIC_SCHOOLS;

--	Write and execute a SQL statement that returns all of the columns from the view.
select * from School_Info;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
select School_Name, Leaders_Rating from School_Info;

-- Write a stored procedure that receives the school id and a leaders score as input parameters, calculates the icon setting and updates the fields appropriately
-- Leader's Icon variable needs to be increased in size
ALTER TABLE CHICAGO_PUBLIC_SCHOOLS ALTER COLUMN LEADERS_ICON set data type VARCHAR (30);

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_LEADERS_SCORE (
	IN in_School_ID INTEGER, IN  in_Leader_Score INTEGER)     

LANGUAGE SQL                                                 
MODIFIES SQL DATA                                          

BEGIN
     UPDATE CHICAGO_PUBLIC_SCHOOLS 
     SET Leaders_Score = in_Leader_Score
     WHERE SCHOOL_ID = in_School_ID;
     
     IF in_Leader_Score > 0 AND in_Leader_Score < 20 THEN
     	UPDATE CHICAGO_PUBLIC_SCHOOLS 
    	SET Leaders_Icon = 'Very Weak'
   	  	WHERE SCHOOL_ID = in_School_ID;
   	  	
   	 ELSEIF in_Leader_Score < 40 THEN
     	UPDATE CHICAGO_PUBLIC_SCHOOLS 
    	SET Leaders_Icon = 'Weak'
   	  	WHERE SCHOOL_ID = in_School_ID;
   	  	
   	 ELSEIF in_Leader_Score < 60 THEN
     	UPDATE CHICAGO_PUBLIC_SCHOOLS 
    	SET Leaders_Icon = 'Average'
   	  	WHERE SCHOOL_ID = in_School_ID;
   	  	
   	 ELSEIF in_Leader_Score < 80 THEN
     	UPDATE CHICAGO_PUBLIC_SCHOOLS 
    	SET Leaders_Icon = 'Strong'
   	  	WHERE SCHOOL_ID = in_School_ID;
   	 
   	 ELSEIF in_Leader_Score < 100 THEN
     	UPDATE CHICAGO_PUBLIC_SCHOOLS 
    	SET Leaders_Icon = 'Very Strong'
   	  	WHERE SCHOOL_ID = in_School_ID;
   	 
   	  ELSE ROLLBACK WORK;
   	  	
   	 END IF;
   	 COMMIT WORK;
        
END
@ 

--Write a query to call the stored procedure, passing a valid school ID and a leader score of 50, to check that the procedure works as expected.
select SCHOOL_ID, NAME_OF_SCHOOL, LEADERS_ICON, LEADERS_SCORE 
	from CHICAGO_PUBLIC_SCHOOLS
	limit 5;
	
CALL UPDATE_LEADERS_SCORE_1(610038, 50);

select SCHOOL_ID, NAME_OF_SCHOOL, LEADERS_ICON, LEADERS_SCORE 
	from CHICAGO_PUBLIC_SCHOOLS
	where SCHOOL_ID = 610038;