
# The Ada Programming Language

Nice resournce: https://learn.adacore.com/courses/intro-to-ada/chapters/tasking.html

Ada is a language used in safety-critial domains. Key proparties are the following:
- Strong typed and has many compiler checks 
- Large system w packages and abstractions
- Built-in concurrency and real time support 
- Exccellent toolf for a wide range of embedded platforms 

### Some syntax 
__Atributes__
All atritubes use the `'`symbol, (_tick_), to denote attribute acces for a particular type or object.
Ex:
 `Integer'First` gives the smallest (first) value that an Integer type can have.
 `Integer'Last` gives the larges (last) value.
 `Integer'Size` gives the storage size of an integer type in bits. 
 `Color'Value("blue")` convert the string "blue" to the equivalent in the Color enumeration

 other atributes include:
 - `'Length`: Number of elements in an array or string 
 - `'value` : Convets a string to a specified enumeration type.
 - `'Image`: The opposite of `'Value`. Converts enumerate to string 
 - `'Min`, `'Max`Smallest and largest of two numbers 
 - `'Pred`and `'Succ: Predecessor or successor of a discrete type value.
 - `'Address`: Gives the memory addresss of an object

__Arrays__
An array is a collection of elements that are of the same type. The elements are sotred in a contiguos block of memory and each element is identified by an index.
`type My_Array_Type is array (1 .. 10) of Integer;`




__Record__
A record is similar to struct in C but allegedly more powerfull. They may be defined with defalult values and allows you to group several related data items together.
```
type My_Record_Type is
   record
      Name : String (1 .. 20);
      Age  : Integer;
   end record;
```

__Discriminated Types__
Discriminated types are similar to records, but they include a special field (the discriminator) that determines the structure of the other fields. Can be used to implement what other languages call variants or unions. 

```
type My_Discriminated_Type (Is_Int : Boolean := True) is
  record
    case Is_Int is
      when True => Int_Field : Integer;
      when False => Str_Field : String (1 .. 20);
    end case;
  end record;
```
her `My_Discriminated_Type`is a discriminated type that contains either and `Integer`or a `String`, depending on the value of the `Is_Int`discriminator. 



### Code examples 
__Record__
```
type Employee is
   record
      Name : String (1 .. 20);
      Age  : Integer;
   end record;

procedure Main is
   My_Employee : Employee;
begin
   -- Set the fields
   My_Employee.Name := "John Doe";
   My_Employee.Age  := 30;

   -- Access the fields
   Ada.Text_IO.Put_Line("Employee Name: " & My_Employee.Name);
   Ada.Text_IO.Put_Line("Employee Age: "  & Integer'Image(My_Employee.Age));
end Main;

```

### Tasks 
In Ada, a task is a type of concurrency construct that represents an independent thread of execution. Tasks can be used to perform multiple operations simultaneously, and they provide a high level of control over synchronization and communication between differnt parts of a program. 

A task is defined much like a package, with a specification and a body. The specification defines thes interface of the task. It includes any _entry points_, which are the means for a task to communicate and synchronize with each other. 
The body of the task defines what the task does when it is executed.

A task can either be defined like:
- `Task My_Task` 
- `Task Type My_Task_Type`
The first is like an anonumus function in Golang `go func () {.....}()` While the other lats you define a task type that kan be "launched" later in the program by calling `A_Task : My_Task_Type`

```
task Simple_Task;

task body Simple_Task is
begin
    -- code to be executed by the task
  end Simple_Task
```
__Communication and Synchronization__
Tasks in Ada communicate and synchornize throuch _entry points_, which are defined in the task specification. 

An entry can be though of as a procedure that is executed by the task. When another task or the main program calls an entry, it will be blocked untill the task is ready to accept the call.

Hers an example of a task with an entry: 
```
task Simple_Task is
  entry Start;
end Simple_Task;

task body Simple_Task is
begin
  accept Start:
    -- Code to be executed after the start entry is called
  end Simple_task;
```
in this example, another task or the main porgram call `Simple_Task.Start`to activate the `Simple_Task`.
Tasks can also have parameters in their entries, whcich can be used to pass data between tasks.

__Activation and Termination__
Tasks are activated (started) automatically when the program reaches the poin where the task object is declared. A task finishes when it reache the end of its body. 

When the main porgram finishes, all tasks are terminated, regardless of wheter they have finished their execution or not. 

The `accept`keyword is used to define an entry point in a task. It is used to incicate that the task is ready to accept a rendezvous with another task or the main porgram. Here's a simple analogy: think of a task as a shop, and the entries as the doors to the shop. The accept keyword is like a sign on a door saying "open for business". When a customer (another task or the main program) sees this sign, they can enter the shop through that door and do some business (execute some code).

Now, why can't we just call Start? Well, remember that Start is not a procedure, it's an entry. Entries are different from procedures in that they involve a rendezvous between two tasks. When you call an entry, you're not just executing a piece of code, you're also synchronizing with another task.

### Protected objects
A special composite type used for synchoronization. We may have a signle protected object or a class of objectes
 - __protected__ Name
 - __protected type__ Name

They are similar to monitors in other languages and allow the definition of critical sections of code where data race conditions are prevented. 

A protected type in Ada has a specification and body, similar to a package. The specification contains the declarations of the protected operations, while the body provides the corresponting definitions. 

```
protected type Counter is
  procedure Increment;
  function Value return Integer;
private
  count : Integer := 0;
end Coutner;

protected body Counter is
  procedure Increment is
  begin
    count := count + 1;
  end Increment;

  function Value return Integer is
  begin
    return count;
  end Value;
end Counter;
```

In this example `Counter`is a protected type with two operations: a procedure `Increment`and a function `Value`. The `count`data is privat and can only be accesd and modified by the protected operations. 

__Type of Operations__
Protected types can have three types of operations:
1. Procedures: Which allow concurrent calls from differnt tasks but are mutually exclusive with functions and entries. 
2. Functions: which can be called concurrently from multiple tasks as long as no procedure or entry is being called. 
3. Entries: which are like procedures but include a guard condition which must be satisfied before the operation can be called 

__Entry Guards__
Entry guards are boolean expressions associated with protected entries. An entry call will only proceed when its gueard evalueates to `True`. 

```
protected type Bounded_Buffer is
  entry Put (Item : Integer);
  entry Get (Item : out Integer);
private
  count : Integer := 0;
  buffer : array (1 .. 10) of Integer;
end Bounded_Buffer;

protected body Bounded_BUffer is
  entry Put (Item : Integer) when count < buffer'Length is
  begin
    -- do something with buffer
  end Put;

  entry Get (ITem : out Integer) when count > 0 is
  begin
    -- get the item
  end Get;
end Bounded_Buffer;
```
In this example, Put has a guard condition of count < buffer'Length, which means it can only be called when the buffer is not full. Similarly, Get has a guard condition of count > 0, which means it can only be called when the buffer is not empty.

For a full working example see ... 

__Protected Objectes and Tasks__
The relationship between tasks and protected objects comes into play when multiple tsks need to acces and manipulate shared data. Heres how it works: 

1. Tasks perform computations and can read or manipulate data. 
2. When a tsk needs to access shared data (that could potentially be acces by ohter tasks concurrently), it does so through a protected object. 
3. The protected object ensures that only one task at a time can manipulate the data (or a specific portion of the dat), thus preventing data races and inconsistencies. 

In a sense, one can think of tasks as the actor performin the work, and protected objects ar the coordinators ensuring that shared resources are used safely. 

__Ex__:
```
protected COunter is
  procedure Increment; 
  function Get return Integer;
private
  Value : Integer := 0;
end Counter;

protected body Counter is
  procedure Increment is
    begin 
      value := Value + 1
    end Increment; 
  
  function Get return Integer is
  begin 
    return Value;
  end Get;
end Counter;

task type Worker; 

task body Worker is
begin
  Counter.Increment;
end Worker;

-- Declare som worker tasks
W1, W2, W3 : Workers;
```
In this example, multiple Worker tasks increment a shared Counter. Thanks to the protected object, this operation is safe from data races.

### Select 
In Ada the `select`statment is a control structure that is primarily used in the context of tasking, more specifically for handling communication and synchoronization between tasks. It can be somewhat compared to the `select`in Go, although they have significant differneces due to the differnt concurrency models of the two languages. 

The Ada `select`statment allows a task to choose between several alternative operations, including timed entry calls, conditional entry calls and others. It comes in several forms: 

1. __Selectiv accept__: This is used to conditionally accept a rendezvous with another task. It is similar to Gos select which waits for communication on multiple goroutines. 
   ```
   select
      accept Operation_A is
      begin
      -- Handle Operation_A
      end Operation_A;
    or
      accept Operation_B is
      begin
        -- Handle Operation_B
      end Operation_B;
    end select;
    ```
  2. __Timed entry call__: THis is used to call an entry of another task, but only wait for a specified time. If the call isnt compleated in that time, control passes to the alternative part.

    select
     Other_Task.Operation;
    else
    delay 1.0;  -- wait for 1 second
    -- Handle timeout
    end select;
  
  3. __Conditional entry call__ This is used to call an entry of another task, but only if it can be immediately accepted. If it can't be accepted, control passes to the alternative part.
   ```
  select
      Other_Task.Operation;
  else
      -- Handle case where Operation can't be immediately accepted
  end select;
  ```
   


### The Ravenscar profile 
The full Ada concurrent constructs have been considere non-deterministic and unsuited for high-integrity applications. 
Historically the **_Cyclic-executive_** has been preferred.
The Ravenscar profile defines a restricted sub-set of the constructs that are: 
- Deterministic and analyzable 
- Bounded in memory requirements 
- Sufficient for most real-time applications 

Systems that are Ravenscar-compliant can be statically analyzed for properties such as worst case execution time (WCET), schedualability, and stack usage, making them a great fit for hig-stak applications. 

Key restrictions are: 

1. __No task termination__: Once started, taskes in ravenscare system are expected to run indefintly, thus avoiding problems associated with sudden task termination 
2. __No task hierarchy or dynamic task creation__: All tasks are indpendent of each other and are created at system initialization. This restriction simplifies the systems runtime architecture and makes it more predictable
3. __No task priorites__: ALl tasks have the same prioritym avoiding problems assosicated with priority inversion and simplifying scheduling.
4. __No recursion__: This restriction avoids potential problems with stack overflow
5. __Single entry per task__: THis restriction simplifies synchronization and inter-task communication
6. __No rendezvous__: Inter-task communication is achived exclusivly through protected objects, and in a way that can not lead to deadlock situations. 



### Formal verification w SPARK
Spark is a restricted sub-set of ADA2012. 

- Hevy use of contract aspects from Ada 2012
- Additional pragmas for helping proving tools 
- No acces types or recursion!

With SPARK developers can formally verify: 
- Information flow - no unitialized variables
- Freedom of runtime error 
- Functional correctness
- Security and safety policies 

Spark i used for high integrity systems such as aviation asn security. 

So, the Ravenscar Profile and SPARK address two different aspects of high-integrity systems:

The Ravenscar Profile makes concurrent programming more predictable and analyzable.
SPARK allows formal verification of correctness properties in Ada programs.


