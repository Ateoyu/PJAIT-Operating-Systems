## Ex01
**Task:** 
✅ Task 1 – Three child processes
Write a program that:
- Creates three child processes (`fork()`).
- Each child process should:
  - print its `PID` and `PPID`,
  - terminate with `exit(i)` (where `i` is the process number).
- The parent process should:
  - wait for each child separately (`waitpid()`),
  - print information about the termination of children: `PID` + exit code (`WEXITSTATUS()`).

**Solution:**
```c
#include <signal.h>  
#include <stdio.h>  
#include <unistd.h>  
#include <_stdlib.h>  
#include <sys/_types/_pid_t.h>  
  
void child_process_work(const int process_number) {  
    printf("I am child %d process with the PID: %d and the PPID: %d.\n",process_number, getpid(), getppid());  
    exit(process_number);  
}  
  
int main(int argc, char *argv[]) {  
    pid_t pid[3];  
  
    for (int i = 0; i < 3; i++) {  
        pid[i] = fork();  
  
        if (pid[i] < 0) {  
            printf("Failed to create fork.\n");  
            return EXIT_FAILURE;  
        }  
        if (pid[i] == 0) {  
            child_process_work(i + 1);  
        }  
        sleep(1);  
    }  
  
    for (int i = 0; i < 3; ++i) {  
        int status;  
        waitpid(pid[i], &status, 0);  
        if (WIFEXITED(status)) {  
            printf("Im the parent process and child %d has been terminated.\n", i + 1);  
            printf("Child's PID: %d and exit status: %d.\n", pid[i], WEXITSTATUS(status));  
        }  
    }  
  
    return EXIT_SUCCESS;  
}
```
## Ex02
**Task:** 
✅ Task 2 – `fork()` and process identification
Write a program that:

- Creates one child process.
- The child:
  - prints its `PID` and `PPID`,
  - sleeps for 2 seconds,
  - checks `PPID` again (if it has changed to 1),
  - terminates.
- The parent terminates immediately, without `wait()`. ❓Does the parent change? If so, who is the new parent?

**Solution:**
```c
#include <stdio.h>  
#include <unistd.h>  
#include <_stdlib.h>  
#include <sys/_types/_pid_t.h>  
  
int main(int argc, char *argv[]) {  
    pid_t pid = fork();  
  
    if (pid < 0) {  
        printf("Failed to create fork.\n");  
        return EXIT_FAILURE;  
    }  
    if (pid == 0) {  
        printf("I am a child process. My PID: %d. My PPID: %d.\n", getpid(), getppid());  
        sleep(2);  
        printf("I woke up from my 2 second nap, my PPID now is: %d.\n", getppid());  
        exit(EXIT_SUCCESS);  
    }  
  
    sleep(1);  
    return EXIT_SUCCESS;  
}
```
## Ex03
**Task:**
✅ Task 3 – Two child processes with order
Write a program that:
- Creates two child processes.
- Process 1:
  - prints “I am process 1”,
  - terminates after 1 second.
- Process 2:
  - waits 2 seconds,
  - prints “I am process 2”,
  - terminates.
The parent should use `waitpid()` and print **which process finished first and which process finished second.**

**Solution:**
```c
#include <stdio.h>  
#include <stdlib.h>  
#include <unistd.h>  
#include <sys/_types/_pid_t.h>  
  
void child_process_work(const int process_number) {  
    printf("I am child %d.\n", process_number);  
    sleep(process_number);  
    exit(EXIT_SUCCESS);  
}  
  
int compare_pid(const int pid_to_find, const pid_t process_array[], const size_t array_length) {  
    int process_number = 0;  
    for (int i = 0; i < array_length; ++i) {  
        if (process_array[i] == pid_to_find) {  
            process_number = i + 1;  
        }  
    }  
    return process_number;  
}  
  
int main(int argc, char *argv[]) {  
    pid_t pid[2];  
  
    for (int i = 0; i < 2; i++) {  
        pid[i] = fork();  
  
        if (pid[i] < 0) {  
            printf("Failed to create fork.\n");  
            return EXIT_FAILURE;  
        }  
        if (pid[i] == 0) {  
            child_process_work(i + 1);  
        }  
    }  
    int status;  
  
    int finished_process = wait(&status);  
    int finished_process_number = compare_pid(finished_process, pid, sizeof pid / sizeof pid[0]);  
    printf("The first finished process is %d with PID: %d.\n", finished_process_number ,finished_process);  
  
    finished_process = wait(&status);  
    finished_process_number = compare_pid(finished_process, pid, sizeof pid / sizeof pid[0]);  
    printf("The second finished process is %d with PID: %d.\n", finished_process_number ,finished_process);  
  
    return EXIT_SUCCESS;  
}
```
## Ex04
**Task:**
✅ Task 4 – Child waits for another process
Write a program that:
- Creates a child.
- The child creates its child (i.e. grandson).
- The grandson process:
  - prints “Grandson is working”, sleeps for 2 seconds, exits(5).
- The child process:
  - waits for the grandson to finish (wait()),
  - prints the PID of the finished process and WEXITSTATUS.
- The parent process:
  - does not wait for anyone and finishes immediately.

**Solution:**
```c
#include <stdio.h>  
#include <stdlib.h>  
#include <unistd.h>  
#include <sys/_types/_pid_t.h>  
  
int main(int argc, char *argv[]) {  
    const pid_t pid = fork();  
  
    if (pid < 0) {  
        printf("Failed to create fork.\n");  
        return EXIT_FAILURE;  
    }  
    if (pid == 0) {  
        const pid_t pid_child = fork();  
  
        if (pid_child < 0) {  
            printf("Failed to create fork.\n");  
            return EXIT_FAILURE;  
        }  
  
        if (pid_child == 0) {  
            printf("I am a grandchild process and I work.\n");  
            sleep(2);  
            exit(5);  
        }  
  
        int status;  
        waitpid(pid_child, &status, 0);  
        if (WIFEXITED(status)) {  
            printf("Grandchild terminated with PID: %d and Status code: %d.\n", pid_child, status);  
        }  
  
        exit(EXIT_SUCCESS);  
    }  
  
    return EXIT_SUCCESS;  
}
```
## Ex05
**Task:**
✅ Task 5– Process tree
Create a program that builds the structure:
```
Parent
├── Child 1
│ └── Grandchild 1
└── Child 2
└── Grandchild 2
```
Each process should list its:
- **PID**, **PPID**, level in the tree
- role name (e.g. “Child 1”)

**Solution:**
```c
#include <stdio.h>  
#include <stdlib.h>  
#include <unistd.h>  
#include <sys/_types/_pid_t.h>  
  
int main(int argc, char *argv[]) {  
    printf("Parent Process. PID: %d. PPID: %d.\n", getpid(), getppid());  
    pid_t pid[2];  
    for (int i = 0; i < 2; i++) {  
        pid[i] = fork();  
  
        if (pid[i] < 0) {  
            printf("Failed to create fork.\n");  
            return EXIT_FAILURE;  
        }  
        if (pid[i] == 0) {  
              printf("Child %d process. PID: %d. PPID: %d.\n", i + 1, getpid(), getppid());  
            pid_t pid_child = fork();  
  
            if (pid_child < 0) {  
                printf("Failed to create fork.\n");  
                return EXIT_FAILURE;  
            }  
  
            if (pid_child == 0) {  
                printf("Grandchild %d process. PID: %d. PPID: %d.\n", i + 1, getpid(), getppid());  
                exit(EXIT_SUCCESS);  
            }  
  
            int grandchild_status;  
            waitpid(pid_child, &grandchild_status, 0);  
            exit(EXIT_SUCCESS);  
        }  
        int status;  
        waitpid(pid[i], &status, 0);  
    }  
  
    return EXIT_SUCCESS;  
}
```
