--==========SCHEDULED TASK============================================== 
-- Create a task that calls the stored procedure every hour 
-- so that Lottie sees updates at least every hour

USE ROLE ACCOUNTADMIN;
use schema max_outgoing.for_acme;
use warehouse compute_wh;
grant execute task on account to role sysadmin;


USE ROLE SYSADMIN;
create or replace task acme_return_update
  warehouse = compute_wh
  schedule = '1 minute'
as
  call lotstockupdate_sp();

--if you need to see who owns the task
show grants on task acme_return_update;
 
--Look at the task you just created to make sure it turned out okay
show tasks;
desc task acme_return_update;
 
--if you task has a state of "suspended" run this to get it going
alter task acme_return_update resume;  
 
--Check back 5 mins later to make sure your task has been running
--You will not be able to see your task on the Query History Tab
select *
  from table(information_schema.task_history())
  order by scheduled_time;