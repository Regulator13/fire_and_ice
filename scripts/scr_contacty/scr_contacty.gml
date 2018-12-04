//  Usage:
//      x+=contact_x(hspeed);
//
//  Arguments:
//      horizontal amount to check   -real
//
//  Returns:
//      the maximum horizontal amount the current 
//      instance can move before hitting a solid.

while(!place_free(x, y + argument0))
{
    argument0=max(abs(argument0)-1,0)*sign(argument0); 
    if argument0=0 break;
}

return argument0;

