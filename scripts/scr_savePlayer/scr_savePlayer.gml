/// @description scr_savePlayer()
/* 
* Description: save player
* Parameters:  none
* Returns:     void
*/

    //open file
    ini_open("player.ini");
    
    //save data
    section = "name";
    ini_section_delete(section);
    ini_write_string(section, "name", iServerName.text);
    
    //close file
    ini_close(); 
