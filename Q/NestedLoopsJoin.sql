for each row R1 in the outer table
    begin
        for each row R2 in the inner table
            if R1 joins with R2
                return (R1, R2)
        if R1 did not join
            return (R1, NULL)
    end
