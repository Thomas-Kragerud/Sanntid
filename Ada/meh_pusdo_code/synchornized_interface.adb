
type SI is synchronized interface;

procedure Handle (This : in out SI; J : in Job) is abstract;

type PI is protected interface and SI;

type TI is task interface and SI;

task type T_Worker is new TI with
    overriding entry Handle (J : in job);
end T_Worker;

protected type P_Worker is new PI with
    overriding procedure Handle (J : in job);
end T_Worker;
