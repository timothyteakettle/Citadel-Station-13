// Honker

/obj/item/projectile/bullet/honker
	damage = 0
	knockdown = 60
	movement_type = FLYING | UNSTOPPABLE
	nodamage = TRUE
	candink = FALSE
	hitsound = 'sound/items/bikehorn.ogg'
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana"
	range = 200

/obj/item/projectile/bullet/honker/Initialize()
	. = ..()
	SpinAnimation()

// Mime

/obj/item/projectile/bullet/mime
	damage = 20

/obj/item/projectile/bullet/mime/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.silent = max(M.silent, 10)

/obj/item/projectile/beam/lasertag/wavemotion
	tracer_type = /obj/effect/projectile/tracer/laser/wavemotion
	muzzle_type = /obj/effect/projectile/muzzle/laser/wavemotion
	impact_type = /obj/effect/projectile/impact/laser/wavemotion
	hitscan = TRUE

/obj/item/projectile/beam/lasertag/dispersal
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue
	hitscan = TRUE
