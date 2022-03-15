// for storing details of a transformation for special cases
/datum/component/mob_transform
	var/mob/old_mob
	var/mob/new_mob
	var/transform_type
	var/delete_new_mob_on_death

/datum/component/mob_transform/death_revert/Initialize(new_type = null, turf/location = null, new_name = null as text, delete_on_death = FALSE)
	. = ..()
	old_mob = parent
	old_mob.change_mob_type(new_mob, new_type, location, new_name, FALSE)
	RegisterSignal(old_mob, COMSIG_MOB_DEATH, .proc/revert)
	delete_new_mob_on_death = delete_on_death

/datum/component/mob_transform/death_revert/proc/revert()
	if(new_mob.mind)
		new_mob.mind.transfer_to(old_mob)
	old_mob.forceMove(get_turf(new_mob))
	if(delete_new_mob_on_death)
		qdel(new_mob)
	qdel(src)