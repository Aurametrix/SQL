DECLARE @colsUnpivot AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX),
    @colsPivot as  NVARCHAR(MAX)

select @colsUnpivot = stuff((select ','+quotename(C.name)
         from sys.columns as C
         where C.object_id = object_id('yourtable') and
               C.name <> 'color'
         for xml path('')), 1, 1, '')

select @colsPivot = STUFF((SELECT  ',' 
                      + quotename(color)
                    from yourtable t
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')


set @query 
  = 'select name, '+@colsPivot+'
      from
      (
        select color, name, value
        from yourtable
        unpivot
        (
          value for name in ('+@colsUnpivot+')
        ) unpiv
      ) src
      pivot
      (
        sum(value)
        for color in ('+@colsPivot+')
      ) piv'

exec(@query)
