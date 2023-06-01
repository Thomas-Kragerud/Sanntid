-- Abort code asynk after a timeout or on a signal 
-- use delay or delay untill for timeout 
-- use entry of protected obj for signal 

select
    delay 5.0;
    -- Do this when aborted 
then abort
    -- Abort this code after 5 seconds 
end select;

select
    Controller.Wait_Termination;
    ... -- Do this when aborted 
then abort
    ... -- Abort when entry above is open 
end select;