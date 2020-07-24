/datum/antagonist/food_worker
	name = "Fast Food Ship Worker"
	job_rank = ROLE_TRAITOR
	roundend_category = "Fast Food ship worker"
	antagpanel_category = "Fast Food Ship Worker"
	threat = 0
	show_to_ghosts = TRUE

/datum/antagonist/pirate/greet()
	to_chat(owner, "<span class='boldannounce'>You work on a fast food ship!</span>")
	to_chat(owner, "<B>Make as much money as you can by cooking and giving food to the station!</B>")
