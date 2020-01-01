area
	var
		music
	desc = "This is a place"
	music
	Entered(mob/m)

		if(!ismob(m))
			return
		m << desc //desc is built-in variable for description
		m << sound (music, 1, channel = 1, volume = 10)  //sound args: file, repeat (1 to repeat), wait (0 to interrupt the current song on channel, 1 to wait on queue), channel (0 any channel, 1-8 for specific channel (wavs only)), volume (1 to 100)


	land
		//music = 'Music/any_music.wav'
		desc = "Man... Today is too hot!"

	coast
		//music = 'Music/any_other_music.wav'
		desc = "The sand... the water..."

	ocean

	sea
		desc = "The breeze of the ocean..."