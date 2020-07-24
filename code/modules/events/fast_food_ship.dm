/datum/round_event_control/ship_event/fast_food
	name = "Fast Food Ship"
	typepath = /datum/round_event/ship_event/fast_food
	weight = 4 //there's a lot of places to stop off at in the galaxy, y'know
	earliest_start = 30 MINUTES

/datum/round_event/ship_event/fast_food
	ship_name = "Taco Tuesday Extravaganza" //it should be overwritten but just-in-case
	//ship_names_file = FOOD_SHIP_NAMES_FILE
	crew_name = "food delivery ship crew"

/datum/round_event/ship_event/fast_food/announce()
	priority_announce("A fast food ship has been seen to be travelling in your station's direction.", "Fast Food Ship")

/obj/machinery/computer/shuttle/pirate/fast_food
	name = "fast food ship console"
	shuttleId = "fastfoodship"
	possible_destinations = "fastfoodship_away;fastfoodship_home;fastfoodship_custom"
