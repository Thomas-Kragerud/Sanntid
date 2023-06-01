
> 🩳 Make system that is:  
> - Available   
> - Fault tolerant  
> - Unconsistant: more consistent with avoiding negation → leeds to paradoxeI  
> - Idonpotant: duplicates has no effect   
> - Commutative: Order has no effect 


### **What We Know**

- Failure is inevitable: Only valid solution is to take over or try again with someone else in a distributed system.
- Failure on a single node:
	- Try everything again, possibly restarting from a checkpoint.
	- Try the failed part again using goto/scope guards to undo.
- Redundancy is necessary to compensate for failures through physical distribution.
	- If it crashes, there must be information available to take over.
	- Communication failures pose a challenge in guaranteeing service.

### **States, Threads, and Processes**

- Threads do things, functions don't.
- If a process has no output, it does nothing.
- If a process has no input, it is predictable and always does the same thing, unaffected by the world. It's not a process, but an integral of a real process.
- If a process has no state, it's repeatable and is just a function with no memory of the world.
- To be useful, a process must be stateful, unpredictable, and handle I/O.

### **Our Tasks Need Messages**

- A message always contains two pieces of information:
	1. The message payload.
	2. The existence of the message, implying a sender who recently did something.
- Messages are the inputs and outputs of a process.
- Ensure that incoming messages are not garbage.

### **Unpredictable Messages**

- Lost messages prevent a process from transitioning to its next state.
- Reordered messages scramble internal states, leading to unintended and potentially incorrect outcomes.
- Duplicate messages may result in duplicated output.

Messages are necessary and must be received in any order. The order is determined by the message itself. The challenge in distributed systems is to make the system output correct while the network is unreliable.


### **Solving Message Loss (Tangent)**

- Resend the message (the only way).
- Three main methods of resending:
	1. Send periodically, which makes things simpler (not easier).
	2. Wait for confirmation (acknowledgement), and resend if not received.
	3. Do nothing, let the user initiate the sending process again.
- Message loss is not the main issue; the challenge is reordering and duplication.

**Idempotent**: Receiving duplicates has no effect. Getting the same result multiple times doesn't change the outcome (like a max function).
**Commutative**: The order has no effect.


### 


### Our sistem is embedded


The only thing that mattes are the inputs/outputs to the outside world. 


Can do whatever we want with the “intermediates”. The internal state is not observable. ie. dont care if we use a list or a hash map. 


BUT: The environment do whatever it want with the msage on the network. Limited ablility to use network to fix problem. Cant be solved with the netowrk alone


SO: Only place to compensate is to do something with data. Know order recived in, need to know what we have recived previousle. → So we need some data structure. 


---


# Context swits → The CAP theorem 


Can only have 2 of 3: Consistensy, Availablity, Partition tolerance 


**Consistensy:** all nodes produce same output. Same date stored internaly 


**Availabliity:** Node produse out put at al, not necessarily the most recent 


**Partition tolerance:** System tolerates arbitrary message loss between nodes. Tolerates node loss


Math proof that can only have 2 of 3. 


### Informal proof:


![Screenshot_2023-02-10_at_20.31.21.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/1a1e8e7c-db87-4ee9-9d8d-a9d140bc535f/Screenshot_2023-02-10_at_20.31.21.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230601%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230601T200523Z&X-Amz-Expires=3600&X-Amz-Signature=0bd0b5a0fd09dd59163ce3ce0da47b6d28c773f7a55cf39da0a92fd4e45e4d6a&X-Amz-SignedHeaders=host&x-id=GetObject)


### We need: 

- **Partition tolerance:**
	- Nodes wil crash and disconnect
	- Need make sure that no orders are lost, despit losing elevators
- **Availability**
	- System must keep working, despite crashed and disconnects
	- Thoug sometimes not:
		- can live without a light refusing to light up aftet button press
		- Can not refuse to move an elevator after person walkes in

### We also want

- **Consistency**
	- But often we dont need it
	- Ex we onle ned **some** elevator to take ordern, not exatly one specific elevator
	- Need to constrain the inconsistency, as correct as it has to be
	- Inconsistensy only on the internal data, but the outputs are optimal. Something has to be sub optimal ← from cap theormem.
		- I.e. node crashes/disconnects. Cannot give-recive updated data. Are there any incosistencues we can get away with

# Consistency 


In distrubed systems: Replicass (nodes) agree


In formal logick: Free from contradiction 


^These are the same things


What do we send (or not send) between nodes to create incosistency?


### Inconsistency 

- Prerequisites for contradiction
	1. Self reference:
		1. in code: recurison looping.
		2. Code runs forever, so we will have loops
	2. Self referance and Negation
		1. In code: not, delete, reverse, rest, etc
		2. This is where  our focus must be
		3. Also known as paradoxes:
			- “<u>This</u> sentence is <u>false</u>” (self rereance and negation)
			- Not paradox :That sentence is fale

### Filtering 


The only way to do filtering is discarding messages. 


Can not choos wat to recive, but what to ignore. 


Use memory of what we have recived previously.


 This limits the use of negations 


### Ex 2 


Need add stuff operation and remove stuff 


How do we delete on the other nodes.


Algo:

- nr1. output = union(local, input) , discare nothing
	- Union imideatly reads, does not work, problem negation
- nr2.: Do not remove
	- Delete 7 explicetly. Not just, this is my content, sends “delete the num 7”
	- Problem with packet loss, will emediatly read 7
- nr 3: Keep the 7, and add the special “not 7” afterwords
	- “not 7” wil propegate through the network
	- Not removing, just specifying that 7 is not available
	- This is how most content delivering networks works
	- Buy more storage
	- Have a problem when want to add a 7 again, make $7_1, 7_2 \ldots$
	- Want to se if there is a way to proparly discard something

### Ex3: Monotonic counter


counter cant skip numbers


Algo 1: We discard any message that is not +1 from our data 


Impossible: Might get left behind, require to much consistency, discarding to much 


 


### Ex4: Non-mono counter


A counter that only counts up, and can skip numbers (non monotonic)


Everybody has 1, can axept 3 


Simples distributed system  that works,


It is commutative 


It is idenpotend, can recive 3 many times, 


No negation 


Problem, can only go up 


Algorithem: Discard any number ≤ ours 


Will eventualy be consistent


Add surgical negation


### Ex 5: Cyclic counter 


Counter that counts up to $n$, can skip numbers on the way to $n$, and can be reset back to $0$


Algo: 

- Discard any number ≤ ours
	- Lets us count upward
- Except 0, if we are at $n$
	- This lets somone else (or us) reset the counter
- Except for n, if we are at 0
	- This prevents us from un-re-setting the counter when it is being reset

Need to know who is alive, including who sent the message. 


Only resets when every alive 


Also, need `unknows` state 


assuming that want availability there will always be inconsistency. Find out what is permissible inconsistency.


**There is no general-purpose solution to distributed systems.** Has to be application dependent 


intermediate can be inconsistent, out put must be consistent most of the time. Can not get away with self-reference. The only way is to filter out what don't need. Violate idempotency or commutativity. 


Want precision negation → berrier 


We have focused on periodic sending. Message = copy of local date from other node  


 


# Topology 


### Master slave 

- N slaves connecte to single master
- no connection between slavee
- Advantage:
	- Single source of truth, can periodicly be sent
- Disadvntage
	- Need to be able to migrate the master when it dies
	- need to merge master if multiple alive. Dies and comes back alive

### Circle 

- Single node has a previous and a next
- Advantage:
	- if message traverses the whole circle, know everyone got it
	- Simple data structure, no dynamic allocation. Mostly usefull for c like programming
- Disadvantages
	- With packe loss, more nodes = higher chance of failiur. Serial probability
	- The more nodes the less reliable it gets. Mabie up to 5

### Peer to peer

- Everybody connected to everybody
- Advantage:
	- Can use broadcast messaging, easy combine with periodic sending. One socket object
	- Data sharing is the whole point
- Disadvantages:
	- No obvious single source to make decisions
	- How do you ensure unique solution
	- Negation problem
	- Things that should onlyt be done once/one place can be hard

### Mesh network 

- Everybody is connected, but not neceseraly directly
- Like peer to peer
- Advantage:
	- all the same advantages as peer to peer
	- Even more robust to network interruptions
- Disadvantages
	- Explicitly encode “trust”
	- I know that someone you know about knows  → Indirect information propegation
	- Who is alive is hard. How to get peer list
