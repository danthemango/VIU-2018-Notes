// Set.h
// copied verbatim from https://www.cs.rit.edu/~ats/books/ooc.pdf

#ifndef SET_H
#define SET_H
extern const void * Set;
void * add (void * set, const void * element);
void * find (const void * set, const void * element);
void * drop (void * set, const void * element);
int contains (const void * set, const void * element);
#endif
