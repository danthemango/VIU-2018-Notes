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
      - to establish the pattern of the RIOS scheduler code
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

#define DEBUG 0               // debugging mode
#define CLOCKID CLOCK_REALTIME
#define SIG SIGUSR1
timer_t timerid;

// set the number of jobs we are doing 
const unsigned int numtasks = 1;

typedef struct task {
   unsigned long elapsedTime; // time since starting first task
   unsigned long deadline;    // Deadline for entire task cycle
   int state;                 // Current state
   int (*TickFct)(int);       // Function to call for task's tick
   bool done;                 // True if task cycle has been completed
   int startState;            // starting state
   int finalState;            // final state of task
} task;

// our ring_counter FSM
enum ring_states { ring_init, ring_1, ring_2, ring_3, ring_4, ring_final };
int ring_counter(int state);

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
   const unsigned long tasksPeriodGCD = 1000; // 1s per tick

   // instantiate the ring_counter
   unsigned char i = 0;
   tasks[i].elapsedTime = tasksPeriodGCD;
   tasks[i].TickFct     = &ring_counter;
   tasks[i].state       = ring_init;
   tasks[i].done        = false;
   tasks[i].deadline    = 10000; // deadline is 10s
   tasks[i].startState  = ring_init;
   tasks[i].finalState  = ring_final;

   TimerSet(tasksPeriodGCD);
   TimerOn();

   while(1) {
      // Heart of the scheduler code
      for (i = 0; i < numtasks; ++i) {
         if(DEBUG){
            printf("elapsed time: %d\n",tasks[i].elapsedTime);
         }
         // reset task if it has reached the deadline
         if(tasks[i].elapsedTime >= tasks[i].deadline){
            if(!tasks[i].done){
               printf("error: task did not complete before deadline\n");
            }
            tasks[i].done = false;
            tasks[i].state = tasks[i].startState;
            tasks[i].elapsedTime = 0;
         // otherwise run queued task
         }else if(!tasks[i].done){
            tasks[i].state = tasks[i].TickFct(tasks[i].state);
            if(tasks[i].state == tasks[i].finalState){
               tasks[i].done = true;
            }
         }
         tasks[i].elapsedTime += tasksPeriodGCD;
      }
      // busy wait loop
      TimerFlag = 0;
      while (!TimerFlag) {
         // Sleep();
      }
   }
   return 0;
}

int ring_counter(int state) {
   switch(state) { // Transitions
      case ring_init: // Initial state
         state = ring_1;
         break;
      case ring_1:
         state = ring_2;
         break;
      case ring_2:
         state = ring_3;
         break;
      case ring_3:
         state = ring_4;
         break;
      case ring_4:
         state = ring_final;
         break;
      case ring_final: // final state
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

// structure for the timing system
struct timeSystemDef{
   struct sigevent sev;
   struct itimerspec its;
   long long freq_nanosecs;
   sigset_t mask;
   struct sigaction sa;
};
timeSystemDef timeSystem;

// queues up automatic timer
// after timer has been turned on it will call TimerISR every 'cycleTime' milliseconds
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

// turns timer on
void TimerOn()
{
   timer_settime(timerid, 0, &timeSystem.its, NULL);
}

// timing interrupt handler
void TimerISR(int sig, siginfo_t *si, void *uc)
{
   if (TimerFlag) {
      printf("Timer ticked before task processing done.\n");
   }
   else {
      TimerFlag = 1;
   }
   return;
}
