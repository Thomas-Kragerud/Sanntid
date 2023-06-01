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

---- 
-- 2 More examples 
-- First example does something if a task calls signal within one sek 
-- The second eksample only does something if there allready a task waiting 
-- Same as having a delay of zero sekonds 
select
    accept Signal;
    ... -- Do this if a task calls Signal within one second
or 
    delay 1.0;
    ... -- Else do this
end select;

-- eks 4
select
    accept Signal;
    ... -- Do this if a task is already blocked on signal 
else 
    ... -- Else do this immediatly (sam as zero timeout) 
    
end select;