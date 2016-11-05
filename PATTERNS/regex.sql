# Show records where the name contains a "W"
SELECT * FROM glass_sets WHERE name REGEXP "W"; 

# Show records where the name contains a "W" or a "N"
SELECT * FROM glass_sets WHERE name REGEXP "[WN]"; 

# Show records where the name begins with a "B" 
SELECT * FROM glass_sets WHERE name REGEXP "B^"

# Show records where the name ends with a "H"
SELECT * FROM glass_sets WHERE name REGEXP "H$";
