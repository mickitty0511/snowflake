use role accountadmin;
create or replace external function util_db.public.greeting(
 email varchar     
 , firstname varchar    
 , middlename varchar     
 , lastname varchar) 
returns variant 
api_integration = dora_api_integration 
context_headers = (current_timestamp,current_account, current_statement)
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/greeting'
;

select util_db.public.greeting( 'y.reijun1096@gmail.com' , 'Miki' , '' , 'Yoshida' );