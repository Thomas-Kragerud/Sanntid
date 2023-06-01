
-- Several real-time scheduling policies are supported: 
--      FIFO within fixed priorities 
--      Round-robin within fixed priorites
--      Earliest Deadline Frist (EDF) within priority range 
-- Priorites for tasks and interrupts defined in package system 
-- Celing priority inheritance protocol for protected objets
-- Dynamic prorites for task and protected objects
-- Asynchronous task control to hold and resume tasks 
-- Multiprocessor systems support with CPU dispatching dompains

task type Fixed_Worker (P : Priority) is
    pragma Priority (P);
end Fixed_Worker;

task type EDF_Worker is
    pragma Priority (Some_Priority_In_EDF_Range);
end EDF_Worker;

task body EDF_Worker is
    Next : Time := Clock;
begin
    loop
        Delay_Until_And_Set_Deadline (Next, Milliseconds (10));
        ... -- Do something
        Next := Next + Milliseconds (100);
    end loop;
end EDF_Worker;