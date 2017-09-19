// just a test of the time.h library
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <time.h>

#define CLOCKID CLOCK_REALTIME
#define SIG SIGUSR1
timer_t timerid;

static void handler(int sig, siginfo_t *si, void *uc)
{
   if(si->si_value.sival_ptr != &timerid){
      printf("Stray signal\n");
   } else {
      printf("Caught signal %d from timer\n", sig);
   }
}

int main(int argc, char *argv[])
{
   struct sigevent sev;
   struct itimerspec its;
   long long freq_nanosecs;
   sigset_t mask;
   struct sigaction sa;

   printf("Establishing handler for signal %d\n", SIG);
   sa.sa_flags = SA_SIGINFO;
   sa.sa_sigaction = handler;
   sigemptyset(&sa.sa_mask);
   sigaction(SIG, &sa, NULL);

   sev.sigev_notify = SIGEV_SIGNAL;
   sev.sigev_signo = SIG;
   sev.sigev_value.sival_ptr = &timerid;
   timer_create(CLOCKID, &sev, &timerid);
   /* Start the timer */

   its.it_value.tv_sec = 1;
   its.it_value.tv_nsec = 0;
   its.it_interval.tv_sec = its.it_value.tv_sec;
   its.it_interval.tv_nsec = its.it_value.tv_nsec;

   timer_settime(timerid, 0, &its, NULL);
   while(1){

   }
}
