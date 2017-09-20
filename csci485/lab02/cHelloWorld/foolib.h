/*============================================-=
 File "foolib.h"
 Behaviour:
      C interface to Buffalo Monotor assembly I/O routines
 Assumptions:
      No registers are modified on return (except for
      return parameters)
 Board:
      CME11-E9-EVBU
 Author:
      
============================================-= */

/* write a EOT terminated character string to stdout */
void  wstr(char *);

/* write CR LF to stdout */
void  wcrlf(void);

