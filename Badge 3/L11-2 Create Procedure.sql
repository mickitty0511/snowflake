
--=============================STORED PROCEDURE====================================
-- Create a stored proc that will dump and reload the vinhanced table 
-- using the view that combines Lottie's data with Max's. You don't actually need 
-- two sets of variables but using two might help make it clearer for some people. 

USE ROLE SYSADMIN;
USE SCHEMA max_outgoing.for_acme;

create or replace procedure lotstockupdate_sp()
  returns string not null
  language javascript
  as
  $$
    var my_sql_command1 = "truncate table max_outgoing.for_acme.lotstockreturn;";
    var statement1 = snowflake.createStatement( {sqlText: my_sql_command1} );
    var result_set1 = statement1.execute();
    
    var my_sql_command2 ="insert into max_outgoing.for_acme.lotstockreturn ";    
    my_sql_command2 += "select VIN, MODYEARNAME, MAKE_NAME, DESC1, DESC2, DESC3, BODYSTYLE";
    my_sql_command2 += ",ENGINE, DRIVETYPE, TRANS, MPG, EXTERIOR, INTERIOR, MANUF_NAME, COUNTRY, VEHICLETYPE, PLANTNAME";
    my_sql_command2 += " from max_outgoing.for_acme.lotstockenhanced;";

    var statement2 = snowflake.createStatement( {sqlText: my_sql_command2} ); 
    var result_set2 = statement2.execute(); 
    return my_sql_command2; 
   $$; 
   
   --View your Stored Procedure 
   show procedures in account; 
   desc procedure lotstockupdate_sp();


