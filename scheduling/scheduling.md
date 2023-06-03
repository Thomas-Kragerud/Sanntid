
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


If a task is waiting for a lower-priority task, it is sait to be **blocked**. 


### Interference 


refers to the sistuation where the excecution of a task is delayed due to execution of higher priority tasks. 


### Busy Period


The busy period in a real-time system typically refers to a continuous interval of time during which the processor (CPU) is continuously busy, meaning it has tasks to execute and isn't idle. This doesn't necessarily mean a specific task is continuously executing. It means that at least one task in the system is ready to execute.


For a specific task, the busy period reffers to the longes intervall during which it is ready to run, but not necessarily running the entire time. This includes the time it is executing (being worked on by the CPU) as well as the time it might be ready to execute but is waiting due to higher priority tasks running or due to other forms of interference. 


## Read up on 

- Context Switching
- Makros
- Monitors

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

### Simple task model 


> 🥨 Simple model to describe some simple scheduling schemes   
> Must imopse some restrictions on the structure of the real-time concurrent program 

1. **Tasks are periodic**: It's assumed that each task repeats at a fixed rate. This assumption helps in scheduling and determining whether the system is schedulable.
2. **Execution times are constant**: Each instance of a task is assumed to take the same amount of time to execute. This is often an average or worst-case execution time.
3. **All tasks are independent**: It's assumed that tasks do not share resources (except the processor), and there's no inter-task communication. This implies there are no synchronization issues.
4. **Task preemption is allowed**: Any task can be interrupted by a higher priority task. This is required by many scheduling algorithms.
5. **Tasks are prioritized**: Each task has a priority and the scheduler always selects the highest priority task that is ready to run.
6. **Tasks have zero switch time**: This means the time taken to switch the CPU from one task to another is negligible.
7. **All tasks are released as soon as the system starts**: All tasks are ready to run at time zero.

Regarding realism, these assumptions are often an oversimplification of reality. In actual systems:

1. Tasks can be sporadic or aperiodic.
2. Execution times can vary from one instance of a task to another.
3. Tasks often need to share resources or communicate with each other, which can lead to synchronization and deadlock issues.
4. Task preemption can be costly in terms of time and resources, and isn't always possible or desirable. Non-preemptive scheduling is often used in certain systems.
5. The context switch time (time taken to switch the CPU from one task to another) can be significant, particularly for systems with complex tasks or limited resources.
6. Tasks often do not start all at the same time; they may be released according to different schedules or in response to specific events.

Despite these oversimplifications, these assumptions are still widely used because they simplify the design and analysis of real-time systems. More complex models and algorithms are needed to handle cases where these assumptions do not hol


### Round Robin 


is one of the simples, oldest, and most widely used scheduling algorithms in operating systems. It is designef for _time-sharing systems_ and involves _preemptive scheduling._ 


Each task gets a fixed amount of (CPU) time known as Quantum and there is no other ordering (priority) scheme than the FIFO queue. When a process has used up its quantum it is placed in the end of the queue, and the next task is given control of the processor. 


The Round Robin scheduling algorithm is simple and fair, as it gives each task an equal share of the CPU time. However, it doesn't take into account the priority of tasks or their expected execution time, which can lead to inefficiencies, particularly in systems with widely varying task demands. For example, it can lead to higher average waiting times compared to other more sophisticated scheduling algorithms.

1. **Lack of priority handling**: In real-time systems, certain tasks may have a higher priority (such as those that are safety-critical or time-sensitive). Round Robin scheduling doesn't inherently account for these differences in priority. All tasks, regardless of their importance or urgency, are given equal time with the processor.
2. **Response time**: If there are many tasks in the system, a task may have to wait a long time for its turn to be scheduled, leading to longer response times. This can be a significant issue in real-time systems where tasks often need to be completed within a strict deadline.
3. **Poor performance with varied task lengths**: If the tasks vary widely in length, Round Robin can perform poorly. Short tasks can be delayed behind long ones, and long tasks can be frequently interrupted.

**Turnaround time →**time from arrival to finished 


**Waiting time →** Turnaround time - Burst time 


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


For **Rate monotonic sheduling**, a type of FPS where the task with the shortest period gets the highest priority. We have _**Liu & Laylands utilization-based schedulability test**__,_ which represent an upper bound on the C


PU utilization for which task can be guaranteed to meet their deadlines under RMS. The test thus applies to preemptive scheduling. 


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


![Time-line for the task set above](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/65ab681c-d00f-447d-b72d-d03ab04f0b81/Screenshot_2023-06-02_at_13.52.31.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092529Z&X-Amz-Expires=3600&X-Amz-Signature=5106534a3f612f08a8ca6af46f2a4b0a77025f4461b8828c0da215e012a058ba&X-Amz-SignedHeaders=host&x-id=GetObject)


![Gnatt chart for task set A](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/95208ac8-c37d-40aa-96b8-0b29d3bd7d9a/Screenshot_2023-06-02_at_14.03.39.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092529Z&X-Amz-Expires=3600&X-Amz-Signature=5a9a59c6e5c54bfab4194a2bc66d8275377f74da28d0a74610d58b08ef88b236&X-Amz-SignedHeaders=host&x-id=GetObject)


![Untitled.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e66ae0a5-0f61-4166-a873-b22304513de0/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=1b2933470c3625bff083e495dc5ce22cf4e62598551cd53c3f33fb38ad45843d&X-Amz-SignedHeaders=host&x-id=GetObject)


Hence this task fails the utilization test. 


### Improved utilisation test for FPS


**Alternative 1**


Instead of $N $ beeing numer for tasks, let $N$ be the number of _“task families”_. A task family is a sub set of tasks with periods that are multiples of a common value eks: (8, 16, 64, 128)


| **Task**  | **Period, T** | **Computation time, C** | **Priority, P** | **Utilization, U** |
| --------- | ------------- | ----------------------- | --------------- | ------------------ |
| a         | 80            | 32                      | 1               | 0.4                |
| b         | 40            | 5                       | 2               | 0.125              |
| c         | 16            | 4                       | 3               | 0.25               |


![Untitled.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/f7e75080-a999-4dd3-9743-bb26c21f4512/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=6a87d0f082b79398f0649dcd4029f22281a65389b6dedc5db4494a326f780569&X-Amz-SignedHeaders=host&x-id=GetObject)


However, this is not sustainable. Consider task a going from 80 to 81. This alternation should make the system easiser to shcedule but since not a multiple of 40, the upper bound drops. 


**Alternativ 2** _**Harmonic Task Set Utilization schedulability test**_ 


Applies to both _Preemptiv and Non - Preemptive systems_


$$
\prod_{i=1}^N\left(\frac{C_i}{T_i}+1\right) \leq 2
$$


This condition can be applied to task set where task periods $T$, are harmonic (meaning that each task period is an integer multiple of all shorter task periods). Therefore, in general, the Harmonic Task Set Utilization test may potentially allow higher total utilizations compared to the Liu & Layland's test, but it does require the additional harmonic task set constraint.


## Respons time analysis 


> 😃 Sufficient & Necessary  
> FPS  
> 


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


> Respons time analysis for FPS is both sufficient and necessary, meaning that if it fails it wil fail and if it succeedes it will be sechulable at runtime.


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


![Untitled.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/f4e38d0d-0a41-4d69-b6df-2bbe2cd18d76/Untitled.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=8ee6a474295044974f69475947f7723fae94f7f31cabf8335ad1554808c24ef8&X-Amz-SignedHeaders=host&x-id=GetObject)


### Shorter Deadline than peropd 


In real-time systems, the period $T$ of a task is the time interval between consecutive instances of the task, and the deadline $D$ is the time by which the task must finish execution. When the deadline is equal to the period ($D = T$), the _**Rate Monotonic Priority Ordering**_ (RMPO) can be used. In RMPO, the priority of a task is inversely proportional to its period; i.e., the shorter the period, the higher the priority.


However, in some systems, the deadline of a task can be less than its period (D<T). In these cases, the _**Deadline Monotonic Priority Ordering**_ (DMPO) is used. DMPO assigns priority based on the deadline of the tasks, where the task with the shorter deadline has a higher priority. This is more intuitive because tasks that need to be completed sooner are given higher priority.


Any task set that passes a _Fixed Priority Scheduling_ (FPS) schedulability test (like RMPO or DMPO) will also meet its timing requirements if executed under EDF


## Task interactions and Blocking 


Example: 


We have 4 tasks $a, b, c, d$. Task $d$ has the highest pri and task $a$ the lowest.


[$a$ and $d$] share a critical section $Q$, [$d$ and $c$] share also shares a critical section $V$. 


A _**critical section**_ is like a data structure or a device. To prevent corrupation of data, <u>only one task can access this shared resource at a time</u>, which is ensured through mutual exclusion. 


![Screenshot_2023-06-02_at_20.15.39.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/b4d4cf21-f984-4343-a9bf-8e4fb3b80ce4/Screenshot_2023-06-02_at_20.15.39.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=70e304b2e0d7615ea5fc9914a74e6f0aecd62eb69857e29f82f21b1daedfce4c&X-Amz-SignedHeaders=host&x-id=GetObject)

- Task $a$ released first and immediatly locks the critical section $Q$
- Task $c$ is released next and preempts task $a$, (interrups and temporaly takes over). $C$ locks the critical section $V$
- Task $d$, highest pri task is then releaset. Executes until it need to lock the critical section $Q$. However $Q$ is allready locked by $a$. As a result $d$ must wait and $c$ continous (_priority inversion_)
- Once task $c$ is done, task $b$ starts running. Task $a$ only continues once $b $ is finished, after which it completes it use of $Q$ and lets $d$ continue.

In this scenario, task d experiences significant priority inversion. It gets blocked not just by lower priority task a, but also by tasks b and c. This blocking can severely affect the system's schedulability, the ability of a system to ensure all tasks complete within their deadlines.


![Screenshot_2023-06-02_at_20.18.33.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/45011e9e-f6a6-45d8-b7d6-6d489b1321ce/Screenshot_2023-06-02_at_20.18.33.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=32cf965a4c5e66f26e1358faf5e22062838e0a4fb8cdd69ae030200c4f40fd24&X-Amz-SignedHeaders=host&x-id=GetObject)


### Priority inheritance 


A solution to this problem can be to incorperate _**priority inheritance**__._ With _priority inheritance_ task priority is no longer static. Task $a$ will therfore inherit the priority of task $d$, and will run in preference to task $c$ and $b$. A consequence is that task $b $ will suffer from _blockeing_ even though it does not share a resource. 


![Priority inheritance with example above](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/ad4b98cf-6d37-4ddf-bb20-de16ceafe44e/Screenshot_2023-06-02_at_20.27.42.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=be57bf4c6c040ccae1296c18d13007c64fd9355e850c5d11532d3bd24ce22ed3&X-Amz-SignedHeaders=host&x-id=GetObject)


There is a limit to how often a high-pri task can be blocked by low pri tasks. Let $i$ be a task that has to go through $n$ _critial sections._ Then in worst case scenario where each of these critical sections is already being used by a lower-pri task, our higher pri task $i$ could be blocked $n$ times. 


If the number of lower-prioritytask $m$ is less than the number of critical sections $n$ ($m < n )$. Then the maximum blocking of task $i$ is $m$. 


We define $B$ as **longes time that our task can be blocked**. For a _**basic priority inheritance protocol**_, we can calculate $B$ using this formula. 


$$
B_i = \sum_{k=1}^{K}\text{usage}(k, i)C(k)
$$


The $\text{usage}$ is a binary function. For a given critical section $k$ and task $i$, the $\text{usage}(k, i)$ is $1$ if resource $k$ is accessed by atleast one task with lower priority than $i$ and on task with priority equal to or greater than $i$. Otherwise, it gives a result of 0.


$C(k) $ is the worst-case execution time of critical section $k$.


The formula assumes single cost for using a resource. Additionally, it sums up the blocking times from each resource, but this only makes sense if resource is used by a different lower priority task. If all resources are used by the same lower-priority task, there should only be one term included in the equation for $B$. 


With the addition of longest blocking time $B$, we can reformulate our formula for WCRT $R$. 


$$
R = C + B + I
$$


 That is, 


$$
R_i = C_i + B_i + \sum_{j \in hp(i)}\left\lceil\frac{R_i}{T_j}\right\rceil C_j
$$


which then gives, 


$$
w_i^{n+ 1} = C_i + B_i + \sum_{j \in hp(i)}\left\lceil\frac{w_i^n}{T_j}\right\rceil C_j
$$


However, this may not be a very efficient method as it can lead to overestimation of the blocking time. Whether a task will experience its maximum blocking time will depend on the phasing of the tasks. If all tasks are periodic and share the same period, there will be no preemption, and hence no priority inversion will occur.


### Temporal constraints 


There are two types of temporal constraints, sequencing constraints and real-time constraints. Sequencing constraints specify the possible orders in which a sequence of actions or events is allowed to take place. For example, a sequencing constraint may specify that a ready signal must be received before any operation is performed on a device.
Real-time constraints specify temporal properties with an explicit reference to time. For example, a real-time constraint may specify that an event must take place 5 ms before another event takes place. This is in contrast with sequencing constraints, which specifies temporal properties using relative timing, i.e., without an explicit reference to time. That is, a sequencing constraint may specify that an event E must happen before another event E′, but it does not specify how much time event E should occur before E′.
Nontemporal constraints are properties that are not related to time. Existing work on CT has been mainly focused on nontemporal constraints. This is partly because temporal constraints involve the extra dimension of time and are thus more difficult to handle.


![Screenshot_2023-06-02_at_13.52.16.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/530407e8-04fc-4410-affa-f4f48f723fce/Screenshot_2023-06-02_at_13.52.16.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230603%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230603T092525Z&X-Amz-Expires=3600&X-Amz-Signature=ecb0fc0aa49a1b2e1d82c7077dc1aa330856114dfebfe8e69577e298ccd62b43&X-Amz-SignedHeaders=host&x-id=GetObject)

