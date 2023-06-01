with Ada.Text_IO;

procedure Hello_World is
begin
    Ada.Text_IO.Put_Line("Hello World");
end Hello_World;


task Worker is
        entry Start;
    end Worker; 
    
    task Clinet is
        entry Kjor;
    end Clinet;
    