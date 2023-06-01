

-- Notice the private part of the protected obj, 
-- this part may also contain entries, procedures and functions for internal use

protectedtype Semaphore (N : Positive) is
    entry Lock;
    procedure Unlock;
    function Value return Natural;
private
    Value : Natural := N;
end Semaphore;

protected body Semaphore is
    entry Lock when V > 0 is   -- Allowd to enter when Value > 0
    begin
        V := V - 1;
    end Lock;

    procedure Unlock is        -- Unlock at any time, dont check for owner ship 
    begin
        V := V + 1;
    end Unlock;

    function Value return Natural is
    begin
        return V;
    end Value;
end Semaphore;




--- Example with Workers

task type Worker (Mutex : not null access Semaphore);

task body Worker is
    begin
        Mutex.Lock;
        Put ("Starting ... ");
        delay 1.0;
        Put_Line ("Finished");
        Mutex.Unlock;
    end Worker;

    declare
        Mutex : aliased Semaphore (1);
        A, B, C : Wokrer (Mutex' Access);  -- A, B or C will take the lock first at do its work 
    begin
        null;
    end;

    -- Worker could break the protocal by calling Unlock without calling Lock first