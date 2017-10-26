/*************************************************************
* Filename:   lifoTable.c
* Author:     Daniel Guenther (565154853)
* Date:       2017-09-26
* Class:      CSCI 485
* Project:    lab03
* Purpose:    demonstration of an implementation of LIFO Tables in C
* Sources:     
*     -  
*************************************************************/

#include <stdio.h>
#include <stdlib.h>
// include our 'item' type
#include "item.h"
#include "lifo.h"

int main()
{
   item* myItem;
   if(!(myItem = malloc(sizeof(item)))){
      perror("error allocating\n");
      return 0;
   }
   myItem->num = 500;
   printf("my number is %d\n",myItem->num);
   return 0;
}

