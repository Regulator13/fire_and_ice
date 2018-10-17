/// @description  draw client debug information
if (clientDebug) {
    // setup drawing
    draw_set_color(c_dkgray);
    draw_set_alpha(0.5);
    
    // set draw offset
    var drawOffset = 0;
    var yOffset = 20;
    var count = 9;
    
    // draw background
    draw_rectangle(0, 0, 500, count*yOffset+30+10, false);
    
    // setup drawing
    draw_set_halign(fa_left);
    draw_set_font(fnt_command);
    draw_set_color(c_red);
    
    // draw client informtion
    draw_text(10, 10, string_hash_to_newline("CLIENT DEBUG"));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Server Message Info:"));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Socket In: " + string(socketIn)));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Server IP: " + string(serverIP)));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Sequence In: " + string(sequenceIn)));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("msgID In: " + scr_msgIDtoString(msgIDin)));
    drawOffset++;// skip a space
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Client State Info:"));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Client Socket: " + string(client)));
    draw_text(10, 30+yOffset*drawOffset++, string_hash_to_newline("Network State: " + scr_networkStateToString(global.NetworkState)));
    
    // reset alpha
    draw_set_alpha(1);
    }

