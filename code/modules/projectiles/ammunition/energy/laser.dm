/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/item/projectile/beam/laser
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/item/projectile/beam/laser
	e_cost = 83
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/old
	projectile_type = /obj/item/projectile/beam/laser
	e_cost = 200
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/hos
	e_cost = 100

/obj/item/ammo_casing/energy/laser/practice
	projectile_type = /obj/item/projectile/beam/practice
	select_name = "practice"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/scatter
	projectile_type = /obj/item/projectile/beam/scatter
	pellets = 5
	variance = 25
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/scatter/disabler
	projectile_type = /obj/item/projectile/beam/disabler
	pellets = 3
	variance = 15
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/heavy
	projectile_type = /obj/item/projectile/beam/laser/heavylaser
	select_name = "anti-vehicle"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/ammo_casing/energy/laser/hellfire
	projectile_type = /obj/item/projectile/beam/laser/hellfire
	e_cost = 130
	select_name = "maim"

/obj/item/ammo_casing/energy/laser/pulse
	projectile_type = /obj/item/projectile/beam/pulse
	e_cost = 200
	select_name = "DESTROY"
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/ammo_casing/energy/laser/bluetag
	projectile_type = /obj/item/projectile/beam/lasertag/bluetag
	select_name = "bluetag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/bluetag/hitscan
	projectile_type = /obj/item/projectile/beam/lasertag/bluetag/hitscan

/obj/item/ammo_casing/energy/laser/redtag
	projectile_type = /obj/item/projectile/beam/lasertag/redtag
	select_name = "redtag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/redtag/hitscan
	projectile_type = /obj/item/projectile/beam/lasertag/redtag/hitscan

/obj/item/ammo_casing/energy/laser/redtag/hitscan/holy
	projectile_type = /obj/item/projectile/beam/lasertag/redtag/hitscan/holy

/obj/item/ammo_casing/energy/laser/magtag
	projectile_type = /obj/item/projectile/beam/lasertag/mag
	select_name = "magtag"
	pellets = 3
	variance = 30
	e_cost = 1000
	fire_sound = 'sound/weapons/magburst.ogg'

/obj/item/ammo_casing/energy/xray
	projectile_type = /obj/item/projectile/beam/xray
	e_cost = 50
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/mindflayer
	projectile_type = /obj/item/projectile/beam/mindflayer
	select_name = "MINDFUCK"
	fire_sound = 'sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/laser/scatter/disabler/pump
	projectile_type = /obj/item/projectile/beam/disabler/weak
	e_cost = 150
	pellets = 4
	variance = 30
	fire_sound = 'sound/weapons/ParticleBlaster.ogg'
	select_name  = "disable"

/obj/item/ammo_casing/energy/disabler/slug
	projectile_type = /obj/item/projectile/beam/disabler/slug
	select_name  = "overdrive"
	e_cost = 200
	fire_sound = 'sound/weapons/LaserSlugv3.ogg'

/obj/item/ammo_casing/energy/laser/pump
	projectile_type = /obj/item/projectile/beam/pump
	e_cost = 350
	select_name = "kill"
	pellets = 6
	variance = 15
	fire_sound = 'sound/weapons/ParticleBlaster.ogg'

/obj/item/ammo_casing/energy/disabler/pump
	projectile_type = /obj/item/projectile/energy/disabler/pump
	select_name = "disable"
	fire_sound = 'sound/weapons/LaserSlugv3.ogg'
	e_cost = 150
	pellets = 6
	variance = 20

//practise gun
/obj/item/ammo_casing/energy/laser/raytag
	projectile_type = /obj/item/projectile/beam/lasertag/ray
	select_name = "raytag"
	fire_sound = 'sound/weapons/raygun.ogg'
