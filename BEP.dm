/*
	These are simple defaults for your project.
 */

world
	name = "Some good manners"
	fps = 60		// 60 frames per second

	icon_size = 64	// 64x64 icon size by default
	view = 6		// show up to 6 tiles outward from center (13x13 view)
	mob = /mob/player



//================
//default atom
//================
atom
	proc
		// By default, this procedure does nothing.
		Bumped(atom/movable/bumper)