changecom(`#')
define(moore_Begin,
  `my $moore_Current_State;
   my $moore_Next_State; 
   my $moore_Initial_State; 
   no warnings "experimental::smartmatch"; '
) 


define(moore_TableBegin,
  `$moore_Initial_State = $1 ;
   $moore_Next_State = $1 ;
   my $task_ref = sub {  
      $moore_Current_State = $moore_Next_State;  '
)

define(moore_TableRow,
   `if ($moore_Current_State ~~ $1) {
       $2;
       $moore_Next_State = $3;           
       return;
    } '
)

define(moore_TableEnd,
   `};'
)

define(moore_Reset,
   `my $reset_ref = sub {
       $1;
       $moore_Next_State = $moore_Initial_State;           
       return; 
    }; '
)

define(moore_End,
   `sub get_task_ref {
       my $pkg = shift @_;

       return ($task_ref);
    } 
    sub get_reset_ref {
       my $pkg = shift @_;

       return ($reset_ref);
    }'
)
