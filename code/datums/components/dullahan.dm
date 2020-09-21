//Dullahan Component (because why the hell was it a species?)
//turns the user into a dullahan by popping their head off and applying a bunch of snowflakey code to keep their sprite accessories and stuff
#define DULLAHAN_MASK_INDEX 1
#define DULLAHAN_HEAD_INDEX 2
#define DULLAHAN_EARS_INDEX 3
#define DULLAHAN_EYES_INDEX 4

/datum/component/dullahan
	//who is the person who is going to lose their head
	var/mob/living/carbon/human/owner
	//do we need to change what their head looks like
	var/custom_head_icon
	var/custom_head_icon_state
	//keep track of your relay
	var/obj/item/dullahan_relay/relay

/datum/component/dullahan/Initialize()
	if(ishuman(parent))
		owner = parent
		if(owner.health > 0)
			DISABLE_BITFIELD(owner.flags_1, HEAR_1)
			var/obj/item/bodypart/head/head = owner.get_bodypart(BODY_ZONE_HEAD)
			if(head)
				//give the new organs
				var/obj/item/organ/brain/brain = owner.getorganslot(ORGAN_SLOT_BRAIN)
				if(brain)
					brain.Remove(TRUE,TRUE)
					QDEL_NULL(brain)
					var/obj/item/organ/brain/new_brain = new /obj/item/organ/brain/dullahan
					new_brain.Insert(owner, TRUE, TRUE)
				var/obj/item/organ/tongue/tongue = owner.getorganslot(ORGAN_SLOT_TONGUE)
				var/list/accents
				if(tongue)
					accents = tongue.accents
					tongue.Remove(TRUE,TRUE)
					QDEL_NULL(tongue)
					var/obj/item/organ/tongue/new_tongue = new /obj/item/organ/tongue/dullahan
					if(accents)
						new_tongue.accents = accents + new_tongue.accents //dullahan accent needs to be last applied
					new_tongue.Insert(owner, TRUE, TRUE)
				var/obj/item/organ/ears/ears = owner.getorganslot(ORGAN_SLOT_EARS)
				if(ears)
					ears.Remove(TRUE,TRUE)
					QDEL_NULL(ears)
					var/obj/item/organ/ears/new_ears = new /obj/item/organ/ears/dullahan
					new_ears.Insert(owner, TRUE, TRUE)
				var/obj/item/organ/eyes/eyes = owner.getorganslot(ORGAN_SLOT_EYES)
				if(eyes)
					eyes.Remove(TRUE,TRUE)
					QDEL_NULL(eyes)
					var/obj/item/organ/eyes/new_eyes = new /obj/item/organ/eyes/dullahan
					new_eyes.Insert(owner, TRUE, TRUE)

				var/obj/item/bodypart/head/dullahan/dullahan_head = new
				//handle the head
				dullahan_head.name = owner.name
				dullahan_head.dullahan_body = owner
				if(has_custom_head())
					dullahan_head.icon = custom_head_icon
					dullahan_head.icon_state = custom_head_icon_state
					dullahan_head.custom_head = TRUE
				else
					dullahan_head.custom_head = head.custom_head
					var/head_icon = head.get_limb_icon()
					if(head_icon)
						dullahan_head.add_overlay(head_icon)
						dullahan_head.icon = null
						dullahan_head.icon_state = null
					else
						dullahan_head.icon = head.icon //one or the other, both causes two heads to appear sometimes, which is not wanted
						dullahan_head.icon_state = head.icon_state
				//now add eyes, horns, hair, and then a bunch of other snowflakey bits - consider making this not copypasta
				var/overlays_to_add = list()
				//first find the eyes overlay
				if(islist(owner.overlays_standing[BODY_LAYER]))
					for(var/mutable_appearance/some_overlay in owner.overlays_standing[BODY_LAYER])
						if(some_overlay.icon == 'icons/mob/human_face.dmi')
							overlays_to_add += some_overlay
				else
					var/mutable_appearance/some_overlay = owner.overlays_standing[BODY_LAYER]
					if(some_overlay.icon == 'icons/mob/human_face.dmi')
						overlays_to_add += some_overlay
				//next, add any horns
				if(islist(owner.overlays_standing[HORNS_LAYER]))
					for(var/mutable_appearance/some_overlay in owner.overlays_standing[HORNS_LAYER])
						overlays_to_add += some_overlay
				else
					overlays_to_add += owner.overlays[HORNS_LAYER]
				//next, add any hair
				if(islist(owner.overlays_standing[HAIR_LAYER]))
					for(var/mutable_appearance/some_overlay in owner.overlays_standing[HAIR_LAYER])
						overlays_to_add += some_overlay
				else
					overlays_to_add += owner.overlays_standing[HAIR_LAYER]
				//and now add any extra snowflakey bits that go on the head (this is shitcode and also the best way to do it due to species shitcode)
				var/icons_to_accept = list('modular_citadel/icons/mob/ipc_screens.dmi', 'modular_citadel/icons/mob/ipc_antennas.dmi', 'modular_citadel/icons/mob/mam_ears.dmi', 'modular_citadel/icons/mob/mam_snouts.dmi', 'modular_citadel/icons/mob/mam_snouts.dmi')
				var/things_to_not_accept = list("wing","frill","tail","spine","markings") //any states with these in? don't accept 100% they do NOT go on heads
				var/list/overlays_to_view
				if(!islist(owner.overlays_standing[BODY_ADJ_LAYER]))
					overlays_to_view = list(owner.overlays_standing[BODY_ADJ_LAYER])
				else
					overlays_to_view = owner.overlays_standing[BODY_ADJ_LAYER]
				for(var/mutable_appearance/some_overlay in overlays_to_view)
					message_admins("we have [some_overlay] and are going to look at [some_overlay.icon]")
					if(some_overlay.icon in icons_to_accept)
						message_admins("we might accept this!")
						var/accepted = TRUE
						for(var/thing_to_not_accept in things_to_not_accept)
							if(findtext(some_overlay.icon_state, thing_to_not_accept))
								message_admins("it violated the law!")
								accepted = FALSE
						if(accepted)
							overlays_to_add += some_overlay
				dullahan_head.add_overlay(overlays_to_add)
				dullahan_head.stored_items[DULLAHAN_EYES_INDEX] = owner.glasses
				dullahan_head.stored_items[DULLAHAN_EARS_INDEX] = owner.ears
				dullahan_head.stored_items[DULLAHAN_MASK_INDEX] = owner.wear_mask
				dullahan_head.stored_items[DULLAHAN_HEAD_INDEX] = owner.head
				qdel(head)
				for(var/X in dullahan_head.stored_items)
					var/obj/item/I = X
					if(I)
						I.forceMove(dullahan_head)
				dullahan_head.update_dismembered_accessory_overlays(owner, list(SLOT_HEAD, SLOT_WEAR_MASK, SLOT_GLASSES, SLOT_EARS))
				relay = new /obj/item/dullahan_relay (dullahan_head, owner)
				owner.put_in_hands(dullahan_head)
				var/obj/item/organ/eyes/E = owner.getorganslot(ORGAN_SLOT_EYES)
				for(var/datum/action/item_action/organ_action/OA in E.actions)
					OA.Trigger()
				owner.regenerate_icons()
		else
			RemoveComponent()
	else
		//they shouldn't have this component!
		RemoveComponent()

/datum/component/dullahan/RemoveComponent()
	//delete their organs and regenerate them to their species specific ones, remove accent from tongue, place head on body
	..()

/datum/component/dullahan/proc/has_custom_head()
	return (custom_head_icon && custom_head_icon_state)

//dullahan vision
/datum/component/dullahan/proc/update_vision_perspective(mob/living/carbon/human/H)
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		H.update_tint()
		if(eyes.tint)
			H.reset_perspective(H)
		else
			H.reset_perspective(relay)

//dullahan organs
/obj/item/organ/brain/dullahan
	decoy_override = TRUE
	organ_flags = ORGAN_NO_SPOIL//Do not decay

/obj/item/organ/tongue/dullahan
	zone = "abstract"
	initial_accents = list(/datum/accent/dullahan)

/obj/item/organ/ears/dullahan
	zone = "abstract"

/obj/item/organ/eyes/dullahan
	name = "head vision"
	desc = "An abstraction."
	actions_types = list(/datum/action/item_action/organ_action/dullahan)
	zone = "abstract"
	tint = INFINITY // used to switch the vision perspective to the head.

/datum/action/item_action/organ_action/dullahan
	name = "Toggle Perspective"
	desc = "Switch between seeing normally from your head, or blindly from your body."

/datum/action/item_action/organ_action/dullahan/Trigger()
	. = ..()
	var/obj/item/organ/eyes/dullahan/DE = target
	if(DE.tint)
		DE.tint = 0
	else
		DE.tint = INFINITY

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(isdullahan(H))
			var/datum/component/dullahan/D = H.GetComponent(/datum/component/dullahan)
			D.update_vision_perspective(H)

//dullahan relays
/obj/item/dullahan_relay
	name = "dullahan relay"
	var/mob/living/owner
	flags_1 = HEAR_1

/obj/item/dullahan_relay/Initialize(mapload, mob/living/carbon/human/new_owner)
	. = ..()
	if(!new_owner)
		return INITIALIZE_HINT_QDEL
	owner = new_owner
	START_PROCESSING(SSobj, src)
	RegisterSignal(owner, COMSIG_MOB_CLICKED_SHIFT_ON, .proc/examinate_check)
	RegisterSignal(src, COMSIG_ATOM_HEARER_IN_VIEW, .proc/include_owner)
	RegisterSignal(owner, COMSIG_LIVING_REGENERATE_LIMBS, .proc/unlist_head)
	RegisterSignal(owner, COMSIG_LIVING_REVIVE, .proc/retrieve_head)

/obj/item/dullahan_relay/proc/examinate_check(mob/source, atom/target)
	if(source.client.eye == src)
		return COMPONENT_ALLOW_EXAMINATE

/obj/item/dullahan_relay/proc/include_owner(datum/source, list/processing_list, list/hearers)
	if(!QDELETED(owner))
		hearers += owner

/obj/item/dullahan_relay/proc/unlist_head(datum/source, noheal = FALSE, list/excluded_limbs)
	excluded_limbs |= BODY_ZONE_HEAD // So we don't gib when regenerating limbs.

//Retrieving the owner's head for better ahealing.
/obj/item/dullahan_relay/proc/retrieve_head(datum/source, full_heal, admin_revive)
	if(admin_revive)
		var/obj/item/bodypart/head/H = loc
		var/turf/T = get_turf(owner)
		if(H && istype(H) && T && !(H in owner.GetAllContents()))
			H.forceMove(T)

/obj/item/dullahan_relay/process()
	if(!istype(loc, /obj/item/bodypart/head) || QDELETED(owner))
		. = PROCESS_KILL
		qdel(src)

/obj/item/dullahan_relay/Destroy()
	if(!QDELETED(owner))
		var/mob/living/carbon/human/H = owner
		if(isdullahan(H))
			var/datum/component/dullahan/D = H.GetComponent(/datum/component/dullahan)
			D.relay = null
			owner.gib()
	owner = null
	..()

//custom dullahan head that makes this shitcode easier to do
/obj/item/bodypart/head/dullahan
	var/mob/living/carbon/human/dullahan_body
	//accessories the head can wear
	var/list/stored_items = list(null, null, null, null) //mask/head/ears/eyes indexed with 1-4
	//the appearances that are used as overlays for the head (so we can easily fetch them and cut them)
	var/list/stored_appearances = list(null, null, null, null) //we index them with 1-4 so they need items in to initially index them, same order as stored_items

	slot_flags = ITEM_SLOT_HEAD

/obj/item/bodypart/head/dullahan/MouseDrop(atom/thing)
	if(iscarbon(thing) && Adjacent(thing))
		show_inv(thing)

/obj/item/bodypart/head/dullahan/proc/show_inv(mob/living/carbon/user)
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	var/dat = "<div align='center'><b>Inventory of [name]</b></div><p>"
	dat += "<br><B>Head:</B> <A href='?src=[REF(src)];[stored_items[DULLAHAN_HEAD_INDEX] ? "remove_inv=[SLOT_HEAD]'>[stored_items[DULLAHAN_HEAD_INDEX]]" : "add_inv=[SLOT_HEAD]'>Nothing"]</A>"
	dat += "<br><B>Mask:</B> <A href='?src=[REF(src)];[stored_items[DULLAHAN_MASK_INDEX] ? "remove_inv=[SLOT_WEAR_MASK]'>[stored_items[DULLAHAN_MASK_INDEX]]" : "add_inv=[SLOT_WEAR_MASK]'>Nothing"]</A>"
	dat += "<br><B>Ears:</B> <A href='?src=[REF(src)];[stored_items[DULLAHAN_EARS_INDEX] ? "remove_inv=[SLOT_EARS]'>[stored_items[DULLAHAN_EARS_INDEX]]" : "add_inv=[SLOT_EARS]'>Nothing"]</A>"
	dat += "<br><B>Glasses:</B> <A href='?src=[REF(src)];[stored_items[DULLAHAN_EYES_INDEX] ? "remove_inv=[SLOT_GLASSES]'>[stored_items[DULLAHAN_EYES_INDEX]]" : "add_inv=[SLOT_GLASSES]'>Nothing"]</A>"
	user.set_machine(src)
	user << browse(dat, "window=mob[REF(src)];size=325x500")
	onclose(user, "mob[REF(src)]")

/obj/item/bodypart/head/dullahan/Topic(href, href_list) //taken from corgi inventory, edited to be cleaner
	if(!(iscarbon(usr) || iscyborg(usr)) || !usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		usr << browse(null, "window=mob[REF(src)]")
		usr.unset_machine()
		return

	//Removing from inventory
	if(href_list["remove_inv"])
		var/remove_from = text2num(href_list["remove_inv"])
		var/item_index
		switch(remove_from)
			if(SLOT_HEAD)
				item_index = DULLAHAN_HEAD_INDEX
			if(SLOT_WEAR_MASK)
				item_index = DULLAHAN_MASK_INDEX
			if(SLOT_EARS)
				item_index = DULLAHAN_EARS_INDEX
			if(SLOT_GLASSES)
				item_index = DULLAHAN_EYES_INDEX
		var/item_to_remove = stored_items[item_index]
		if(item_to_remove)
			usr.put_in_hands(item_to_remove)
			stored_items[item_index] = null
			update_dismembered_accessory_overlays(dullahan_body, list(remove_from))
		else
			to_chat(usr, "<span class='danger'>There is nothing to remove from that area!.</span>")
			return
		show_inv(usr)

	//Adding things to inventory
	else if(href_list["add_inv"])
		var/add_to = text2num(href_list["add_inv"])
		message_admins("[add_to]")
		var/item_index
		switch(add_to)
			if(SLOT_HEAD)
				item_index = DULLAHAN_HEAD_INDEX
			if(SLOT_WEAR_MASK)
				item_index = DULLAHAN_MASK_INDEX
			if(SLOT_EARS)
				item_index = DULLAHAN_EARS_INDEX
			if(SLOT_GLASSES)
				item_index = DULLAHAN_EYES_INDEX
		if(stored_items[item_index])
			to_chat(usr, "<span class='warning'>It's already wearing something!</span>")
			return
		if(!item_index)
			to_chat(usr, "<span class='warning'>That's not a valid option!</span>")
			return
		var/obj/item/item_to_add = usr.get_active_held_item()
		if(!item_to_add)
			usr.visible_message("There's nothing in your hand to place on it!")
			return
		if(!(item_to_add.slot_flags & add_to))
			usr.visible_message("This doesn't go here!")
			return
		if(!usr.temporarilyRemoveItemFromInventory(item_to_add))
			to_chat(usr, "<span class='warning'>\The [item_to_add] is stuck to your hand, you cannot put it on [src]'s back!</span>")
			return
		stored_items[item_index] = item_to_add
		item_to_add.forceMove(src)
		update_dismembered_accessory_overlays(dullahan_body, list(add_to))
		show_inv(usr)
	else
		return ..()

//proc that grabs clothing items inside a head and renders them on the head
/obj/item/bodypart/head/dullahan/proc/update_dismembered_accessory_overlays(mob/living/carbon/human/the_dullahan, list/slots_to_render)
	if(!owner) //why are you doing this if it's not dismembered
		for(var/item_type in slots_to_render)
			var/obj/item/head_accessory
			var/accessory_layer
			var/accessory_offset
			var/accessory_icon_file
			var/appearance_storage_index
			switch(item_type) //these go off the worn item slot number
				if(SLOT_WEAR_MASK) //mask
					head_accessory = stored_items[DULLAHAN_MASK_INDEX]
					accessory_layer = FACEMASK_LAYER
					accessory_offset = OFFSET_FACEMASK
					accessory_icon_file = 'icons/mob/clothing/mask.dmi'
					appearance_storage_index = DULLAHAN_MASK_INDEX
				if(SLOT_HEAD) //head
					head_accessory = stored_items[DULLAHAN_HEAD_INDEX]
					accessory_layer = HEAD_LAYER
					accessory_offset = OFFSET_HEAD
					accessory_icon_file = 'icons/mob/clothing/head.dmi'
					appearance_storage_index = DULLAHAN_HEAD_INDEX
				if(SLOT_EARS) //ears
					head_accessory = stored_items[DULLAHAN_EARS_INDEX]
					accessory_layer = EARS_LAYER
					accessory_offset = OFFSET_EARS
					accessory_icon_file = 'icons/mob/ears.dmi'
					appearance_storage_index = DULLAHAN_EARS_INDEX
				if(SLOT_GLASSES) //eyes
					head_accessory = stored_items[DULLAHAN_EYES_INDEX]
					accessory_layer = GLASSES_LAYER
					accessory_offset = OFFSET_GLASSES
					accessory_icon_file = 'icons/mob/clothing/eyes.dmi'
					appearance_storage_index = DULLAHAN_EYES_INDEX
			if(head_accessory)
				var/mutable_appearance/accessory_overlay = head_accessory.build_worn_icon(default_layer = accessory_layer, default_icon_file = accessory_icon_file, override_state = head_accessory.icon_state)
				if(accessory_overlay)
					//cut the old overlay, if any
					if(stored_appearances[appearance_storage_index])
						cut_overlay(list(stored_appearances[appearance_storage_index]))
					if(accessory_offset in the_dullahan.dna.species.offset_features)
						accessory_overlay.pixel_x += the_dullahan.dna.species.offset_features[accessory_offset][1]
						accessory_overlay.pixel_y += the_dullahan.dna.species.offset_features[accessory_offset][2]
					add_overlay(list(accessory_overlay))
					//and now assign it to the right part of the storage list
					stored_appearances[appearance_storage_index] = accessory_overlay
			else
				if(list(stored_appearances[appearance_storage_index]))
					cut_overlay(list(stored_appearances[appearance_storage_index]))
				stored_appearances[appearance_storage_index] = null

//make sure the head can be equipped
/obj/item/bodypart/head/dullahan/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	if(dullahan_body == equipper)
		return !dullahan_body.head //only yes if there's nothing in the way (although this should never be the case)
	else
		return ..()

#undef DULLAHAN_MASK_INDEX
#undef DULLAHAN_HEAD_INDEX
#undef DULLAHAN_EARS_INDEX
#undef DULLAHAN_EYES_INDEX
