///scr_saveControls()
/* 
* Description:  Saves the controls
* Parameters:   none
* Returns:      void
*/

    // open file
    ini_open("controls.ini");
    
    // save keys
    var section = "controls";
    ini_section_delete(section);
    
    // write new keys
    var count = 0;
    var inputs = array_height_2d(global.controls);
    ini_write_real(section, "height", inputs);
    for (i = 0; i < inputs; i++) {
        var amount = array_length_2d(global.controls, i);
        ini_write_real(section, "length" + string(i), amount);
        for (j = 0; j < amount; j++) {
            ini_write_real(section, count++, global.controls[i, j]);
            }
        }
    
    //close file
    ini_close(); 
