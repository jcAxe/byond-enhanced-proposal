mob
	player
		Stat()
			usr.State_Reseter()		//this should be on world startup
			statpanel("Status")
			statpanel("Status", "Health:", "[usr.hp]/[usr.max_hp]")
			statpanel("Status", "Money:", usr.money)
			statpanel("Status", "Strength:", usr.str)
			statpanel("Status", "Agility:", usr.agi)
			statpanel("Status", "Charism:", usr.cha)
			statpanel("Inventory", usr.contents)
			if(is_nen_active)
				statpanel("Status", "Aura:", usr.aura)
				statpanel("Nen")



		icon='Icons/base_1_male.dmi'
		icon_state = "standing_1"

		Set_Current_HP()

		//bump is called when the src cannot transpose a barrier (atom with density = 1)
		//Important(kinda): Bump only is completely called (flick) when you release the key
		Bump(atom/obstacle)
			if(istype(obstacle,/mob/monster))
				usr << "An enemy!"
			else if ((istype(obstacle, /area/)) || (istype(obstacle,/turf/)))
				usr << "Cannot go that way like this"
			else
				usr << "You just collided with a [obstacle]"

			flick("bump_1", src)

			obstacle.Bumped(src)


		//Actually this is a basic code for AI
		//This code makes the monsters move towards the player

		Move()
			for(var/mob/monster/target in view(loc))
				walk_to(target, loc, 1, 5)

			if(disabled)
				return

			if (src.current_state == walking_state_1)
				return
			else
				src.Change_State(walking_state_1)
				..()
				sleep(src.move_delay)
				src.Change_State(idle_state_1)


		Change_State(state)
			..()


		//Helps to reset states when it does not depends on a button click
		State_Reseter()
			if(timer_change != 0)
				if (((world.timeofday - timer_change) > 50) && (current_state == idle_state_1))
					Change_State(blinking_state_1)

				if((move_delay < base_delay) && (current_state == idle_state_1)) //resets the running speed
					move_delay = base_delay

		verb

			// Configuration.
			//These will be admin commands


			Increase_Agility(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:agi+= points
				else
					src << "You should type how much points do you want to increase on this attribute."
				Attribute_Corrector(m)

			Decrease_Agility(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:agi-= points
				else
					src << "You should type how much points do you want to increase on this attribute."
				Attribute_Corrector(m)

			Increase_Strength(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:str+= points
				else
					src << "You should type how much points do you want to increase on this attribute."
				Attribute_Corrector(m)

			Decrease_Strenght(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:str-= points
				else
					src << "You should type how much points do you want to increase on this attribute."
				Attribute_Corrector(m)

			Increase_Charism(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:cha+= points
				else
					src << "You should type how much points do you want to increase on this attribute."
				Attribute_Corrector(m)

			Decrease_Charism(mob/m in world, num as text)
				var/points = text2num(num)
				if(isnum(points))
					m:cha-= points
				else
					src << "You should type how much points do you want to increase on this attribute."

				Attribute_Corrector(m)

			Attribute_Corrector(mob/m in world)
				if(m:str < 1)
					m:str = 1
					src << "Strenght was corrected"
				else if (m:str > m:cap)
					m:str = m:cap
					src << "Strenght was corrected"
				if(m:agi < 1)
					m:agi = 1
					src << "Agility was corrected"
				else if (m:agi > m:cap)
					m:agi = m:cap
					src << "Agility was corrected"
				if(m:cha < 1)
					m:cha = 1
					src << "Dexterity was corrected"
				else if (m:cha > m:cap)
					m:cha = m:cap
					src << "Dexterity was corrected"

			Toggle_Nen_Activation(mob/m in world)
				m:is_nen_active = !m:is_nen_active

			//must be improved
			Announce(msg as text)
				world << "[usr] <FONT SIZE=+3>[msg]</FONT>"

			//checkers
			Check_Timer()
				usr << world.timeofday


