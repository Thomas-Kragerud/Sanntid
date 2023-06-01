-- Example of protected object
-- Protecte obj are used to ensure safe concurrent acces to shared data
-- They prevent data corruption when multiple tasks are trying to access
-- or change the same price of data. 
-- 
-- Protected objects cointain: 
--   procedures 
--   functions 
--   entries 
-- 
-- Entries in Ada are a combination of procedures and conditions. 
-- When task calls an entry, it checks the condition (Which we see in the protected body)
-- If the condition holds true, the task will run the procedure part 
-- If not, the task is bloced until the condition is True
--
-- "Ctrl_C" is a procedure that will be called when the progeam recives a SIGINT interupt signal 
-- 
-- Multiple tasks will try to acces the Terminator protecte object, wait for termination,
-- and react to a SIGINT signal, 
--
-- Pragma,
-- a compiler directive. pragmas provide a way for each ada implementation to offer machine dependant features within the ada framework. 
-- They can controll optimization, listing control, warning etc. They are not a part of the algorithmic part of the program
-- but they provide importan information to the compiler
--
-- Procedure
-- a subprogram in Ada that performa a certain task. 
-- Invoced with a procedure call, which specifies the procedure name and provides actual parameter for each of the procedures formal parameters.
-- Procedures are similar to void functions in a language like C++, in that they do not return a value
--
-- Function
-- a nother kind of subprogram. Unlike procedure, a function returns a value. 
-- usally used to calculate and return a value based on inputs 
-- 
-- Protected objects
-- are not instantiaded like in OOP languages. They are instead more like a 
-- globally shared resources. 
-- Entry calls might block if its Guard Contidon (the condition specified with WHEN)
-- is not True. The task trying to call the entry will be blocked untill the guard condition is True
-- 


pragma Unreserve_All_Interrupts;  -- Used to allow the software to handle all interrupt requests

-- Define the protected object Terminator 
protected Terminator is
    entry Wait_Terminaton;

private 
    entry Wait_Final;
    procedure Ctrl_C;
    pragma Attach_Handler (Ctrl_C, SIGINT);  -- Attatches the SIGINT signal to the "Ctrl_C" procedure

    Count : Natural := 0;     -- Counter initialiset to 0
    Final : Boolean := False; -- Boolean flag initialiset to False
end Terminator;

-- Protected body defines the actual behaviour of the entries and procedures
protected body Terminator is
    -- Wait_Termination runs when coutn > 0. after that it reques to Wait_final
    -- meaning the next task to be served by Wait_Termination wil be transfered to Wait_Final
    entry Wait_Terminaton when Count > 0 is
    begin
        Count := Count -1;
        requeue Wait_Final;
    end Wait_Terminaton;

    -- Wait final, will run when final flag is true. 
    entry Wait_Final when Final is
    begin
        Ada.Text_IO.Put_Line ("Hasta la vista, baby!");
    end Wait_Final;

    procedure Ctrl_C is
    begin
        Count := Wait_Terminaton'Count;  -- Numer of tasks waiting at Wait_Termination
        Final := Wait_Final'Count > 0;   -- True if at least one task waiting
    end Ctrl_C;
end Terminator;


-- Example of calling the Wait_Termination 

Terminator.Wait_Termination;

