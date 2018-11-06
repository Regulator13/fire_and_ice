/// @description Create life
//REMOVE? It doesn't seem this code is being used since no lives are being given
if (tScore >= lastLifeScore + global.score_life) {
    /*tLives += 1; //if a goal has already been set, add a life*/
    lastLifeScore += global.score_life; //set next score goal
}

