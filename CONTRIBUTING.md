# Contributing

## Table of Contents
__[New to Github](#new-to-github)__


__[Coding Standards](#coding-standards)__
- [Resource Naming](#resource-naming)
- [Variable Naming](#variable-naming)


__[Style Guide](#style-guide)__
- [Indentation](#indentation)
- [New Lines (Vertical Spacing)](#new-lines-vertical-spacing)
- [Spaces (Horizontal Spacing)](#spaces-horizontal-spacing)
- [Braces](#braces)
- [Parentheses](#parentheses)
- [Logical Operators](#logical-operators)
- [Some Other Notes](#some-other-notes)

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
Fame Games' *Dust: Fire and Ice* is coded using GameMaker Language or GML. Coding can be done in text format but syntax highlighting is featured on GameMaker Studio 2. When programming, it is important you follow these standards to increase readability and avoid errors.

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
A local variable is a variable that is only used in the current event (create, step, etc.) and then discarded. These variables should follow the standards below but should also be preceded by the `var` keyword, e.g. `var game_over`. This keyword discards the variable at the end of the event, increasing game speed.

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
The style guide is not standard, that is, it's not required, but following it will make your code easier to read, especially for reviewers. The guide may seem nitpicky but getting into the habit of good coding will make things easier for you and others.

### Indentation
Indentation is not required in GML but is highly recommended. Every level or loop of code that is nested should be indented one further than the level right above it. Here's an example:
```
switch (state){
  
  case 0:
    //Do first thing
  
  case 1:
    //Do second thing
}
```
Note how each block of nested code is indented one more level than the last. It's easy to see where all the cases are for the switch statement because they're all at the same indenation or column. 

### New Lines (Vertical Spacing)
Also note the usage of new lines in the above example, one after each block of code. In general, add a newline after each loop or statement that doesn't contain the "final level" of code or the code that actually does something, action code, if you will. There is a line after the `switch` statement because it contains a `case` statement. However, there is no line after the `case 0:` or `case 1:` because they contain the action code. However! There is a line between the `case` statements because they are not action code. Here's another example:
```
var i
for i=0; i<10; i++{
  //Do something each time
  
  if i<5{
    //Do something else when i<5
  }
}
```
The action code is directly under the `for` loop and `if` statement. The `if` statement is not, itself, action code though, so it has a line seperating it from the action code above it that is unrelated to it. Don't be stingy with space! Each statement deserves it's own line. Don't use `x = 1; y= 1;`, instead do:
```
x = 1
y = 1
```
There's endless amounts of space and since GML is not a whitespace language, it just ignores all the unnecessary lines anyway. It's just for readability!

### Spaces (Horizontal spacing)
Space can convey meaning and make what is happening in the code much clearer if we use it consistently. I'll try to list as many examples as I can to show you when a space is appropriate and when it is not.

| Situation | Needs spaces? | Example(s) |
| --------- | ------------- | ---------- |
| Variable Assignment | Yes | `speed = 5` |
| Operators | Yes | `speed += 5` `height * room_height` `speed < 5`|
| Parameter Assignment | No | `function(param=1)` |
| `for` loop assignments | No | `for i=10` etc. |
| `for` loop sections | Yes | `for i=10; i>0; i += 1` (After semicolons) |
| After commas | Yes | `fuction(param1, param2, param3)` |
| Around parentheses | No | `grid = (room_height / 64) * 5` |
| After statements, before braces | No | `if x == true{` |

### Braces
Include immediately after the statement, regardless of its size. End them on a different line, aligned with the beginning of the statement they refer to. GML does this automatically when you type a close brace. Essentially don't go against GML's flow.
```
if statement{
  
  if statement{
    Do stuff
  }
}
```
Don't add an extra line between braces, just keep the all on different lines.

### Parentheses
Use parentheses when necessary or improves readability, try not to overuse them GML follows order of operations so `2 + 2 * 2` = 6 not 8, no parentheses required.

In regard to control statements, they are not required! However, do use them if the statement is lengthy or has multiple conditions. Good:
```
if speed < 5{
  speed += 1
}
```
Also good:
```
if (speed < 5 and energy > 5){
  speed += 1
}
```
### Logical operators
Use the keywords `and`, `or`, and `not` as opposed to the symbols `&&`, `||`, and `!` to improve readability. Parentheses may be needed with these if you're applying them to multiple terms.
```
if (lives > 0 and health <= 0){
  //Restart
}
```
or
```
if not (speed == 5){
  speed = 5
}
```
Note: The parentheses are needed or the `not` will only negate the `speed` and not the comparison `speed == 5`. No parenthesis are needed for negating boolean values, e.g. `if not is_alive{` would work if `is_alive` is a boolean.

### Some other notes
- Use == as a comparison operator `if speed == 4`. GameMaker doesn't require this but do it anyway.
