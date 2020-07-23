/datum/round_event_control/ship_event
	name = "Ship Event"
	typepath = /datum/round_event/ship_event
	weight = 0
	max_occurrences = 1
	min_players = 10

/datum/round_event_control/ship_event/preRunEvent()
	if (!SSmapping.empty_space)
		return EVENT_CANT_RUN

	return ..()

/datum/round_event/ship_event
	var/datum/comm_message/sent_message
	var/ship_name = "Ship"
	var/shuttle_spawned = FALSE
	var/crew_name
	var/datum/map_template/shuttle/ship_event_ship
	var/obj/effect/mob_spawnspawner_type
	var/ship_names_file

/datum/round_event/ship_event/setup()
	ship_name = pick(strings(ship_names_file, "ship_names"))

/datum/round_event/ship_event/announce(fake)
	priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", "commandreport") // CITADEL EDIT metabreak
	if(fake)
		return FALSE
	return TRUE

/datum/round_event/ship_event/proc/can_spawn()
	return TRUE

/datum/round_event/ship_event/start()
	if(can_spawn())
		spawn_shuttle()

/datum/round_event/ship_event/proc/spawn_shuttle()
	shuttle_spawned = TRUE

	var/list/candidates = pollGhostCandidates("Do you wish to be considered for [crew_name]?", ROLE_TRAITOR)
	shuffle_inplace(candidates)

	if(!SSmapping.empty_space)
		SSmapping.empty_space = SSmapping.add_new_zlevel("Empty Area For [crew_name]", list(ZTRAIT_LINKAGE = SELFLOOPING))

	var/datum/map_template/shuttle/new_shuttle = new ship_event_ship
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - new_shuttle.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - new_shuttle.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/T = locate(x,y,z)
	if(!T)
		CRASH("Ship event found no turf to load in. Reference ship [new_shuttle]")

	if(!new_shuttle.load(T))
		CRASH("Loading [new_shuttle] failed!")
	for(var/turf/A in new_shuttle.get_affected_turfs(T))
		for(var/obj/effect/mob_spawn/spawner in A)
			if(candidates.len > 0)
				var/mob/M = candidates[1]
				spawner.create(M.ckey)
				candidates -= M
				announce_to_ghosts(M)
			else
				announce_to_ghosts(spawner)

	priority_announce("A report has been downloaded and printed out at all communications consoles.", "Incoming Classified Message", "commandreport") //CITADEL EDIT also metabreak here too
