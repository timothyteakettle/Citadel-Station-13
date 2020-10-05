/datum/element/dusts_on_leaving_area
	element_flags = ELEMENT_DETACH | ELEMENT_BESPOKE
	id_arg_index = 2
	var/list/area_types = list()
	var/permanent

/datum/element/dusts_on_leaving_area/Attach(datum/target,types,is_permanent)
	. = ..()
	var/datum/mind/attached_mind = target
	if(!attached_mind)
		return ELEMENT_INCOMPATIBLE
	area_types = types
	permanent = is_permanent
	if(is_permanent)
		RegisterSignal(target, COMSIG_MIND_TRANSFER,.proc/update_character)
	if(attached_mind.current)
		RegisterSignal(attached_mind.current, COMSIG_ENTER_AREA,.proc/check_dust)

/datum/element/dusts_on_leaving_area/Detach(datum/mind/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MIND_TRANSFER)

/datum/element/dusts_on_leaving_area/proc/update_character(datum/source, mob/new_character, mob/old_character)
	Detach(source)
	var/area/new_area = get_area(get_turf(new_character))
	if(new_character.mind && new_area.type in area_types && permanent)
		Attach(new_character.mind)
	else
		qdel(src)
	if(old_character)
		UnregisterSignal(old_character, COMSIG_ENTER_AREA)

/datum/element/dusts_on_leaving_area/proc/check_dust(datum/source, area/A)
	var/mob/M = source
	if(istype(M) && !(A.type in area_types))
		M.dust(force = TRUE)
