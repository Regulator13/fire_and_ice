Changelog

Semantic Versioning 2.0.0   https://semver.org/

MM/DD/YY
vMajor.Minor.Patch
Major - Not backwards compatible, you can't run the current game on a previous version
Minor - Backwards compatible larger changes (Added)
Patch - Small changes and bug fixes (Updated)

**MOST RECENT VERSION HERE**
11/21/18
v2.16.0
- Added support gamepad input
- Added support for keypad input

11/21/18
v2.15.0
- Added universal back buttons
- Added universal state switch button
- Cleaned up menu initiation scripts
- Moved all state switches to scr_state_switch

11/20/18
v2.14.6
- Added game options menu
- Added animations button to game

11/20/18
v2.14.5
- Added a roof to all rooms
- Fixed a bug with climbing platforms

11/20/18
v2.14.4
- All children of par_blocks can be climbed
- Players can climb down all children of par_blocks and hang on the ledge

11/20/18
v2.14.3
- Blocks no longer explode in player's hands
- Fixed issue where platforms didn't change sprites properly with guns
- Patrols no longer get stuck
- Fixed a bug where water droplets could be pushed

11/20/18
v2.14.2
- Left_action replaces grab and ice
- Players can drag trampolines with left action
- Player's no longer fire when picking up items

11/20/18
v2.14.1
- Climbing no longer takes energy
- Explosions destroy energy spawns
- Sentries and recharge stations destroy if there is no block beneath them
- Expaneded grab radius
- Reduced hit box for fireballs and iceballs
- Guns spawn again

11/19/18
v2.14.0
- Character and item masses are all similar now
- Character mass no longer effects jump height
- Friction of all objects is now 2
- Players climb ledges they are next to
- Fixed a bug where crouching players couldn't climb ledges
- Fixed some spawning bugs
- Vertical platforms go up and down

11/17/18
v2.13.1
- Added obj_ball particles
- Changed mooch and explosion to particles

11/14/18
v2.13.0
- Improved platform and player interactions
- Platforms now move children of par_phsyics with them
- Platforms reverse at obstacles

11/14/18
v2.12.0
- Improved climbing
- Players can be hurt while inactive
- U cheat sets players to active

11/12/18
v2.11.1
- Added rain particles

11/9/18
v2.11.0
- Made sentries
- Stopped laser spawning

11/9/18
v2.10.0
- Added climbing picks
- 25% chance spawn on 2 platforms

11/9/18
v2.9.0
- Added hang-gliders
- 25% chance spawn on 2 platforms
- Fixed multiple climbing bugs
- Characters won't cling when flying in a jetpack

11/8/18
v2.8.1
- Fixed piranha and character animation
- Sticky blocks stick flush with walls
- Sticky blocks need to be half attached to a wall to stick
- You can only jump on ground now
- Score screen displays level and water rate
- Fixed irandom() mistake causing probabilities to be wrong
- Climbing is easier and smoother

11/7/18
v2.8.0
- Added par_item
- Added gun item

11/7/18
v2.7.5
- Fixed water droplet animation glitch
- fire/iceballs destroy after 6 seconds instead of 1

11/7/18
v2.7.4
- Added inching with down key
- Trampolines can be pushed

11/7/18
v2.7.3
- Finished formatting menu objects

11/6/18
v2.7.2
- Formatted menu objects

11/5/18
v2.7.1
- Formatted in-game objects and game control objects

11/5/18
v2.7.0
- Removed compatibility scripts

11/4/18
v2.6.1
- Fixed sinking into block bug when climbing
- *RELEASE v2.6.1*

11/3/18
2.6.0
- Changed double jump to single jump
- Added acceleration
- Added drag
- Block platforms spawn more frequently
- Trampolines give you an extra jump
- Reduced throw distances
- Added climbing
- Corpses can't be frozen when held

11/2/18
v2.5.1
- Updated water sprites
- Added drop animation
- Water spawners can be blown up

10/31/18
v2.5.0
- Added laser glitches
- Patrols attack less often

10/29/18
v2.4.2
- Reduced possible spawning area for platforms

10/29/18
v2.4.1
- Reduced friction on vertical platforms
- Lasers don't spawn on each other

10/29/18
v2.4.0
- Added moving platforms

10/28/18
v2.3.0
- Made different stats for different characters

10/26/18
v2.2.2
- Added mass to jumps

10/26/18
v2.2.1
- Changed water delay to never drop below 300
- Water speed increases more slowly after that
- fixed spawning for trampolines so they don't overlap

10/24/18
v2.2.0
- Added jetpack

10/23/18
v2.1.0
- Added trampolines

10/23/18
v2.0.6
- Fixed mouse throwing

10/23/18
v2.0.5
- Lasers don't spawn on the lower levels of the map

10/23/18
v2.0.4
- Blocks don't freeze in player's hands

10/23/18
v2.0.4
- Big blocks kill you if they fall on you

10/22/18
v2.0.3
- Water spawners can be frozen and unfrozen
- They only drop water droplets when frozen

10/21/18
v2.0.2
- Can be frozen into blocks
- Blocks are melted back into water
- Drops at a constant rate, following physics
- Deals 10 damage to player

10/21/18
v2.0.1
- Water spawners spawn on the 5 long L platform and 3 long platform

10/15/18
v2.0.0
 - Ported game to GameMaker Studio 2

5/1/18
V 1.04.4
 - Game no longer restarts when cannot connect
 - Added input message button
 - Client can dissconnect from not responding server
 - Added option to wait to drop player
 - Added name saving

V 1.04.3
 - Added client debug
 - individualized sequence out counting for each client

V 1.04.2
 - Fixed paths not saving, level was increasing by 30 due to check_win_buffer

4/30/18 4:30-7:00
V 1.04.1
 - Added tutorial
 - Fixed name display when server debug is on

4/30/18
V 1.03.2
 - Added exploding and freezing corpses
 - Added countdown particle
 - Block can now be frozen by holding ice

4/30/18 12:00-2:00
V1.03.1
 - Redid contols menu to edit any controller

4/29/18 11:00-1:00 3:00-6:00 9:30-11:30
V 1.03.0
 - Redid input conrols all based on global.controls
 - Local players now controlled by an input tracking object like network players
 - Any amount of input combinations possible, ability to use just keyboard, keyboard + mouse, and joystick

4/28/18
V 1.02.5
 - Updated controls menu

4/27/18
V1.02.4
 - Added back buttons
 - Added display of names in game

4/24/18 4/25/18 8:30-11:30 4/27
V 1.02.3
 - Redid msgId to use constants
 - Added support for setting names
4/25
 - Game data only set if client is already login, one server message to client per step
 - switched menu from string checking for states, to int checking, no more loops!
 - added support for individual client RTT checking
 - remove ack system for pinging
 - clients disconnect after 10 secounds of inactivity
4/27
 - selector draw on right side, when off screen
 - reorganized online menu

4/14/18 7:20 - 1:10 4/15/18 9:00 - 11:20 4/16/18 1:50-5:20
V 1.02.3
 - Added support for online path menu
 - Added support for online games
 - Switched online input to mouse
 - Added display for teams online
4/15
 - Added display for characters and basic objects
 - 30mins spent on using ds_list_find_index instead of ds_list_find_value for sending messages
4/16
 - Added support for drawing laser, water height
 - Added support for moving camera
 - Added support for score menu
 - Added mooching

3/24/18 2:00-4:30 8:50 - 10:50
V 1.02.2
 - Updated options menu
 - Added controls view menu
 - Added online menu and lobby

1/6/18 
V 1.02.1
 - Players can throw other players on team
 - Score no longer adds to team lives
 - Hearts add to team lives

12/29/17 - 6 hours
V 1.02.0
 - Added exploding blocks
 - Added teams
 - Added team scoring
 - Added HUD
 - Added Lives
 - Updated splash screen
 - Updated title and menu

12/29/17
V 1.01.1
 - Fixed scrolling
 - Start goes to next level

12/28/17
V 1.01.0
 - Added menu
 - Added paths

12/1/17 24:00-1:00
V 1.0.0
 - Start in fullscreen
 - Screen scrolls with players
 - Blocks do not generate on ground level
 - Sticky blocks stick to walls

 
