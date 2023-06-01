
# Scheduling 


There are two main types of CPU scheduling, preemptive and non-preemptive. Preemptive scheduling is when a process transitions from a running state to a ready state or from a waiting state to a ready state. Non-preemptive scheduling is employed when a process terminates or transitions from running to waiting state.


> 🥨 P**reemtpiv scheduling** the CPU is allocated to the processes for a specific time period  
>                                         tasks are switched based on priority


> 🥨 **Non-preemtptive scheduling** CPU is allocated to the process untill it terminates  
>                                                      no switching takes place


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

