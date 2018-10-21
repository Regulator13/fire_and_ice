# Contributing

## Table of Contents
__[New to Github](#new-to-github)__

__[GMS Setup](#gms-setup)__

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
- [Commenting](#commenting)
- [Some Other Notes](#some-other-notes)

__[Issues](#issues)__
- [Submitting an Issue for Review](#submitting-an-issue-for-review)

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

## GMS Setup
To increase productivity, all functions (scripts) will be equipped with [JS DOC](https://docs2.yoyogames.com/source/_build/1_overview/3_additional_information/jsdoc.html) comments. In order to get full usage of them you have to check the _display argument types_ and _display argument descriptions_ in Preferences, and hit __apply__ as shown below.

![Preferences](https://github.com/famegames/fire-and-ice/blob/master/tutorial_images/Display_arguments.PNG "File>Preferences>Language>GML>Check all boxes")

This will show parameter descriptions but note that you can also hit `F1` once you've typed a function name to take you directly to the script that has that function.

## Coding Standards
Fame Games' *Dust: Fire and Ice* is coded using GameMaker Language or GML. Coding can be done in text format but syntax highlighting is featured on GameMaker Studio 2. When programming, it is important you follow these standards to increase readability and avoid errors.

### Resource Naming
The following prefixes should be used when creating any resource (e.g. spr_player or rm_main)

* Spites:    spr_
* Paths:     pth_
* Scripts:   scr_
* Rooms:     rm_

The following are all object types
* Objects:   obj_
* Parents:   par_
* Particles: prt_

When reasonable, an object should share the same name as its sprite, using the `obj_` prefix instead of the `spr_` prefix. This will help coordinate what belongs with what.

### Variable Naming
There are many types of variables and seperating which type is which will _greatly_ increase readability. In general variable names should be short and concise. However, if a slightly longer name will increase readability, typing long variable names will not be the death of us. Follow these guidelines:

#### Local Variables
A local variable is a variable that is only used in the current event (create, step, etc.) and then discarded. These variables should follow the standards below but should also be preceded by the `var` keyword, e.g. `var game_over`. This keyword discards the variable at the end of the event, increasing game speed.

#### 'Normal' Variables
The typical variable you define, such as `player_health` or `room_width` should be written in all lower case, with words seperated by underscores. Numeric suffixes can be added directly to the end such as `block3`. _Note:_ variable names can never start with number. Not `2_player` but `player2`.

#### Global Variables
Variables that need to be accessed outside the event or by another object can be named according to the standards below. To access another object's variable, simply use `obj_name.variable_name`. Use of the keyword `global` should be minimized.

#### Constants
Constants are definitions that do not change, ever. For example `pi` or `player_speed` (If the player always travels at the same speed). Think, "Am I ever going to change this variable? Ever?" If the answer is no, it's a constant. Constants are written in all caps, e.g. `PI` or `PLAYER_SPEED`.

#### Counters
Counters are variables that get incremented or decremented in a `for` or `while` loop. If the variable is being used specifically for counting in that loop, `i` `j` and `k` should be used. For example:
```
var i
var j
for (i=0; i<10; i+=1){
  for (j=0; j<10; j+=1){
    //Code
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
Also note the usage of new lines in the above example, one after each block of code. In general, add a newline after each loop or statement that doesn't contain the "final level" of code or the code that actually does something: action code, if you will. The exception is that there is no new line needed when the next line is indented further than the previous line. That is, a new line of code should not be both indented _and_ have a blank line. There is no line after the `switch` statement because the `case` statement is already indented. There is no line after the `case 0:` or `case 1:` because they contain the action code. However! There is a line between the `case` statements because they are not action code. Here's another example:
```
//Other code, unrelated to the for loop

var i
for (i=0; i<10; i+=1){
  //Do something each time
  
  if i < 5{
    //Do something else when i<5
  }
}
```
Basically code is broken into blocks by newlines. The declartion `var i` is related to `for` loop so there is no blank line after it. The "Other code" however is unrelated and therefore there is a blank space after it. The action code is directly under the `for` loop and `if` statement. The `if` statement is not, itself, action code though, so it has a line seperating it from the action code above it since it is on the same indentation as it. Don't be stingy with space! Each statement deserves it's own line. Don't use `x = 1; y= 1;`, instead do:
```
x = 1
y = 1
```
GameMaker also allows for control statements to all be on one line if there is only one line of code to execute. For readability, it is preferred this is avoided unless a long list of control statements all execute one line of code each.
```
//Bad
if lives <  destroy_instance
```
```
//Good
if lives < 1{
  destroy_instance()
}
```
```
//Also good
if condition_1 action_1
if condition_2 action_2
if condition_3 action_3
if condition_4 action_4
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
| `for` loop sections | Yes | `for (i=10; i>0; i += 1)` (After semicolons) |
| After commas | Yes | `fuction(param1, param2, param3)` |
| Around parentheses | No | `grid = (room_height / 64) * 5` |
| After statements, before braces | No | `if x == true{` |

### Braces
Include immediately after the statement, regardless of its size. End them on a different line, aligned with the beginning of the statement they refer to. GML does this automatically when you type a close brace. Essentially don't go against GML's flow.
```
if statement{
  if statement{
    //Do stuff
  }
}
```
Don't add an extra line between braces, just keep the all on different lines.

### Parentheses
Use parentheses when necessary or when they improve readability, try not to overuse them. GML follows order of operations so `2 + 2 * 2` = 6 not 8, no parentheses required.

In regard to control statements, they are not required! However, do use them if the statement is lengthy or has multiple conditions. 

Good:
```
if speed < 5{
  speed += 1
}
```
Also good:
```
if (speed < 5 and energy > 5) or health < 10{
  speed += 1
}
```
### Logical operators
Use the keywords `and`, `or`, and `not` as opposed to the symbols `&&`, `||`, and `!` to improve readability. Parentheses may be needed with these if you're applying them to multiple terms.
```
if lives > 0 and health <= 0{
  //Restart
}
```
No parenthesis needed

or:
```
if not (speed == 5){
  speed = 5
}
```
Note: The parentheses here are needed or the `not` will only negate the `speed` and not the comparison `speed == 5`. No parenthesis are needed for negating boolean values, e.g. `if not is_alive{` would work if `is_alive` is a boolean (`true` or `false`).

### Commenting
Comments are critical for code that will be reviewed, shared, and edited. As is our quest in coding, knowing when and how much to comment will improve readability and manageability. There are a few different types of comments.

#### Function Documentation
These comments take place at the beginning of a function or script in GML's case. The Documentation should include the function's purpose, paramaters, and what it returns. For documentation the `///` is used. A scripts documentation of Docstring might look like this:
```
/// @function  convert_string_to_decimal(str_num)
/// @description  Convert a string to a decimal
/// @param str_num str | A string containing a decimal number
// Returns a decimal number

//Actual Code
```
The `@function`, `@description`, and `@param` are special documentation keywords that allow the user see information about the function while coding. For example, the `@function` keyword will autocomplete the function and show the parameter `(str_num)` when someone tries to use it. The `@param` line is set up as follows `/// @param ARGUMENT_NAME ARGUMENT_TYPE | ARGUMENT_DESCRIPTION; ARGUMENT_RANGE(if applicable)`. 2 spaces should be used after these keywords for better readability.

#### Event Documentation

Events also have descriptions at the top which is shown on the left side where the events for an object are listed. This is automatically added to each event and looks like `/// @description  Type description here`. __A brief summary of the actions completed in the event should be included here.__ This will allow programmers to find what is happening in extremely length events (such as step events) without scrolling through the whole thing. For example, if there is 100 lines of checks and then at the end of the step in 3 lines the object checks to see if the player has died, that might be tough to find. However, with a description at the top of the event like `/// @description  check this, check that, check another thing, check if the player has died` then a programmer can do less searching when that snippet of code needs to be found two months later.

#### In-line comments

Finally in-line comments can help supplement code. In general, if the style guide and standards are followed, code should be fairly readable on its own. However, if further explanation is needed besided what is obvious, in-line comments are required.

In-line comments use the `//` at the beginning of the line and should always take place before the code they are referring to on a seperate line, (except in the case of a long list in which each line needs a comment, then they can go on the same line).
```
//Comment about code
//Code itself
```
In-line comments should say _why_ a certain thing is being done instead of simply restating what is happening in the code. For example:
```
//Check to see if the speed is less than 5, then set it to 5
if speed < 5{
  speed = 5
}
```
This is bad. The comment states the obvious. So what do you comment here? Nothing. Comments are for explaining the ambiguous, if they don't make something clear that wasn't clear before they shouldn't be included. Here's a good comment to reduce ambiguity:
```
//If the player is below the kill line, kill him
if obj_player.y < ((room_height / 64) + 8) * level{
  instance_destroy(obj_player)
}
```
The random coordinates may not be obvious to someone looking at this code for the first time. The comment explains _why_ the coordinate is used. Of course, even better might be to use a variable: `kill_line = (room_height / 64 + 8) * level` since the line `if obj_player.y < kill_line` would be self explanatory. Anyway, use in-line comments sparingly, always asking yourself if you could still explain this code in a month, or year. If not, add a comment.

### Some other notes
- Use `==` as a comparison operator `if speed == 4`. GameMaker doesn't require this but do it anyway.

## Issues

### Submitting an Issue for Review
Once you have completed an issue:
1. Commit the changes to a branch named after you (if you don't have one go to `Branch>New Branch` on the GitHub Desktop)
2. Submit a pull request on the [pull request tab](https://github.com/famegames/fire-and-ice/pulls)
3. Type in relevant information including issue number into the prompt
4. Go to your issue and label it with the green `pull request submitted` label so others know you have completed that issue and are just waiting on a review
5. Don't close the issue. The reviewer will close it when he/she has ensured your code can be safely added to the `master` branch. In the meantime others will want to know that your code has not yet been added
