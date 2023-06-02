
# Semaphores & Synchronization


## Intro 


Sofrtware based solution to the shyncronisation problem 


Also called _**spinlock**_ spins while for the locks, waisting CPU cycles. 


### Wait


**Busy - waiting Semaphore**


```go
// Wait()
P (Semaphore S) {
	while(S <= 0)
		; // No opperation
			// Loop untill false, wait to enter critical section 
	S --; // Decrement and enter critical section 
}
```


In practice, semaphore implementations usually avoid busy-waiting by putting the waiting thread or process to sleep, so it doesn't consume CPU resources while waiting for the semaphore to be available. When the semaphore becomes available, the waiting thread or process is woken up by the operating system or runtime and can continue its execution.


In many programming languages and libraries, semaphore implementations use synchronization primitives provided by the operating system or runtime to efficiently handle waiting and signaling, without relying on busy-waiting. Examples include POSIX semaphores in C/C++, **`java.util.concurrent.Semaphore`** in Java, and **`asyncio.Semaphore`** in Python.


### Signal 


```go
V(Semaphore S) {
	S++;
}
```


Has now released the semaphore 


### 1. Binary Semaphore 


> 👇🏻 The value of a binary semaphore can range only between 0 and 1. On some systems, binary semaphores are known as mutex locks, as the are locks that provide mutual exclusion.


### 2. Counting Semaphore


> 👇🏻 Its value can range over an unrestricted domain. It is used to control acces to a resource that has multiple instances.

- Say we have the processes P1, P2, P3
- We have the resources R1, R2
- So two of the 3 processes can acces a shared resource simultaniosly
- We then initialise the semaphore S = 2

## Avoid Busy waiting - Solution 1

- Rather than engaging in busy waiting, the process can block itself
- The block operations places the process into a _**waiting queue**_ associated with the semaphore, and the state of the process is switched to the _**waiting state**_
- Then control is transferred to the CPU scheduler, which selects another process to execute
- Are not waisting CPU
- However can still result in Deadlocks and Starvation

The implementaion of a semaphore with a waiting queue may result in a situation where two or more processes are waiting indefinitely for an event that can be caused only by one of the waiting processes. 


### Deadlock Example 


![Screenshot_2023-05-08_at_19.32.48.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/93140541-7c49-4702-a0df-f6ead4ae4fd1/Screenshot_2023-05-08_at_19.32.48.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153452Z&X-Amz-Expires=3600&X-Amz-Signature=cd0e4e2624d44d7cce687190e9066011b9616370045c6cd80484024d29cd9b61&X-Amz-SignedHeaders=host&x-id=GetObject)


![Screenshot_2023-05-08_at_19.32.57.png](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0adefb3e-87d5-42c4-a13c-654b7a7c3836/Screenshot_2023-05-08_at_19.32.57.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230602%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230602T153452Z&X-Amz-Expires=3600&X-Amz-Signature=3a77db25de8a77af389eb5ba8edb6923d7664dc0b933ce49839c8361d85f3b64&X-Amz-SignedHeaders=host&x-id=GetObject)


## The Bounded-Buffer Problem 


A classic problems of Synchronisation.


Produces consumer problem. 

