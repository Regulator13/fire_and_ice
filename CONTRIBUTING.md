# Contributing

## Table of Contents
### [New to Github](#new-to-github)
### [Coding Standards](#coding-standards)
- [Resource Naming](#resource-naming)
- [Variable Naming](#variable-naming)
### [Style Guide](#style-guide)

## New to Github
1. To begin contributing, download the github desktop app [here](https://desktop.github.com/)
2. Clone the desired project: File>Clone Repositiory>Enter the URL of the repository page
3. Create a branch as your name
4. Hit publish branch
5. Hit open this repository in explorer in the middle of the app
6. Open the project in Gamemaker Studio 2
7. Make your edits and save the game
8. On the GitHub desktop app, commit the changes in the bottom left, adding a title and description of your changes
9. Click Fetch Origin at the top right
10. Go to GitHub online and create a pull request under the **Pull requests** tab.
11. Wait for your request to be reviewed

## Coding Standards
Fame Games' *Dust: Fire and Ice* project is coded using GameMaker Language or GML. Coding can be done in text format but syntax highlighting is featured on GameMaker Studio 2. When programming, it is important you follow these standards to increase readability and avoid errors.

### Resource Naming
The following prefixes should be used when creating any resource (e.g. spr_player or rm_main)

* Spites:    spr_
* Paths:     pth_
* Scripts:   scr_
* Objects:   obj_
* Parents:   par_
* Particles: prt_
* Rooms:     rm_

When reasonable, an object should share the same name as its sprite, using the `obj_` prefix instead of the `spr_` prefix. This will help coordinate what belongs with what.

### Variable Naming
There are many types of variables and seperating which type is which will _greatly_ increase readability. In general variable names should be short and concise. However, if a slightly longer name will increase readability, typing long variable names will not be the death of us. Follow these guidelines:

#### Local Variables
A local variable is a variable that is only used in the current event (create, step, etc.) and then discarded. These variables should follow the standards below but should also be preceded by `var` e.g. `var game_over`. Doing so discards the variable at the end of the event, increasing game speed.

#### Global Variables
Variables that need to be accessed outside the event or by another object can be named according to the standards below. To access another object's variable, simply use `obj_name.variable_name`. Use of the keyword `global` should be minimized.

#### Constants
Constants are definitions that do not change, ever. For example `pi` or `player_speed` (If the player always travels at the same speed). Think, "Am I ever going to change this variable? Ever?" If the answer is no, it's a constant. Constants are written in all caps, e.g. `PI` or `PLAYER_SPEED`.

#### 'Normal' Variables
The typical variable you define, such as `player_health` or `room_width` should be written in all lower case, with words seperated by underscores. Numeric suffixes can be added directly to the end such as `block3`. _Note:_ variable names can never start with number. Not `2_player` but `player2`.

#### Counters
Counters are variables that get incremented or decremented in a `for` or `while` loop. If the variable is being used specifically for counting in that loop, `i` `j` and `k` should be used. For example:
```
var i
var j
for i=0; i<10; i += 1{
  for j=0; j<10; j+= 1{
    //code
  }
}
```
Recall that for variables used only in one event, the `var` keyword should be used. This will always be the case with counters.

#### Instance Variables
Instances are occurences of objects. If you make a `obj_wall` and place 10 in a room you have placed 10 instances of that object. Each instance is assigned a unique id. Sometimes you will want to refer to a specific instance, such as the last wall placed. When doing so, you assign that instances id to a variable.

Instance variables should begin with a capital letter, e.g. `Last_wall` if you're referring to the instance of the last wall placed.

## Style Guide

