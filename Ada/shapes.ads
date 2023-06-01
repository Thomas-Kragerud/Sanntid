package Shapes is 
    -- Abstract base type with no data
    type Shape is abstract tagged null record;

    -- Abstract procedure must be overloaded
    procedure Draw (This : Shape) is abstract;

    -- Acces any type extending Shape
    type Any_Shape is acces all Shape' Class;

end Shapes;