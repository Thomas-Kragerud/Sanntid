task Periodic;

-- Do something with 100 ms intervall 
task body Periodic is
    Next : Time := Clock;
begin 
    loop
        delay unitll Next;  -- Absolut time
        ...
        Next := Next + Milliseconds (100);
    end loop;
end Periodic;


-- Several similar task instances to be created
-- N is discreminant
task type Worker (N : Character);

task body Worker is
begin
    Put_Line ("My name is" & N);
end Worker;

A : Worker ('A');
B : Worker ('B');



-- Eksamle 
task type Runner is 
    entry Start; -- One entry, no arguments 
end Runner;

task body Runner is
begin
    accept Start; -- Block here untill someone calls start 
    ...           -- Do something
end Runner;

declare
    A, B : Runner;
begin
    A.Start;    -- Start A first 
    delay 1.0;
    B.Start;    -- Start B a second later
end;            -- Block here untill A and B are done 



----------------------------------------------------------------
-- More fancy example

task type Server (S : Integer) is
    entry Write ( I : Integer);
    entry Read (I : out Integer);
end Server;

task body Server is
    N : Integer := S;
begin
    loop
        select
            accept Write (I : Integer) do
                N := I;
            end;
        or
            accept Read (I : out Integer) do
                I := N;
            end;
        end select;
    end loop;
end Server;