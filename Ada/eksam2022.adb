-- 3 fixed thread (workers) participants, 1 client
-- Workers standby unitll client initiates
-- At end of action a succes/ fail result is returned to the client
--
-- Start boundary: when client initiates each role should be executed once 
-- Action fail or succed dep on wheather any of threads failed at doing their part 
-- Ignore side boundary 
-- 
-- If one thread runs into an error, other threads will immediatly, quit what they are
-- doing and start error handling (again report same pass of fail)
--
-- Both threads still working and threads finished working shoudld react to error


-- Specification (declarations)

procedure Main is
-- Define the paramaters 
    task Worker is
        entry Start;
    
    task Clinet is
        entry Kjor;
    
begin
-- Run 
end Main;