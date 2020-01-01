//================
//default mob
//================
mob
	step_size = 64
	icon='Icons/base_1_male.dmi'
	icon_state = "standing_1"
	Login()
		world << "[usr] has just logged in! Welcome!"
		//some code
		..()	//calls the built-in method.

	var
		animation_lock = 0

		states
			var
				isMoving = 0
				base_delay = 3
				move_delay = 3
				sit_delay = 3
				timer_change = 0

				//character states
				current_state = "standing_1"
				idle_state_1 = "standing_1"
				walking_state_1 = "walking_1"
				blinking_state_1 = "blinking_1"
				punching_state_1 = "punching_1"
				sitting_state_1 = "sitting_1"
				bumping_state_1 = "bumping_1"
		attributes
			var
				money = 0

				level = 1
				max_hp = 100
				hp = 100  //hp is the current hp, for short and readability, lets call it hp
				str = 1
				agi = 1
				cha = 1
				aura = 1

		hidden_attributes
			var
				cap = 10			//Maximum value of any attribute
				is_nen_active = 0	//Has the player acquired nen?
		move_points
			var
				punch_counter = 0
				punch_level = 1
		conditions
			var
				disabled = 0

		timers
			var
				punch_time = 0
				punch_delay = 10

//================
//General procs
//================
	proc
		Set_Current_HP()
			hp = max_hp

		Death_Check()
			if(hp <= 0)
				world << "[src] dies!"
				world << "[usr] killed [src]"
				del(src)
		Drop_Gold()
			var/obj/gold/g = new(src.loc)
			g.amount = rand(1,100)
			if (g.amount >= 30)
				g.icon_state = "medium_0"
			else
				g.icon_state = "small_0"
		Drop_Loot()
			//code to drop other items
			Drop_Gold()

		Change_State(state)
			if(state != current_state)
				timer_change = world.timeofday

				if (state == idle_state_1 || state == "")
					src.current_state = idle_state_1
					src.icon_state = idle_state_1
				else if (state == walking_state_1)
					src.current_state = walking_state_1
					src.icon_state = walking_state_1
				else if (state == blinking_state_1)
					src.current_state = blinking_state_1
					src.icon_state = blinking_state_1
				else if (state == sitting_state_1)
					src.current_state = sitting_state_1
					flick(src.current_state,src)
					src.icon_state = current_state
				else if (state == punching_state_1)
					src.current_state = punching_state_1
					flick(punching_state_1,src)


		State_Reseter()

		Move_Level_Handler(current_state)
			if(current_state == punching_state_1)
				punch_counter++
				if ((punch_counter == (200*punch_level)) && (punch_level < 3))
					punch_level++
					punch_counter = 0


//================
//overrode methods
//================
	Del()
		Drop_Loot()
		..()

	Move()
		..()





	verb

		Look()
			src << "You see..."
			for(var/atom/movable/o in oview())
				src << "[o].  [o.desc]"

		Check_My_Money()
			set name = "My Money"
			if (money != 0)
				usr << "You have [money] gold pieces!"
			else
				usr << "You have no gold pieces!"

		Whisper(msg as text)
			view(1) << "[src] whispers: \"[msg]\""

		Tell(mob/m in world, msg as text)
			src << "You tell [m], \"[msg]\""
			m << "[src] tells you, \"[msg]\""

		Sit()
			set category = "Moves"
			if(src.current_state == sitting_state_1)
				Change_State (idle_state_1)
				disabled = 0
			else if (src.current_state == idle_state_1)
				Change_State (sitting_state_1)
				disabled = 1

		Change_Name(name as text)
			src.name = name

		//Supported formats	include .dmi, .bmp, .png, .gif, .jpg, and .jpeg.

		Change_Icon(icon as icon)
			src.icon = icon

		Say(msg as text)
			view(src) << "[src] says: [msg]"
		Shout(msg as text)
			world << "[src]: [msg]"

		//================
		//Fighting Verbs
		//================

		Punch(mob/m as mob in get_step(src,dir)) //get_step gets the next location of the next step on that direction
			set category = "Combat"
			if(world.timeofday > punch_time)
				if (m.hp <= 0)
					usr << "You cannot punch a dead body. [m] is already dead"
				else
					usr << "You punched [m]"
					oview() << "[usr] punched [m]"
					Change_State(punching_state_1)
					var/i
					for (i = 0, i < punch_level, i++)
						var/dmg = rand(1,10) + src:str
						world << "[dmg] damage!" 			//maybe later place view instead of world
						m:hp -= dmg
					m.Death_Check()
					Move_Level_Handler(punching_state_1)
				punch_time = world.timeofday + (punch_delay - src.agi)
				Change_State(idle_state_1)

/*
		Attack(mob/m as mob in oview(1))

			if(m.hp <= 0)
				usr << "You cannot damage a dead body. [m] is already dead!"
			else
				usr << "You attacked [m]!"
				oview() << "[usr] attacked [m]!"
				var/dmg = rand(1,10)
				world << "[dmg] damage!" 			//maybe later place view instead of world
				m:hp -= dmg
				m.Death_Check()

*/