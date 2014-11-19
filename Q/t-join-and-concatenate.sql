--  merging and creating comma separated lists
-- concatenating many rows into a single text string in TSQL

-- If there is a table called STUDENTS
--
-- SubjectID       StudentName
------------      -------------
-- 1               Mary
-- 1               John
-- 1               Sam
-- 2               Alaina
-- 2               Edward
-- Need to get this::
--
-- SubjectID       StudentName
------------      -------------
-- 1               Mary, John, Sam
-- 2               Alaina, Edward

-- Try  the following T-SQL:

Select Main.SubjectID,
       Left(Main.Students,Len(Main.Students)-1) As "Students"
From
    (
        Select distinct ST2.SubjectID, 
            (
                Select ST1.StudentName + ',' AS [text()]
                From dbo.Students ST1
                Where ST1.SubjectID = ST2.SubjectID
                ORDER BY ST1.SubjectID
                For XML PATH ('')
            ) [Students]
        From dbo.Students ST2
    ) [Main]
You can do the same thing in a more compact way if you can concat the commas at the beginning and use substring to skip the first one so you don't need to do a subquery:

Select distinct ST2.SubjectID, 
    substring(
        (
            Select ','+ST1.StudentName  AS [text()]
            From dbo.Students ST1
            Where ST1.SubjectID = ST2.SubjectID
            ORDER BY ST1.SubjectID
            For XML PATH ('')
        ), 2, 1000) [Students]
From dbo.Students ST2
