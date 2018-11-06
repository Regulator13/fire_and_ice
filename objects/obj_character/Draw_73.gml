/// @description Draw healthbar and energy bar
if (view_current == 0) if !(global.online) {
    draw_healthbar(x,y-4,x+17,y-8,hp,c_white,c_red,c_green,0,false,true);
    draw_healthbar(x,y,x+17,y-4,energy,c_white,c_white,c_teal,0,false,true);
}



