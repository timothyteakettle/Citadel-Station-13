/obj/item/gun/energy/laser
	name = "laser gun"
	desc = "A basic energy-based laser gun that fires concentrated beams of light which pass through glass and thin metal."
	icon_state = "laser"
	item_state = "laser"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = 1

/obj/item/gun/energy/laser/practice
	name = "practice laser gun"
	icon_state = "laser-p"
	desc = "A modified version of the basic laser gun, this one fires less concentrated energy bolts designed for target practice."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	clumsy_check = 0
	item_flags = NONE

/obj/item/gun/energy/laser/practice/hyperburst
	name = "toy hyper-burst launcher"
	desc = "A toy laser with a unique beam shaping lens that projects harmless bolts capable of going through objects. Compatible with existing laser tag systems."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/magtag)
	icon_state = "toyburst"
	obj_flags = NONE
	fire_delay = 40
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	selfcharge = EGUN_SELFCHARGE
	charge_delay = 2
	recoil = 2
	cell_type = /obj/item/stock_parts/cell/toymagburst

/obj/item/gun/energy/laser/retro
	name ="retro laser gun"
	icon_state = "retro"
	desc = "An older model of the basic lasergun, no longer used by Nanotrasen's private security or military forces. Nevertheless, it is still quite deadly and easy to maintain, making it a favorite amongst pirates and other outlaws."
	ammo_x_offset = 3

/obj/item/gun/energy/laser/retro/old
	name ="laser gun"
	icon_state = "retro"
	desc = "First generation lasergun, developed by Nanotrasen. Suffers from ammo issues but its unique ability to recharge its ammo without the need of a magazine helps compensate. You really hope someone has developed a better lasergun while you were in cryo."
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/old)
	ammo_x_offset = 3

/obj/item/gun/energy/laser/hellgun
	name ="hellfire laser gun"
	desc = "A relic of a weapon, built before NT began installing regulators on its laser weaponry. This pattern of laser gun became infamous for the gruesome burn wounds it caused, and was quietly discontinued once it began to affect NT's reputation."
	icon_state = "hellgun"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hellfire)

/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. It is decorated with assistant leather and chrome. The object menaces with spikes of energy. On the item is an image of Space Station 13. The station is exploding."
	force = 10
	ammo_x_offset = 3
	selfcharge = EGUN_SELFCHARGE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/laser/carbine
	name = "laser carbine"
	desc = "A ruggedized laser carbine featuring much higher capacity and improved handling when compared to a normal laser gun."
	icon_state = "lasernew"
	item_state = "lasernew"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	inaccuracy_modifier = 0.7
	force = 10
	throwforce = 10
	cell_type = /obj/item/stock_parts/cell/lascarbine
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/laser/carbine/nopin
	pin = null

/obj/item/gun/energy/laser/captain/scattershot
	name = "scatter shot laser rifle"
	icon_state = "lasercannon"
	item_state = "laser"
	desc = "An industrial-grade heavy-duty laser rifle with a modified laser lens to scatter its shot into multiple smaller lasers. The inner-core can self-charge for theoretically infinite use."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/laser/cyborg
	can_charge = FALSE
	desc = "An energy-based laser gun that draws power from the cyborg's internal energy cell directly. So this is what freedom looks like?"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "laser_cyborg"
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 3

/obj/item/gun/energy/laser/cyborg/emp_act()
	return

/obj/item/gun/energy/laser/cyborg/mean
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE

/obj/item/gun/energy/laser/scatter
	name = "scatter laser gun"
	desc = "A laser gun equipped with a refraction kit that spreads bolts."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/laser/scatter/shotty
	name = "energy shotgun"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "cshotgun"
	item_state = "shotgun"
	desc = "A combat shotgun gutted and refitted with an internal laser system. Can switch between taser and scattered disabler shots."
	shaded_charge = 0
	pin = /obj/item/firing_pin/implant/mindshield
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/electrode)

///Laser Cannon

/obj/item/gun/energy/lasercannon
	name = "accelerator laser cannon"
	desc = "An advanced laser cannon that does more damage the farther away the target is."
	icon_state = "lasercannon"
	item_state = "laser"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	pin = null
	ammo_x_offset = 3

/obj/item/ammo_casing/energy/laser/accelerator
	projectile_type = /obj/item/projectile/beam/laser/accelerator
	select_name = "accelerator"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/projectile/beam/laser/accelerator
	name = "accelerator laser"
	icon_state = "scatterlaser"
	range = 255
	damage = 6

/obj/item/projectile/beam/laser/accelerator/Range()
	..()
	damage += 7
	transform *= 1 + ((damage/7) * 0.2)//20% larger per tile

/obj/item/gun/energy/xray
	name = "\improper X-ray laser gun"
	desc = "A high-power laser gun capable of expelling concentrated X-ray blasts that pass through multiple soft targets and heavier materials."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	pin = null
	ammo_x_offset = 3

////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "laser tag gun"
	icon_state = "bluetag"
	desc = "A retro laser gun modified to fire harmless blue beams of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/blue
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/redtag
	name = "laser tag gun"
	icon_state = "redtag"
	desc = "A retro laser gun modified to fire harmless beams red of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/red
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)

/obj/item/gun/energy/laser/redtag/hitscan/chaplain
	name = "\improper holy lasrifle"
	desc = "A lasrifle from the old Imperium. This one seems to be blessed by techpriests."
	icon_state = "LaserAK"
	item_state = null
	force = 14
	pin = /obj/item/firing_pin/holy
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	ammo_x_offset = 4
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan/holy)
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	var/chaplain_spawnable = TRUE
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	obj_flags = UNIQUE_RENAME

/obj/item/gun/energy/laser/redtag/hitscan/chaplain/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

/obj/item/gun/energy/laser/redtag/hitscan/chaplain/handle_suicide(mob/living/carbon/human/user, mob/living/carbon/human/target, params, bypass_timer)
	if(!ishuman(user) || !ishuman(target))
		return

	if(on_cooldown())
		return

	if(user == target)
		target.visible_message("<span class='warning'>[user] sticks [src] in [user.p_their()] mouth, ready to pull the trigger...</span>", \
			"<span class='userdanger'>You stick [src] in your mouth, ready to pull the trigger...</span>")
	else
		target.visible_message("<span class='warning'>[user] points [src] at [target]'s head, ready to pull the trigger...</span>", \
			"<span class='userdanger'>[user] points [src] at your head, ready to pull the trigger...</span>")

	busy_action = TRUE

	if(!bypass_timer && (!do_mob(user, target, 120) || user.zone_selected != BODY_ZONE_PRECISE_MOUTH))
		if(user)
			if(user == target)
				user.visible_message("<span class='notice'>[user] decided not to shoot.</span>")
			else if(target && target.Adjacent(user))
				target.visible_message("<span class='notice'>[user] has decided to spare [target]</span>", "<span class='notice'>[user] has decided to spare your life!</span>")
		busy_action = FALSE
		return

	busy_action = FALSE

	target.visible_message("<span class='warning'>[user] pulls the trigger!</span>", "<span class='userdanger'>[user] pulls the trigger!</span>")

	playsound('sound/weapons/dink.ogg', 30, 1)

	if((iscultist(target)) || (is_servant_of_ratvar(target)))
		chambered.BB.damage *= 1500

	else if(chambered && chambered.BB)
		chambered.BB.damage *= 5

	process_fire(target, user, TRUE, params)

//pump action particle blaster
/obj/item/gun/energy/pumpaction		//parent object with all procs defined under. Useless in-game, but VERY important codewise
	icon_state = "blaster"
	name = "pump-action particle blaster"
	desc = "A pump action energy gun that requires manual racking to charge supercapacitors."
	icon = 'modular_citadel/icons/obj/guns/pumpactionblaster.dmi'
	cell_type = /obj/item/stock_parts/cell/pumpaction
	var/recentpump = 0 // to prevent spammage

/obj/item/gun/energy/pumpaction/emp_act(severity)	//makes it not rack itself when emp'd
	cell.use(round(cell.charge / severity))
	chambered = 0 //we empty the chamber
	update_icon()

/obj/item/gun/energy/pumpaction/process()	//makes it not rack itself when self-charging
	if(selfcharge && cell?.charge < cell.maxcharge)
		charge_tick++
		if(charge_tick < charge_delay)
			return
		charge_tick = 0
		if(selfcharge == EGUN_SELFCHARGE_BORG)
			var/atom/owner = loc
			if(istype(owner, /obj/item/robot_module))
				owner = owner.loc
			if(!iscyborg(owner))
				return
			var/mob/living/silicon/robot/R = owner
			if(!R.cell?.use(100))
				return
		cell.give(100)
	update_icon()

/obj/item/gun/energy/pumpaction/attack_self(mob/living/user)	//makes clicking on it in hand pump it
	if(recentpump > world.time)
		return
	pump(user)
	recentpump = world.time + 10
	return

/obj/item/gun/energy/pumpaction/process_chamber()	//makes it so that it doesn't rack itself after firing
	if(chambered && !chambered.BB) //if BB is null, i.e the shot has been fired...
		var/obj/item/ammo_casing/energy/shot = chambered
		cell.use(shot.e_cost)//... drain the cell cell
	chambered = 0 //either way, released the prepared shot

/obj/item/gun/energy/pumpaction/post_set_firemode()
	var/has_shot = chambered
	. = ..(recharge_newshot = FALSE)
	if(has_shot)
		recharge_newshot(TRUE)

/obj/item/gun/energy/pumpaction/update_icon()	//adds racked indicators
	..()
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	if(chambered)
		add_overlay("[icon_state]_rack_[shot.select_name]")
	else
		add_overlay("[icon_state]_rack_empty")

/obj/item/gun/energy/pumpaction/proc/pump(mob/M)	//pumping proc. Checks if the gun is empty and plays a different sound if it is.
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	if(cell.charge < shot.e_cost)
		playsound(M, 'sound/weapons/laserPumpEmpty.ogg', 100, 1)	//Ends with three beeps made from highly processed knife honing noises
	else
		playsound(M, 'sound/weapons/laserPump.ogg', 100, 1)		//Ends with high pitched charging noise
	recharge_newshot() //try to charge a new shot
	update_icon()
	return 1

/obj/item/gun/energy/pumpaction/AltClick(mob/living/user)	//for changing firing modes since attackself is already used for pumping
	. = ..()
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return

	if(ammo_type.len > 1)
		if(user.incapacitated() || !istype(user))
			to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		else
			select_fire(user)
			update_icon()
		return TRUE

/obj/item/gun/energy/pumpaction/examine(mob/user)	//so people don't ask HOW TO CHANGE FIRING MODE
	. = ..()
	. += "<span class='notice'>Alt-click to change firing modes.</span>"

/obj/item/gun/energy/pumpaction/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)	//ammo counter for inhands
	. = ..()
	var/ratio = CEILING((cell.charge / cell.maxcharge) * charge_sections, 1)
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	if(isinhands)
		if(cell.charge < shot.e_cost)
			var/mutable_appearance/ammo_inhand = mutable_appearance(icon_file, "[item_state]_empty")
			. += ammo_inhand
		else
			var/mutable_appearance/ammo_inhand = mutable_appearance(icon_file, "[item_state]_charge_[shot.select_name][ratio]")
			. += ammo_inhand
		if(chambered)
			var/mutable_appearance/rack_inhand = mutable_appearance(icon_file, "[item_state]_rack_[shot.select_name]")
			. += rack_inhand
		else
			var/mutable_appearance/rack_inhand = mutable_appearance(icon_file, "[item_state]_rack_empty")
			. += rack_inhand

//PUMP ACTION DISABLER
/obj/item/gun/energy/pumpaction/blaster
	icon_state = "blaster"
	name = "pump-action particle blaster"
	desc = "A non-lethal pump-action particle blaster with an overdrive firing mode. Requires manual racking after every shot to charge an integral bank of supercapacitors."
	item_state = "particleblaster"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/disabler/pump, /obj/item/ammo_casing/energy/disabler/slug)
	ammo_x_offset = 2
	modifystate = 1

//WARDEN'S SPECIAL VERSION
/obj/item/gun/energy/pumpaction/defender
	icon_state = "defender"
	name = "particle defender"
	desc = "A pump-action particle blaster with a unique particle focusing chamber optimized for decisive de-escalation. Requires manual racking after every shot to charge an integral bank of supercapacitors."
	item_state = "particleblaster"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/pump, /obj/item/ammo_casing/energy/laser/pump)
	ammo_x_offset = 2
	modifystate = 1
