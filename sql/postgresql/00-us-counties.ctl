copy us_counties from '[acs_root_dir]/packages/ref-us-counties/sql/common/us-counties.dat' 
[ad_decode [db_version] "7.2" "delimiters" "delimiter"] ',' 
[ad_decode [db_version] "7.2" "with null as" "null"] ''
