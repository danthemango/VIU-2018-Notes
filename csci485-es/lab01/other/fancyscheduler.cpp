/************************************************
 Filename:   scheduler.cpp
 Author:     Daniel Guenther (565154853)
 Date:       2017-09-14
 Class:      CSCI 485
 Project:    lab01
 Description
   test of the RIOS scheduling system,
   it uses a simple ring_counter as an example task
 Sources
   most of the code taken from http://www.cs.ucr.edu/~vahid/rios/
      - to establish the pattern of the RIOS scheduler
   some taken from the man page for timer_create
   and some from https://stackoverflow.com/questions/5740954/problem-in-timers-and-signal
      - to uncover the use of timer_create
**************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <time.h>

// Debugging state
#define DEBUG 0
#define CLOCKID CLOCK_REALTIME
#define SIG SIGUSR1
timer_t timerid;

// set the number of jobs we are doing 
const unsigned int numtasks = 1;

typedef struct task {
   unsigned long elapsedTime; // Time since task start
   int state;                 // Current state
   int (*TickFct)(int);       // Function to call for task's tick
   unsigned long deadline;    // Deadline for entire task cycle
   bool done;                 // True if task cycle has been completed
   int startState;            // starting state
   int finalState;            // final state of task
} task;

// our ring_counter FSM
enum ring_states { ring_init, ring_1, ring_2, ring_3, ring_4, ring_final };
int ring_counter(int state);

// structure for the timing system
struct timeSystemDef{
   struct sigevent sev;
   struct itimerspec its;
   long long freq_nanosecs;
   sigset_t mask;
   struct sigaction sa;
};
timeSystemDef timeSystem;
// turns the timing system on
void TimerOn();
// sets the number of seconds between timer interrupts
void TimerSet(unsigned long cycleTime);
// queue tasks if true
unsigned char TimerFlag = 0;
// timer interrupt handler
void TimerISR(int sig, siginfo_t *si, void *uc);

int main(void) {
   task tasks[numtasks];
   const unsigned long tasksPeriodGCD = 1000;    // Timer tick rate (milliseconds)

   // instantiate the ring_counter
   unsigned char i = 0;
   tasks[i].elapsedTime = 0;
   tasks[i].TickFct     = &ring_counter;
   tasks[i].state       = ring_init;
   tasks[i].done        = false;
   tasks[i].deadline    = 10000; // ring_counter should complete in 10 seconds
   tasks[i].startState  = ring_init;
   tasks[i].finalState  = ring_final;

   TimerSet(tasksPeriodGCD);
   TimerOn();

   while(1) {
      // Heart of the scheduler code
      for (i = 0; i < numtasks; ++i) {
         if (!tasks[i].done && tasks[i].elapsedTime >= tasks[i].period) { // Ready
            // execute next stage of task, and check if task is done
            tasks[i].state = tasks[i].TickFct(tasks[i].state);
            if(tasks[i].state == tasks[i].finalState){
               tasks[i].done = true;
            }
            tasks[i].elapsedTime = 0;
         }else{
            tasks[i].elapsedTime += tasksPeriodGCD;
            // check if task should be put back on queue
            if(tasks[i].totalElapsedTime >= tasks[i].deadline){
               // error if task didn't complete
               if(!tasks[i].done){
                  printf("error: task did not complete in time\n");
               }else{
                  tasks[i].done = false;
               }
               tasks[i].state = tasks[i].startState;
               tasks[i].totalElapsedTime = 0;
            }
         }
         tasks[i].totalElapsedTime += tasksPeriodGCD;
      }
      TimerFlag = 0;
      // wait until next cycle
      while (!TimerFlag) {
         // Sleep();
      }
   }
   return 0;
}

int ring_counter(int state) {
   switch(state) { // Transitions
      case ring_init: // Initial transition
         state = ring_1;
         break;
      case ring_1: // Initial transition
         state = ring_2;
         break;
      case ring_2: // Initial transition
         state = ring_3;
         break;
      case ring_3: // Initial transition
         state = ring_4;
         break;
      case ring_4: // Initial transition
         state = ring_final;
         break;
      case ring_final: // Initial transition
         state = ring_init;
         break;
      default:
         state = ring_init;
   }
   switch(state) { // State actions
      case ring_init:
         break;
      case ring_1:
         printf("1\n");
         break;
      case ring_2:
         printf("2\n");
         break;
      case ring_3:
         printf("3\n");
         break;
      case ring_4:
         printf("4\n");
         break;
      case ring_final:
         printf("5\n");
         break;
      default:
         break;
   }
   return state;
}

// instantiates the number of milliseconds between TimerISR calls
void TimerSet(unsigned long cycleTime){
   timeSystem.sa.sa_flags = SA_SIGINFO;
   timeSystem.sa.sa_sigaction = TimerISR;
   sigemptyset(&timeSystem.sa.sa_mask);
   sigaction(SIG, &timeSystem.sa, NULL);

   timeSystem.sev.sigev_notify = SIGEV_SIGNAL;
   timeSystem.sev.sigev_signo = SIG;
   timeSystem.sev.sigev_value.sival_ptr = &timerid;
   timer_create(CLOCKID, &timeSystem.sev, &timerid);

   // set the interval 
   timeSystem.its.it_value.tv_sec = cycleTime/1000;
   timeSystem.its.it_value.tv_nsec = (cycleTime%1000)*1000000;
   timeSystem.its.it_interval.tv_sec = timeSystem.its.it_value.tv_sec;
   timeSystem.its.it_interval.tv_nsec = timeSystem.its.it_value.tv_nsec;

   if(DEBUG){
      printf("TimerSet with %lums cycleTime\n",cycleTime);
      printf("%lus\n%luns\n",timeSystem.its.it_value.tv_sec, timeSystem.its.it_value.tv_nsec);
   }
}

// turns the timing system on
void TimerOn()
{
   /* Start the timer */
   timer_settime(timerid, 0, &timeSystem.its, NULL);
}

// timing interrupt handler
void TimerISR(int sig, siginfo_t *si, void *uc)
{
   if(DEBUG){
      printf("TimerISR\n");
   }
   if (TimerFlag) {
      printf("Timer ticked before task processing done.\n");
   }
   else {
      TimerFlag = 1;
   }
   return;
}
