PI : constant := 3.141592653589793239;

declare
    subtype Decimal is Integer range 0 .. 9;
    D : Decimal;
    I : Integer := 1;
begin
    D := Decimal(I); -- May cause constraint error 
    D := D + 1;      -- May cause constraint error 
    I := D;          -- Always safe 
end; 

-- Enumeration 
declare
    type Day is (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday );
    subtype Workday is Day range Monday .. Friday;
    D : day;
    W : Workday := Monday;

begin
    W : = W' Next;          -- After this W is Tuesday 
    D := W;                 -- Always safe 
    W := Workday (D' Prev); -- After this W is monday 
end

-- Arrays 
declare 
    type vector is array(integer range <>) of Real;
    type matrix is array(integer range <>, integer range <>);

    V : vector (-10 .. 10) := (0 => 1.0, other => 0.0);
    M : matrix := ((1.0, 2.0, 3.0),
                    (4.0, 5.0, 6.0),
                    (7.0, 8.0, 9.0));
    A : array (Weekday) of Natural := (Friday => 1, others => 0);
begin
end

-- Record 
-- Similar to struct in C but more powerful
declare 
    type Complex is
        record
            Re : Float := 0.0;
            Im : Float := 0.0;
        end record;
    
    A : Complex := (Re => 1.0, Im => 1.0);
    B : Complex := (A.Im, A.Re);
begin
    B.Re := B.Re ** 2;
end;

-- Loops 
-- may be named ( removes need for evil goto )

loop 
    ...
    exit when Awnser = 43;
    ...
end loop;

Outer:
loop
    ...
    loop
        ...
        exit Outer when Answer = 43;
    end loop;
    ...
end loop Outer;


for I in range 1 .. 10 loop
    for J in reverse 1 .. 10 loop
        ...
    end loop;
end loop;

for D in Day loop
    ...
end loop;


-- Functions 
-- Defaults to in but Ada 2012 also allows in out 

function Sum(A, B : Integer) return Integer is
begin
    return A + B;
end Sum;

function Product (A, B : Integer ) return Integer is (A * B);
declare
    C : Integer;
begin
    C := Sum (1, 2);
    C := Product (C, 3)
end;
