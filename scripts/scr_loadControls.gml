///scr_loadControls()
/* 
* Description:  Loads the controls
* Parameters:   none
* Returns:      void
*/

    // open file
    ini_open("controls.ini");
    
    // load inputs
    var section = "controls";
    var count = 0;
    var inputs = ini_read_real(section, "height", 0);
    for (i = 0; i < inputs; i++) {
        var amount = ini_read_real(section, "length" + string(i), 0);
        for (j = 0; j < amount; j++) {
            global.controls[i, j] = ini_read_real(section, count++, 0);
            }
        }
    
    //close file
    ini_close(); 
