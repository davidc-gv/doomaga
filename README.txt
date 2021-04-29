David Conti

This project is, in essence, a galaga clone with doom assets. The basic idea is that you have waves
of enemies that get closer and closer each round. You have the ability to shoot with a double barrel
shotgun and destroy the enemies. If the enemies touch either the player, or the bottom bar, you take
damage.

I implemented many sprites and animations to make this look better. i also implemented music and 
different sounds for when enemies, and players, get hit or die. I also have background music from
the original game. The enemies have walking animations and get larger as they get further down the 
screen. The Enemies also have an explosion animation if they die.

Controls for the game:
  Keyboard/Mouse: 
    Fire: Left Click/Space Bar
    Move Left: Left Arrow Key
    Move Right: Right Arrow Key
    Restart Game: Esc Key
    
   Controller:
    Fire: Right trigger
    Move Left: Move Left Stick Left
    Move Right: Move Left Stick Right
    Restart Game: Start Button

At the bottom of the screen is a status bar which tells you health, current wave, and a image of the
player that shows their status. These are all updated based on their respective values in the main scene.

Demonstrating code is difficult with godot as much is done with godot itself. Godot uses "scenes"
to help separate code. The "gameplay" scene is the main function essentially. It will load in other
scenes as needed. Such as the "Doomguy" scene or the "Imp" scene or the "StatusBar" scene.

Each of the scenes has their own .gd file. These are godots script files where the actual code is. This is
where all of my code resides and is commented so that you understand generally what is going on. Godot is
written in a language very similar to python, but is not exactly the same. Documentation for proper ways to
do things are difficult to come by.

The .tscn files are the scene file and are the initial value of the scene. This is not manually coded by me and 
is automatically generated.

If you wish to view this more directly, you can install godot online at https://godotengine.org/download/windows

From there simply download all of the files on this github, open godot after installing, and open this project. 
After opening you can see how each scene is initialized by clicking:
Scene -> Open Scene
Then select the .tscn file you wish to view.

Godot, at least what I used for this project, uses OpenGL ES 2 which allows the project to be exported in WebGL
2 in HTML5. This is how I exported this project to my google site.
