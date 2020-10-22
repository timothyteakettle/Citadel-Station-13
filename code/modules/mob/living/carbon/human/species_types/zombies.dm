#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/zombie
	// 1spooky
	name = "High-Functioning Zombie"
	id = SPECIES_ZOMBIE
	say_mod = "moans"
	sexes = 0
	blacklisted = 1
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	mutanttongue = /obj/item/organ/tongue/zombie
	var/static/list/spooks = list('sound/hallucinations/growl1.ogg','sound/hallucinations/growl2.ogg','sound/hallucinations/growl3.ogg','sound/hallucinations/veryfar_noise.ogg','sound/hallucinations/wail.ogg')
	disliked_food = NONE
	liked_food = GROSS | MEAT | RAW
	species_category = SPECIES_CATEGORY_UNDEAD

//halloween zombies
/datum/species/zombie/notspaceproof
	id = "notspaceproofzombie"
	limbs_id = SPECIES_ZOMBIE
	blacklisted = 0
	inherent_traits = list(TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	//they are inherently extremely weak, however eating brains can make them strong by learning abilities
	brutemod = 1.5
	burnmod = 1.5
	coldmod = 1.5
	heatmod = 1.5
	stunmod = 1.5

	var/list/eaten_bodies //being picky eaters, they won't learn stuff from biting into the same person
	var/eating_body = FALSE
	var/eating_duration = 10 SECONDS

/datum/species/zombie/notspaceproof/proc/eat_body(mob/living/carbon/human/eater,mob/living/carbon/human/body)
	if(istype(body))
		eater.visible_message("[eater] begins tearing into [body]'s flesh!", "<span class='notice'>You begin tearing into [body]'s flesh!</span>")
		if(do_after_advanced(eater, eating_duration. extra_checks = CALLBACK(src, .proc/zombie_eat_tick, eater, body)))
			if(learn_from_body(body))
				to_chat(eater, "<span class='warning'>You feel like you gained something from eating [body]'s flesh, though you aren't quite sure what.</span>")
			else
				to_chat(eater, "<span class='warning'>You didn't learn anything from eating [body]'s flesh.</span>")
		else
			eater.visible_message("[eater] stops tearing into [body]'s flesh.", "<span class='notice'>You stop tearing into [body]'s flesh.</span>")

/datum/species/zombie/notspaceproof/proc/zombie_eat_tick(mob/living/carbon/human/eater, mob/living/carbon/human/body)
	if(eater && body)
		if(eater.grab_state >= GRAB_AGGRESSIVE && ishuman(eater.pulling))
			return TRUE
	return FALSE

/datum/species/zombie/notspaceproof/check_roundstart_eligible()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		return TRUE
	return ..()

//romerol/infectious zombies
/datum/species/zombie/infectious
	name = "Infectious Zombie"
	id = "memezombies"
	limbs_id = SPECIES_ZOMBIE
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_NOSOFTCRIT, TRAIT_FAKEDEATH)
	mutanthands = /obj/item/zombie_hand
	armor = 20 // 120 damage to KO a zombie, which kills it
	speedmod = 1.6 // they're very slow
	mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	var/heal_rate = 1
	var/regen_cooldown = 0

/datum/species/zombie/infectious/check_roundstart_eligible()
	return FALSE

/datum/species/zombie/infectious/spec_stun(mob/living/carbon/human/H,amount)
	. = min(20, amount)

/datum/species/zombie/infectious/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE)
	. = ..()
	if(.)
		regen_cooldown = world.time + REGENERATION_DELAY

/datum/species/zombie/infectious/spec_life(mob/living/carbon/C)
	. = ..()
	C.a_intent = INTENT_HARM // THE SUFFERING MUST FLOW

	//Zombies never actually die, they just fall down until they regenerate enough to rise back up.
	//They must be restrained, beheaded or gibbed to stop being a threat.
	if(regen_cooldown < world.time)
		var/heal_amt = heal_rate
		if(C.InCritical())
			heal_amt *= 2
		C.heal_overall_damage(heal_amt,heal_amt)
		C.adjustToxLoss(-heal_amt)
		for(var/i in C.all_wounds)
			var/datum/wound/iter_wound = i
			if(prob(4-iter_wound.severity))
				iter_wound.remove_wound()
	if(!C.InCritical() && prob(4))
		playsound(C, pick(spooks), 50, TRUE, 10)

//Congrats you somehow died so hard you stopped being a zombie
/datum/species/zombie/infectious/spec_death(gibbed, mob/living/carbon/C)
	. = ..()
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(infection)
		qdel(infection)

/datum/species/zombie/infectious/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	// Deal with the source of this zombie corruption
	//  Infection organ needs to be handled separately from mutant_organs
	//  because it persists through species transitions
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(!infection)
		infection = new()
		infection.Insert(C)

	//make their bodyparts stamina-immune, its a corpse.
	var/incoming_stam_mult = 0
	for(var/obj/item/bodypart/part in C.bodyparts)
		part.incoming_stam_mult = incoming_stam_mult
		//todo: add negative wound resistance to all parts when wounds is merged (zombies are physically weak in terms of limbs)

// fake zombies from getting addicted to krokodil and your skin falling off
/datum/species/krokodil_addict
	name = SPECIES_HUMAN
	id = "goofzombies"
	limbs_id = SPECIES_ZOMBIE //They look like zombies
	sexes = 0
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	mutanttongue = /obj/item/organ/tongue/zombie

#undef REGENERATION_DELAY
