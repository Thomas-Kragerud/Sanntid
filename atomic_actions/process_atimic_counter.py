from multiprocessing import Process, Value, Lock

# has some additional overhead compared to threading. Needs to start a new proces for each task
# and needs to serialize and deserialize data when sharing it between processes.
# often wort it for CPU-bound tasks, because multiprocessing allows these tasks to run in true parallel.



def increment(counter, lock):
    for _ in range(2):
        # Acquire the lock before modifying counter
        with lock:
            counter.value += 1

if __name__ == "__main__":
    # counter is a shared variable that all processes will increment
    counter = Value('i', 0)
    # counter_lock is used to ensure that increments are (practically) atomic
    counter_lock = Lock()

    # Create two processes.
    process1 = Process(target=increment, args=(counter, counter_lock))
    process2 = Process(target=increment, args=(counter, counter_lock))

    # Start the processes
    process1.start()
    process2.start()

    # wait for the processes to finish
    process1.join()
    process2.join()

    print("Final counter: ", counter.value)