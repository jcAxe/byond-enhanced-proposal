//================
//default object
//================
obj
	icon='Icons/stubs.dmi'
	icon_state = "obj_1"
	step_size = 64

	verb
		get()										//obj/gold/verb/get()
			set src in oview(1)   						//src must be close
			usr << "You pick up [src]"
			Move(usr)	 							//Move the item to user's contents
			//del(src)

		drop()
			usr << "You just dropped [src]"
			Move(usr.loc)



//================
//specific objects
//================
	gold
		name = "Gold"
		icon = 'Icons/Items/gold.dmi'
		icon_state = "coin_0"
		var
			amount


		//overrides the previous get()
		get()										//obj/gold/verb/get()
			set src in view(1)   						//src must be close
			usr/player.money += amount 	 					//add to usr money
			usr << "You pick up [amount] gold"
			del(src)


	wearable
		var
			equipped = 0
		verb
			Wear()
				if(equipped == 0)
					equipped = 1
			Unwear()
				if(equipped == 1)
					equipped = 0
		boxing_gloves
			name = "Boxing Gloves"
			icon = 'Icons/Items/Wearable/boxing_gloves.dmi'
			icon_state = "dropped_0"
