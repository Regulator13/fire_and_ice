/*scr_sequenceMoreRecent()
* returns most recent sequence account for sequence wrap around
* argument0 - s1, incoming sequence
* argument1 - s2, old sequence
* argument2 - max
*/
s1 = argument0;
s2 = argument1;
smax = argument2;
//start
    {
    return 
        ( s1 > s2 ) && 
        ( s1 - s2 <= smax/2 ) 
           ||
        ( s2 > s1 ) && 
        ( s2 - s1  > smax/2 );
    }
