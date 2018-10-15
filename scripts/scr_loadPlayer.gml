///scr_loadPlayer()
/* 
* Description:  Loads the controls
* Parameters:   none
* Returns:      void
*/

// open file
if (file_exists("player.ini")) {
    ini_open("player.ini");
    
    // load name
    var section = "name";
    iServerName.text = ini_read_string(section, "name", "Newbius");
    
    //close file
    ini_close();
    }
