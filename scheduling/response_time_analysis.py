import math 
import math

# Each task is represented as a list [C, T, P] where C is the computation time, T is the period, 
# and P is the priority. Higher number means higher priority.
tasks = [[3, 7, 3], [3, 12, 2], [5, 20, 1]]

# Sort tasks by priority
tasks.sort(key=lambda x: x[2], reverse=True)

n_tasks = len(tasks)

# Initialize worst-case response times as computation times
Ws = [[task[0]] for task in tasks]

# Response time analysis
for i, task_i in enumerate(tasks):
    while True:
        W_prev = Ws[i][-1]
        W_new = task_i[0] + sum(
            [math.ceil(W_prev / tasks[j][1]) * tasks[j][0] for j in range(i)]
        )
        if W_new == W_prev or W_new > task_i[1]:
            break
        else:
            Ws[i].append(W_new)

for i, task in enumerate(tasks):
    if Ws[i][-1] <= task[1]:
        print(f"Task with priority {task[2]} is schedulable with worst-case response time {Ws[i][-1]}")
    else:
        print(f"Task with priority {task[2]} is not schedulable")


def run(A):
    print(A)
    print(type(A))