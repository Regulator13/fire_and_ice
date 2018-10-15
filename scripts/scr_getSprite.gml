//takes character name, returns sprite
switch(argument0) {
    case "grinch":
        return spr_grinch;
    case "santa":
        return spr_santa;
    case "yeti":
        return spr_yeti;
    case "nutcracker":
        return spr_nutcracker;
    case "reindeer":
        return spr_reindeer;
    default:
        return spr_yeti;
    }
