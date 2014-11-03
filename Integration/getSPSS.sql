GET DATA
 /TYPE = ODBC
 /CONNECT = "DSN = DSNname"
 /SQL = "SELECT * FROM empl_data "
        "WHERE ((bdate>=#1/1/1960# and edate<=#12/31/1960#) or bdate is null)".


GET DATA
  /TYPE = ODBC 
  /CONNECT = "DSN=temp_Hisp;DATABASE=temp_HispTreat"
  /SQL = "With CTE_BASENG As (Select StudyID, Visit, Question, "
           "CAST(Response As Int) As RESPONSE "
         "from temp_HispTreat.dbo.BAS AS PVTable "
         "outer apply (values (N'BAS1',BAS1), (N'BAS24',BAS24)) "
           "P(Question, Response)) "
         "select SubVis.IRB#, SubVis.StudyID, SubVis.Clin_num, Subvis.Visit, "
           "BASENG.BAS_ENGTOT "
         "From (Select Distinct IRB#, StudyID, Clin_Num, Visit_ID As Visit "
         "from temp_HispTreat.dbo.Subjects, temp_HispTreat.dbo.StudyStructure "
         "where subjects.IRB# = 5516 and StudyStructure.IRB = 5516) As SubVis "
         "left join (Select StudyID, Visit, "
           "SUM(Scoring.dbo.GetValue9(response)) As BAS_ENGTOT "
         "from CTE_BASENG group by StudyID, Visit) AS BASENG On "
           "SubVis.Studyid = BASENG.StudyID And SubVis.Visit = BASENG.Visit".
