-- If no high priority jobs we accept low priority jobs


type Priority is (High, Low);

task Worker is
    entry Handle (Priority)(J : Job);
end Worker;

task body Worker is
begin
    loop
        select
            
            accept Handle (High)(J : Job) do
                -- something to handle
            end;

        or 
            when Handler (High)'Count = 0 =>
            accept Handle (Low)(J : Job) do
                -- doing somthing
            end;
        end select;
    end loop;
end Worker;