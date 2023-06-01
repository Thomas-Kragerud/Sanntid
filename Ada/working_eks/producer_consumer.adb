------------------------------------------------------------------
-- synchronous PC using Rendezvous --
------------------------------------------------------------------
with Ada.Text_IO; use Ada.Text_IO;

procedure producer_consumer is
    -- In this way both the producer and the consumer is initialiset right away
   task Producer;
   task Consumer is
      entry Buf(Item : in Integer);
   end Consumer;

   -- Body 
   task body Producer is
   begin
      for I in 1..10 loop
         Put_Line("Producer writing" & Integer'Image(I));
         Consumer.Buf(I);
      end loop;
   end Producer;


   task body Consumer is
      Temp : Integer;
   begin
      loop
         select
            accept Buf(Item : in Integer) do
               temp := Item;
            end;
            Put_Line("Consumer read" & Integer'Image(Temp));
         or
            terminate;
         end select;
      end loop;
   end Consumer;

begin
   null;
end producer_consumer;