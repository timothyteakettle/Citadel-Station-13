// file for the greatsword
// a slow cleaving weapon that has a large click delay and movement debuff on the user
// it requires being wielded with both hands
// high damage, armour penetration, and can hit adjacent targets to where you swing
// extremely high stamina usage to swing

/obj/item/greatsword
	name = "default greatsword"
	desc = "default description"
	w_class = WEIGHT_CLASS_BULKY // it was too big to be called a sword
	sharpness = SHARP_EDGED

	var/datum/component/two_handed/wielded_component
	var/wielded_required = TRUE // if it requires to be wielded with both hands to be used
	var/wielded_force // damage when wielding with both hands
	var/unwielded_force = 0 // damage when wielding with one hand
	var/slowdown_wielded = 2 // keep this at 0 for no slowdown, it needs to be positive to slowdown
	var/last_direction // the last direction the sword was swung in

/obj/item/greatsword/Initialize()
	wielded_component = AddComponent(/datum/component/two_handed, force_unwielded=unwielded_force, force_wielded=wielded_force, icon_wielded="")
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
	. = ..()

/obj/item/greatsword/proc/on_wield()
	START_PROCESSING(SSobj, src)
	slowdown += slowdown_wielded

/obj/item/greatsword/proc/on_unwield()
	slowdown -= slowdown_wielded
	STOP_PROCESSING(SSobj, src)

/obj/item/greatsword/pre_attack(atom/target, mob/user)
	if(wielded_required && !wielded_component.wielded)
		to_chat(user, "[src] is far too heavy to swing with just one hand.")
		return TRUE
	// calculate direction from you to the target
	last_direction = get_dir(user, target)
	. = ..()
	if(!.) // it returns false if the attack can go ahead
		do_cleave_effect(user)

// took the icon from the rp server
/obj/effect/temp_visual/cleave_attack
	name = "cleaving attack"
	desc = "Something swinging really wide."
	icon = 'icons/effects/96x96.dmi'
	icon_state = "cleave"
	layer = ABOVE_MOB_LAYER
	duration = 6

	mouse_opacity = 0
	pixel_x = -32
	pixel_y = -32

/obj/item/greatsword/proc/do_cleave_effect(mob/living/user)
	var/px = 0
	var/py = 0
	switch(last_direction)
		if(NORTH)
			py = 32
		if(SOUTH)
			py = -32
		if(EAST)
			px = 32
		if(WEST)
			px = -12
		if(NORTHEAST)
			py = 32
			px = 32
		if(NORTHWEST)
			py = 32
			px = -32
		if(SOUTHEAST)
			py = -32
			px = 32
		if(SOUTHWEST)
			py = -32
			px = -32
	px = px - 32
	py = py - 32
	var/obj/effect/temp_visual/cleave_attack/effect = new(get_turf(user))
	effect.dir = last_direction
	animate(effect, alpha = 0.25, pixel_x = px, pixel_y = py, time = 6)

/obj/item/greatsword/debug
	name = "steel greatsword"
	desc = "This is far too big to be called a sword."
	force = 40
	wound_bonus = 20
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "greatsword"
	item_state = "greatsword"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
