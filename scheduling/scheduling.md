
# Scheduling 


There are two main types of CPU scheduling, preemptive and non-preemptive. Preemptive scheduling is when a process transitions from a running state to a ready state or from a waiting state to a ready state. Non-preemptive scheduling is employed when a process terminates or transitions from running to waiting state.


> 🥨 **Preemtpiv scheduling** the CPU is allocated to the processes for a specific time period  
>                                         tasks are switched based on priority


> 🥨 **Non-preemtptive scheduling** CPU is allocated to the process untill it terminates  
>                                                      no switching takes place


### Nice kilder 

- [CarnegieMellon Advanced Real-Time Concepts](https://course.ece.cmu.edu/~ee349/lectures/17_RTOS_AdvancedRealtime.pdf)

## Terminology 


### Period


In real time scheduling, a task is typically modeled as a repeating sequence of identical job instances, each with its own **arrival time**, **execution time**, and **deadline**. The **period** $T_i$ of task $i$ is the time intervall between the arrival of two consecutive instances of the same task. 


If a task arrives every 10 ms, its period is 10 ms. It is important to not that period of a task is not necessarily equal to its deadlin, although in manycases it is. 


### Worst case execution time (WCET)


Is the maximum amount of time it cold pssibly take to execute a task noted $C_i$. This is critical parameter for scheduling in realtime systems, b.c the sys has to be designed to handel worst-case scenario. 


### Worst case respons time (WCRT) 


Is the longes possible time from the releas of a task untillits completion. It takes into accunt not just the tasks execution time, but also the time the task might spend waiting because of interference from higher priority tasks. 


### Utilization


The utilization of a task is the ration of its WCET to its period $U = \frac{C}{T}$. The total utilzation of a set of tasks is the sum of the utilization of all the tasks. 


 


### Releas


Task is “released” when it becomes ready to excute. This is typically at the beginning of its period. I it has a period of 10 ms it will be released every 10 ms. 


### Task Preemption 


refers to the abillity of the OS to interrupt and temporarily halt a task in order to start or resume another task. In _**Preemptiv scheduling**_ if a higher pri task becomes ready to execute while a lower pri task is running, _the scheuler_ can _preempt_ the lower priority task and switch to running the higher pri task. 


### Priority inversion 


Situation that can occur in priority-based scheduling systems, where higher priority tasks is indirectly blocked by a lower priority task. This happens when a medium priority task preempts a lower - priority task that holds a resource needed by a high pripority task. Sins the medium priority does not reles the resource the high prioirty task cant proceed, leeding to an “Inversion” of the expected priority orde. 


### Interference 


refers to the sistuation where the excecution of a task is delayed due to execution of higher priority tasks. 


### Busy Period


The busy period in a real-time system typically refers to a continuous interval of time during which the processor (CPU) is continuously busy, meaning it has tasks to execute and isn't idle. This doesn't necessarily mean a specific task is continuously executing. It means that at least one task in the system is ready to execute.


For a specific task, the busy period reffers to the longes intervall during which it is ready to run, but not necessarily running the entire time. This includes the time it is executing (being worked on by the CPU) as well as the time it might be ready to execute but is waiting due to higher priority tasks running or due to other forms of interference. 


## Read up on 

- Context Switching
- Makros

## Non preemptiv Scheduling

- FCFS - First come first serve
- SJF - Shortest Job First

### Proes and cons Non-preemtiv scheduling 


👍🏻

- **Simple and intuitiv** - NPS is conceptually strightforward. Running task untill finishes or voluntarily gives up controll. Predictable in terms of task execution order. Especially when tasks follow a well-def pattern of yielding control
- **No Kernal** - NPS can be implmented entierly in _user space_, ie. dont have to rely on the operating system kernal and its scheduling mechanisms. Thus, less dep on specific OS
- **Fast Switiching** - Since NPS do not requre intervention from kernel, the _overhead_ associated with context switching (Saving and restoring the state of a process or thread) can be significantly less than w PS.
- **Elegang synchronization patterns** - NPS allows for certain types of synck that can be less complex than those needed in preemptiv environments. EKS. Might not need use _locks_ or _semaphores_ to protect shared resources since task wont be interrupted in the middle of using such resource.

👎🏻

- **C macro hell** - Complexity of implmenting nonpreemptive scheduling, particularly in language like C. Complex macros leed to difficult code read and maintain.
- **Treads must cooperat** - NPS relies on tasks voluntarily yielding control. IF task does not cooperate (infinite loop, or not yield when expectes), could starve other task of processing time.
- **Heavy threads must be divided** - For long running tasks, you will need to manually divide them into smaller tasks that can yield control at regular intervals. Adds to complexity of application
- **Can we handle blocking library functions?** - Many libs include functions that block while waiting for something to happen (like I/O). These dont naturally fit into a NPS model, possibly need to run them in a separate thread or using non blocking version of the function if available.
- **Unrobust to errors** - If error occurs in a task, could potentially bring down entire system since no preemptive control to stop the task. Error handling, therfore, needs to be carfull considered and robustly implmented
- **Tuning at end of Project** - NPS may requrie significant tuning and optimization, particularly towards the end of a project when the behaviour of system under load is better understood. This could include adjusting the points at which tasks yield controll, handling tasks that take longer than expected, etc. Risky and time consuming.

Therfore we use different shcedueling types for differnt types of problems. 


**Preemptive Scheduling:**  Is widely used in gneral-purpose operating systems (Windows, Linux, MacOs), where a scheduler can interupt a currently executing task w.o its agreement to give a chance to other tasks. Ensures “fair ness” to share system resources among all tasks, and ensure higher-priority tasks can run when they need to. This is grat for multitasking and multiprocessor systems. However it does introduce complexity in terms of managin shared resoruces and handling context switching. 


**Non-Preemptiv Scheduling**: Is often used in real-time and embedded systems where tasks ofthen have a very specific timing requirments and where the overhead of context switching and the unpredictabillity of preeptive scheduling can be problematic. 


**Cooperative Scheduling (a form of Non-Preemptive Scheduling)**: This is used in some specific system designs (like early versions of Windows and MacOS, and some real-time and embedded systems) where tasks voluntarily yield control periodically or when idle to allow other tasks to run. This can be simpler to implement and can have lower overhead because there's no need for the system to forcibly preempt tasks, but it relies on tasks to cooperate for the system to work effectively.


**Real-Time Scheduling**: This is used in real-time systems where tasks have strict timing constraints. Real-time schedulers, which can be either preemptive or non-preemptive, aim to ensure that all tasks meet their deadlines. Examples of real-time scheduling algorithms include Rate Monotonic Scheduling (RMS) and Earliest Deadline First (EDF).


## Coroutine 


A coroutine is a generalization of a subroutine, also known as functions or methods, used for non-preemtive multitaskin, where a process can voluntarily suspend or resume its execution. Also known as yielding to allow other routines to run. 


Normal subroutines have a single point of entry and a single point of exit. Coroutines on the other hand allows programs to maintain many different execution points, rather than just on, and switch between these points as necessary. They are particulary usful in porgrams that handle many tasks at once, such as servers, whwre a large numer of task can be performed independently but need to share som resources. 


A simple example of a corutine in Python using  `async` and `await` keywords.


```python
async def hello():
    print("Hello,")
    await asyncio.sleep(1)
    print("world!")

asyncio.run(hello())
```


Here, the `hello()` function is a coroutine. The `async` keyword before the function definition indicates that it is a coroutine. Inside the coroutine the `await` keyword is used to suspend the execution unitll the operation, in this case a asynck sleep os 1 sek completes. This allows other coroutines to run during the wait period. 


## Concepts 

- [ ] respons time analysis
- [ ] utilization - schedualbiliy tests 
- [ ] agrue that real time demands will be met - software design real time systems 
- [ ] features gained from priorites 
- [ ] find upper bound of execution time of calculation 
- [ ] Concequences not knowing the timing from code 
- [ ] deadlines in system will be satified responsetime analysis and utilization based schedualbility test 
- [ ] Why schedualbility proofs not well developed for message passing systems
- [ ] Priority Celing protocol, Unbounded priority inversion problem, avoids deadlock 
- Cyclic executive - NP hard bin packaging

## Task-based Shceduling

- FPS - Fixed priority scheduling
- EDF - Earliest Deadline First
	- Both NPE & PE
- VBS - Balue Based Scheduling
	- Both NPE & PE

Sufficient and Necessary & Necessary test 

- Sufficient if positive outcome all deadlines are always med
- Necessary if failiur of test lead to deadline miss at some point during execution

→ Sufficient & Necessary is Optimal 


→ Sufficient & not Necessary is pessimistic 

- Sustainable - if correctly predict schedual sys will be schedual

> 🥨 Pre-emptive - Forebyggende

- Noen preemtive - lower priority task allowed to complete.
- Preemptiv enable higher priority tasks to be more reactivem hence they are perferred.
- **Deffered preemption**  - **Cooperativ dispatching** - allow lover priority task continue to execute for a bounded time (but not necessarily to completion). I.e. a middle ground be

### Simple task model 


> 🥨 Simple model to describe some simple scheduling schemes   
> Must imopse some restrictions on the structure of the real-time concurrent program 


### FPS - Fixed Priority Scheduling 


A Fixed Priority Scheduling (FPS) system is a type of real-time scheduling system. The main concept behind FPS is that ever task is assigned a fixed priority, and the sceduler alwas selects the highes-prioirty task that is ready to run. 


FPS model is ofen used for real time systems where the timing of the task is critical. 

- with SImple task model → Optimal priority assignment shceme for FPS → **Rate monotonic**
- Each task assigned a (unique) priority based on its period, shorter period higher pri
	- For two tasks $i$ and $j$, we have $T_i < T_j \Rightarrow P_i > P_j$
- In this book priority 1 is the lowest priority

| **Task**  | **Period, T** | **Priority, P** |
| --------- | ------------- | --------------- |
| a         | 25            | 5               |
| b         | 60            | 3               |
| c         | 42            | 4               |
| d         | 105           | 1               |
| e         | 75            | 2               |


### Utilization-based schedulability test for FPS


For **Rate monotonic sheduling**, a type of FPS where the task with the shortest period gets the highest priority. We have _**Liu & Laylands utilization-based schedulability test**__,_ which represent an upper bound on the CPU utilization for which task can be guaranteed to meet their deadlines under RMS. The test thus applies to preemptive scheduling. 


$$
\sum_{i = 1}^{N}\left(\frac{C_i}{T_i}\right) \le N\left(2^{1/N} - 1 \right)
$$


Where: 

- $N$ is the number of tasks
- $C_i$ is the worst-case exectuion time of task $i$
- $T_i$ is the period of task $i$

If the condition holds all $N$ tasks will meed the deadline. The test is **sufficient**, meaning if a task set meets the condition, then it is guaranteed to be scedulable under FPS with monotonic priority assignment. However, it is **not necessary** because there may be a task set that fail the test but can still be successfully scheduled. 


For lange N, bound asymptotically approaches 69.3%. Hence task with combined utilization less than 69.3% will always be schedulable by a preemptiv priority based scheduling scheme. 


Example: 


| **Task**  | **Period, T** | **Computation time, C** | **Priority, P** | **Utilization, U** |
| --------- | ------------- | ----------------------- | --------------- | ------------------ |
| a         | 50            | 12                      | 1               | 0.24               |
| b         | 40            | 10                      | 2               | 0.25               |
| c         | 30            | 10                      | 3               | 0.33               |


![Time-line for the task set above](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/65ab681c-d00f-447d-b72d-d03ab04f0b81/Screenshot_2023-06-02_at_13.52.31.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153418Z&X-Amz-Expires=3600&X-Amz-Signature=b0267a81b73f56fb2f5a275b8800ce8e70a87a79f0d6d2fe20580695b4ef0425&X-Amz-SignedHeaders=host&x-id=GetObject)


![Gnatt chart for task set A](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/95208ac8-c37d-40aa-96b8-0b29d3bd7d9a/Screenshot_2023-06-02_at_14.03.39.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153419Z&X-Amz-Expires=3600&X-Amz-Signature=9f6d34e097d0cf7c1009d6a90dab03ba9e70f78e98a3ce7a0f5a30a5a8313a57&X-Amz-SignedHeaders=host&x-id=GetObject)


![Untitled.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e66ae0a5-0f61-4166-a873-b22304513de0/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153414Z&X-Amz-Expires=3600&X-Amz-Signature=946fde4225c96fafb7c5fdf3855c7ae05703f974b55be160629040ce4f07f211&X-Amz-SignedHeaders=host&x-id=GetObject)


Hence this task fails the utilization test. 


### Improved utilisation test for FPS


**Alternative 1**


Instead of $N $ beeing numer for tasks, let $N$ be the number of _“task families”_. A task family is a sub set of tasks with periods that are multiples of a common value eks: (8, 16, 64, 128)


| **Task**  | **Period, T** | **Computation time, C** | **Priority, P** | **Utilization, U** |
| --------- | ------------- | ----------------------- | --------------- | ------------------ |
| a         | 80            | 32                      | 1               | 0.4                |
| b         | 40            | 5                       | 2               | 0.125              |
| c         | 16            | 4                       | 3               | 0.25               |


![Untitled.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/f7e75080-a999-4dd3-9743-bb26c21f4512/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153414Z&X-Amz-Expires=3600&X-Amz-Signature=5a9a15cfc35a89c8834f37491829f7968d95df7bbc3708c92dbfbd9284c828dc&X-Amz-SignedHeaders=host&x-id=GetObject)


However, this is not sustainable. Consider task a going from 80 to 81. This alternation should make the system easiser to shcedule but since not a multiple of 40, the upper bound drops. 


**Alternativ 2** _**Harmonic Task Set Utilization schedulability test**_ 


Applies to both _Preemptiv and Non - Preemptive systems_


$$
\prod_{i=1}^N\left(\frac{C_i}{T_i}+1\right) \leq 2
$$


This condition can be applied to task set where task periods $T$, are harmonic (meaning that each task period is an integer multiple of all shorter task periods). Therefore, in general, the Harmonic Task Set Utilization test may potentially allow higher total utilizations compared to the Liu & Layland's test, but it does require the additional harmonic task set constraint.


## Respons time analysis 


is a method used in real-time systems to predict the worst-case responstime of tasks. It is particularly usful for _**fixed priority scheduling**__._ In contrast to utilization-based tests. RTA takes into accunte the effect of _priority inversion_ and _task preemptions_. This gives a more accurate and less conservative analysis of task schedulability. 


Utilization testes are based on computation times $C$ and periods of tasks $T$, and they provide a simple but coarse analysis of task schedulability. They do not account for the details of how task interact wich each other. Particullary in terms of task interference. 


In RTA, for each task we calculate _Worst-Case-Respons-Time_ (WCRT), dnoted $R$. This is the maximum time from the release of a task untill its completion. For high pri tasks $R = C$, because it wont be interupted by other tasks. Lower priority tasks on the other hand may suffer from interference from higher priority tasks and therfore have a larger respons time. 


$$
R_i = C_i + I_i
$$


The interferance $I$ is computed over the time intervall $(t, t+ R_i)$ and is approximated as the total computation time of higher priority tasks that can execute within that interval. Let $P_i < P_j$.


Then the maximum number of releases of high pri $j$ task is calculated as $\lceil\frac{R_i}{T_j} \rceil$ (celing operator). Ie how many times task $j$ can releas during the respons time of task $i$. The maxiumum interference that task can experience is then 


$$
I_i = \left\lceil\frac{R_i}{T_j} \right \rceil C_j
$$


The reason for using $C_j$ (the computation time of a higher pri task $j$ ) insead of $R_j$ lies in how task can preept each other in a fixed priority scheduling system. 


The interfernce on task $i$ due to hihger-pri task $j$ is determined by how many times task $j$ can be released (and therfore preempt task $i$ ) during the respons time of task $i$. Each time task $j$ is released, it can preempt task $i$ for up to its WCCT ($C_i$), hence we multiply with $C_j$. 


It's worth noting that this formula provides the worst-case scenario, assuming that every release of a higher-priority task will preempt the lower-priority task. In practice, the actual interference might be less.


The _**total interference**_ on task $i$, denoted $I$ is the sum of maximum interferences cased by all higher pri tasks, and whe can thus calculate the toal responstime for task $i$ as. 


$$
R_i = C_i + \sum_{j \in hp(i)}\left\lceil\frac{R_i}{T_j} \right \rceil C_j
$$


where $hp(i) $ is the set of task of higher priority than task $i$.


> If a _responstime_ $R $ is less than or equal to the _task period_ $T$ it isschedulable. If not it is not scheduable under the given _Fixed-Priority assignment_


$$
R_i<T_i
$$


Computing this is a bit difficutl bc the celing opertor. But we can construct the recurrence relation. 


$$
w_i^{n+1}=C_i+\sum_{j \in h p(i)}\left\lceil\frac{w_i^n}{T_j}\right\rceil C_j
$$


$w_i^{n+1}$ is the $(n+1)$-th estimate of the WCRT $R $ for task i. We solve this by initialising $w_i^{0} = C_i $ and then runn untill it converges $w_i^{n+1} \simeq w_i^{n}$. This iterative process gradually refines the estimate of the WCRT, taking into account more and more of the possible interference from higher priority tasks.


The relation to $P_i$ (the _busy period_ for task $i$) is that the _busy period_ can be thought of as the time interval during which task $i$ or any of the higher priority tasks are ready to execute. If we denote the set of tasks with a higher priority than task i as $hp(i)$, then one can calculate the length of the _busy period_ $P_i$ as follows


```python
for i in N:
	n := 0
	w[n] = C[i]
	while:
		wplus_one[n] = .... #Equation abve
		if wn_plus_one[n] = w[n]
			break # Found value 
		if w_plus_one[n] > T[i]:
			break # Walue not found
		n = n + 1
```


Eks:


| **Task**  | **Period, T** | **Computation time, C** | **Priority, P** |
| --------- | ------------- | ----------------------- | --------------- |
| a         | 7             | 3                       | 3               |
| b         | 12            | 3                       | 2               |
| c         | 20            | 5                       | 1               |


### Temporal constraints 


There are two types of temporal constraints, sequencing constraints and real-time constraints. Sequencing constraints specify the possible orders in which a sequence of actions or events is allowed to take place. For example, a sequencing constraint may specify that a ready signal must be received before any operation is performed on a device.
Real-time constraints specify temporal properties with an explicit reference to time. For example, a real-time constraint may specify that an event must take place 5 ms before another event takes place. This is in contrast with sequencing constraints, which specifies temporal properties using relative timing, i.e., without an explicit reference to time. That is, a sequencing constraint may specify that an event E must happen before another event E′, but it does not specify how much time event E should occur before E′.
Nontemporal constraints are properties that are not related to time. Existing work on CT has been mainly focused on nontemporal constraints. This is partly because temporal constraints involve the extra dimension of time and are thus more difficult to handle.


![Screenshot_2023-06-02_at_13.52.16.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/530407e8-04fc-4410-affa-f4f48f723fce/Screenshot_2023-06-02_at_13.52.16.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153414Z&X-Amz-Expires=3600&X-Amz-Signature=452442027c89f30de9353b40b338f5f1663ac0bec5e23c8f6dce7151fbf9542b&X-Amz-SignedHeaders=host&x-id=GetObject)

