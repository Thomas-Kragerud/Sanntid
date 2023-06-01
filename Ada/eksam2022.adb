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
with Ada.Text_IO; use Ada.Text_IO;

procedure Eksam2022 is
    -- Define the array i need 
    type Bool_Array is array (Integer range <>) of Boolean;




    -- Define the protecte Object containing an array and the 
    -- Funcions needed to work on it 
    protected Acceptance_List is
        procedure I_COMPLETED(ID : Integer);
        function Status return Boolean;
        entry Finished_Rendevous;
    private
        count : Integer := 0;
        Status_Array : Bool_Array(1 .. 3) := (others => False);


    end Acceptance_List;

    protected body Acceptance_List is
        procedure I_COMPLETED(ID : Integer) is
        begin
            Count := Count + 1;
            Status_Array(ID) := True;
        end I_COMPLETED; 

        function Status return Boolean is
        All_True : Boolean := True; -- Initialize as True
        begin
            for I in Status_Array'range loop
                -- AND each element with the current result
                All_True := All_True and Status_Array(I);
            end loop;
            return All_True;
        end Status;

        entry finished_Rendevous when count >= 3 is
        begin
            null;
        end finished_Rendevous;
    end Acceptance_List;
    
    task type Worker (ID : Integer) is
        entry Start;
    end Worker;

    task body Worker is
    begin
        accept Start do
            null; 
        end Start;
         -- Notify that task is finished
        Acceptance_List.I_COMPLETED(ID);
        Acceptance_List.Finished_Rendevous;
        Put_Line("Worker" & Integer'Image(ID) & "Finished");
    end Worker;

    -- Declare the variable Stat
    Stat : Boolean;

    -- Instatiate workers 
    Worker1 : Worker(1);
    Worker2 : Worker(2);
    Worker3 : Worker(3);
begin
    -- Start the workers
    Worker1.Start;
    Worker2.Start;
    Worker3.Start;

        -- Wait until all workers have completed their tasks
    
     -- Get the status
    Acceptance_List.Finished_Rendevous;
    Stat := Acceptance_List.Status;
    -- Convert boolean to string
    Ada.Text_IO.Put_Line("Status: " & Boolean'Image(Stat));
end Eksam2022;
