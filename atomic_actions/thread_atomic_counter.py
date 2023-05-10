import threading

# Python does not have same concept of goroutines as go
# and pythons Global Interpreter Lock (GIL) prevents true parallel execution of threads within a single process
# by ensuring that only one thread executes python bytecodes at the time within a single process, even on a multicore
# processor. Thus, threads are never truly running at the same time.
#
# However, Pythons 'threading' module can be used to simulate concurrent execution for I/O-bound tasks
# and its 'multiprocessing' module can be used for CPU-bound tasks that benefit from true parallelism
#
# GIL is a mutex that protects access to python objects. Simplifies many of the low-level details in Pythons
# implementation and helps with memory management.
#
# For I/O bound programs, where program spends most of its time waiting for input/output operations, such as
# network or disk operations. Using threads can speed up your program. Because while one thread is waiting for I/O
# operations to complete, other can continue execution.
# But for CPU-bound programs, where program spends most of its time doing CPU computations, then Pythons threading
# module will not speed up your program to the GIL
#
# The multiprocessing module separates Python processes, and each process gets its own Python interpreter and
# memory space, and hence its own GIL. This allows multiple tasks to run.
#
# Process is an instance of a program, like a Python interpreter. Each process has its own memory space and its own
# instance of the Python interpreter. Processes can run independently and can be scheduled by the operating system
# to run on different cores in a multicore machine.
# A thread on the other hand, is a subset of a process. Threads within the same process share the same memory space
# and can communicate with each other more easily than separate processes can. However, due to the GIL threads in the
# same processes can not truly execute in parallel on different cores. 

counter = 0
counter_lock = threading.Lock()


def increment():
    global counter
    for _ in range(2):
        # Acquire the lock before modifying the counter
        with counter_lock:
            counter += 1


# Create two threads
thread1 = threading.Thread(target=increment)
thread2 = threading.Thread(target=increment)

# Start the threads
thread1.start()
thread2.start()

# Wait for the threads to finish
thread1.join()
thread1.join()

print("Final counter: ", counter)
