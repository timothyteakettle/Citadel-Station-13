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
	return ..()

/obj/item/greatsword/afterattack(atom/target, mob/user)
	do_cleave_effect(user)
	return ..()

// stolen from the shield bashing effect
/obj/item/greatsword/proc/do_cleave_effect(mob/living/user)
	var/dir = last_direction
	var/px = 0
	var/py = 0
	switch(dir)
		if(NORTH)
			py = 12
		if(SOUTH)
			py = -12
		if(EAST)
			px = 12
		if(WEST)
			px = -12
	var/obj/effect/temp_visual/dir_setting/cleave/effect = new(user.loc, dir)
	effect.pixel_x = user.pixel_x - 32		//96x96 effect, -32.
	effect.pixel_y = user.pixel_y - 32
	user.visible_message("<span class='warning'>[user] cleaves forwards with [src]!</span>")
	animate(user, pixel_x = px, pixel_y = py, time = 3, easing = SINE_EASING | EASE_OUT, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)
	animate(user, pixel_x = -px, pixel_y = -py, time = 3, flags = ANIMATION_RELATIVE)
	animate(effect, alpha = 0, pixel_x = px * 1.5, pixel_y = py * 1.5, time = 3, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)

/obj/effect/temp_visual/dir_setting/cleave
	icon = 'icons/effects/96x96_attack_sweep.dmi'
	icon_state = "cleave"
	duration = 3

/obj/item/greatsword/debug
	name = "steel greatsword"
	desc = "This is far too big to be called a sword."
	force = 40
	wound_bonus = 20
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "greatsword"
	inhand_icon_state = "greatsword"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
