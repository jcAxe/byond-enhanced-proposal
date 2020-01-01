First of all, I must thank Invy and LucasZoé for all the help in this.


###Introduction

In this topic, I will propose a Style Guide for Byond Code. It is largely inspired by the Python Enhanced Proposal 8 (PEP8), so I suggest calling it Byond Enhanced Proposal 1.

This standard does not intend to propose new algorithms. It focuses on the code organization itself, defining a pattern in order to make the programming easier for sharing and learning in the community for both new and experienced programmers.

I wrote this in a way to be used as reference, and not as a story book. Enjoy!

  
  

### Directory organization

In this proposed directory management for the projects, we suggest the use of one root folder for each kind of file. My base project root directory has 1 file and 6 folders as defined below:

•/ (The project's root)

•/project.dme

•/Code/ (.dm files)

•/Icons/ (.dmi files)

•/Interface/ (.dmf files)

•/Maps/ (.dmm files)

•/Music/

•/Docs/

  

Inside each of these folders, you can organize the files in the way you feel more comfortable. Although we surely will suggest a way we think is helpful.
  
#### DME file

This file organizes how your project environment is organized. Since this file won't be grouped by other dme files, it makes sense to no place it inside any folder in the project.* The project.dme file dictates the project environment organization and execution order. Since there is just a single file with this extension, it is placed in the root directory.
 

By default, the Dream Maker sorts the code files execution order alphabetically. It is in this file that you can change such order. I have seen coders creating files named: "zzCode.dm" in order to guarantee that this file would execute last.

  #### DM files

Dream maker help us to organize our code using Objects.

We suggest that, whenever an Object becomes too big or dense, you should create a separate file for it.

Example scenario: As for me, I create a new file only when a direct Children from the Base Object becomes monstrous.

So, I have files for players and enemies (mobs). There are many objects inside the enemies.dm file, such as "animals" and "monsters". However, even though there are big Objects inside the enemies.dm file, in a small project, it is good to keep them as children of "enemy" instead of creating a new mob object file.

  

#### DMI files

 Folders and directory management: The names and concepts are detached from the Code Standards.

Icons that the user can interact directly are categorized as Object Icons (Gold, Gloves and Wearables).

Icons that are for environment that usually cannot be interacted directly (cannot apply actions) are categorized as Turf Icons (Grass, Rocks, Walls).

Effects Icons are in its own folder (FX).

Group up everything that makes sense in its own folder.

It is not required to group up files if it does not make sense. Example: "stubs.dmi", "test.dmi".

/Icons/Objects/
/Icons/Turfs/
/Icons/FX/
/Icons/Hair/
/Icon/Enemies/
/Icon/base.dmi
/Icon/test.dmi

  

#### DMM and DMF

So far nothing will be suggested for such files.

  
  
  

### Name of icon states

 The file name should be a short summary of what the icon means.

  

Now, we will propose a way to differentiate the states inside the file in two conventions:

  

•style_number_action (or style_number_state)

•action_number



#### Style:

Style can contain more than one name referring to the state on the icon state text name, such as: (on_grass) or (lane_top).

#### Number:

The number is the index of its iconstate inside the icon file.

#### Action/State

Actions can also contain more than one name, because they can indicate directions, such as: "cracking_right" => action_direction.


The divisor between style and action/state will always be the number of that icon state.

Example: I created an icon file of "Concrete floors" in different locations, for example: Concrete near sand; or Concrete near grass.

Picture I have 2 icon states for each of these cases:
  

**File: concrete_floor.dmi**

**icon state: on_grass_0_static**
**icon state: on_sand_0_breeze_right**

  

In this example, I have a "(Static) concrete floor (on grass)". Being this one the first icon of this type in this file, the number (0) is placed in the name of the file.

* **Note 0: We are using indexation on zero**

* **Note 1: We also suggest omitting the "static" action on unanimated states. Example: on_grass_0**

  
  
  

Example scenario: Picture you having a file called sand_floor.dmi. You want to draw a sand floor on the grass. It is a static state. What will be the name for the first icon state in this file?

  

**File: sand_floor.dmi**

**icon state: on_grass_0_static (or on_grass_0)**

Here is where we get organized. This icon has the same icon state name as the concrete example above. The same icon state can be used for both icons.

This will help the coders to locate themselves through the many projects and icons they encounter throughout their lives. It will also help them on reusing code in many situations.
  

Example scenario: Imagine having 1 base icon for the player character. Now imagine you having 5 states for this player (standing, walking, attacking, dead, and running). Additionally, there are 10 clothes available for such character. For each piece of clothing, it is necessary to represent the 5 states.

So, for only 10 clothes, you have 50 different icon states. Using this pattern to name your files and states will help you reduce a lot of effort to think of the name, remember these names through the files, and reuse the names throughout the code. Having many icons registered with the same state names, you can also reuse the states on enemies, monsters and so on.

  

#### Naming Turfs
With turfs, we suggest using the: style_number_state



Here is an example of 3 different kinds of floor and the way they are placed in my turf.dm file.
Remember that we suggested omitting the state if the icon state is static.
```
White_Tiles
	icon='Icons/Turfs/white_tiles.dmi'
	icon_state = "central_0"
	opacity = 0
	White_Tiles_Central_0
		icon_state = "central_0"
		White_Tiles_Left_0
			icon_state = "left_0"
		White_Tiles_Right_0
			icon_state = "right_0"
		White_Tiles_Top_0
			icon_state = "top_0"
		White_Tiles_Bottom_0
			icon_state = "bottom_0"
 

Concrete_Floor
	icon='Icons/Turfs/concrete_floor.dmi'
	icon_state = "concrete_block_1_static"
	opacity = 0
	Concrete_Floor_0
		icon_state = "basic_0"
	Concrete_Floor_1
		icon_state = "on_sand_0"
	Concrete_Floor_2
		icon_state = "on_sand_1"
	Concrete_Left_Lane_0
		icon_state = "lane_left_0"
	Concrete_Right_Lane_0
		icon_state = "lane_right_0"
	Concrete_Center_Lane_0
		icon_state = "lane_central_0"
	
Sand
	icon='Icons/Turfs/sand_floor.dmi'
	icon_state = "sand_block_0_static"
	Sand_Floor_0
		icon_state = "basic_0_static"
		opacity = 0
	Sand_Floor_1
		icon_state = "on_concrete_0"
		opacity = 0
	Sand_Left_Lane_0
		icon_state = "lane_left_0"
		opacity = 0
	Sand_Right_Lane_0
		icon_state = "lane_right_0"
		opacity = 0
	Sand_Center_Lane_0
		icon_state = "lane_central_0"
		opacity = 0
```  

#### Naming Mobs

With mobs, we suggest using the: action_number

ex: attack_1

  

Contrasting with turfs, which styles usually vary much more between each other, mobs have their state changes usually through actions.

For instance, if you have many ways for throwing a punch, by simplicity, you may just differentiate them by the number.


### Code

  
#### Variables

In order to follow the "snake_case" pattern as close as possible, we want to keep the underscores between different words. just_like_this.


#### Procs and Verbs

For naming Procs and Verbs, I suggest a mix between "PascalCase" and "snake_case". Just_Like_This().

  

For 2 reasons:

1- Whenever the coder needs to create a function that conflicts with a built-in function, which may be lowercased, it is suggested by the Dream Maker documentation to create an UpperCase function with the same name. To standardize the user-created functions, all functions should start with a capitalized letter.

2- How Verbs are displayed in the command tab is directly affected by how they are defined. Underscore characters are ommited. So, "Go_Up" will be displayed as "Go Up". Also, the increased contrast in the characters height may increase the readability.

Reference: https://uxmovement.com/content/all-caps-hard-for-users-to-read/

But only verbs can possibly be seen by users as actions.

Dispite that, in order to standardize the code, I suggest we use all customized methods (verbs and procs) Like_This().

 So far, those are the standards that we seem that can be most helpful. This is intended to be a collaborative document. A repository applying all standards defined here will be publicly available.

  

I hope this helps people to improve their efficiency on their projects by simply organizing thoughts and code.

This is a v0 for this proposal. There are many aspects of BYOND that won't be covered by this text and I hope we could improve it together.

A small project is available for colaboration in this repository:
