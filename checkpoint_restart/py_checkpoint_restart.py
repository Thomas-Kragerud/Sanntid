import os
import sys
import time

checkpoint_file = "py_file.txt"


def process_data(start, end):
    for i in range(start, end + 1):
        create_checkpoint(i)
        print(f'Processing {i}')
        time.sleep(1)
    print("Processing complete")


def create_checkpoint(value):
    with open(checkpoint_file, "w") as file:
        file.write(str(value))


def loade_checkpoint():
    if os.path.exists(checkpoint_file):
        with open(checkpoint_file, "r") as file:
            return int(file.read().strip())
    return 0


if __name__ == "__main__":
    start = loade_checkpoint()
    end = 10

    try:
        process_data(start, end)
    except KeyboardInterrupt:
        mid = loade_checkpoint()
        print(f"\nCheckpoint created at {mid}")
        sys.exit(1)
    finally:
        # Completed successfully, delete checkpoints
        if os.path.exists(checkpoint_file):
            if loade_checkpoint() == end:
                os.remove(checkpoint_file)
