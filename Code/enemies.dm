mob
	monster

		icon = 'Icons/stubs.dmi'
		icon_state = "mob_1"
		max_hp = 30

		Bumped(atom/movable/bumper)
			..()
			bumper << "[src] is really angry!!"
			dir = get_dir(src, bumper)

			flick("bumped_1", src)
		//	icon_state="bumped_1"

		evil_ball
			name = "Evil Ball"
			Set_Current_HP()
			icon ='Icons/evil_ball.dmi'
			icon_state = "standing_1"
			Drop_Loot()
				var/obj/wearable/boxing_gloves/dropped = new(src.loc)
				usr << "You dropped [dropped]"

				..()
