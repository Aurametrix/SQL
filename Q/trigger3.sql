Trigger on a LOGON event (Logon Trigger)

CREATE TRIGGER trigger_name 
ON ALL SERVER 
[ WITH <logon_trigger_option> [ ,...n ] ]
{ FOR| AFTER } LOGON  
AS { sql_statement  [ ; ] [ ,...n ] | EXTERNAL NAME < method specifier >  [ ; ] }

<logon_trigger_option> ::=
    [ ENCRYPTION ]
    [ EXECUTE AS Clause ]
