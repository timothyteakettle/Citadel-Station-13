// xenowear
/datum/gear/uniform/xenowear
	category = LOADOUT_CATEGORY_XENOWEAR
	slot = SLOT_W_UNIFORM

// teshari
/datum/gear/uniform/xenowear/teshari
	subcategory = LOADOUT_SUBCATEGORY_XENOWEAR_TESHARI

// teshari smocks
/datum/gear/uniform/xenowear/teshari/smock/grey
	name = "small grey smock"
	path = /obj/item/clothing/under/teshari/grey_seromi

/datum/gear/uniform/xenowear/teshari/smock/red
	name = "small red smock"
	path = /obj/item/clothing/under/teshari/red_seromi

/datum/gear/uniform/xenowear/teshari/smock/yellow
	name = "small yellow smock"
	path = /obj/item/clothing/under/teshari/yellow_seromi

/datum/gear/uniform/xenowear/teshari/smock/white
	name = "small white smock"
	path = /obj/item/clothing/under/teshari/white_seromi

/datum/gear/uniform/xenowear/teshari/smock/rainbow
	name = "small rainbow smock"
	path = /obj/item/clothing/under/teshari/rainbow_seromi

/datum/gear/uniform/xenowear/teshari/smock/black_utility
	name = "black utility smock"
	path = /obj/item/clothing/under/teshari/black_utility_seromi

/datum/gear/uniform/xenowear/teshari/smock/black_utility
	name = "small utility uniform"
	path = /obj/item/clothing/under/teshari/black_utility

// teshari job smocks
/datum/gear/uniform/xenowear/teshari/smock/medical
	name = "small medical smock"
	path = /obj/item/clothing/under/teshari/medical_seromi
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/uniform/xenowear/teshari/smock/science
	name = "small science smock"
	path = /obj/item/clothing/under/teshari/science_seromi
	restricted_roles = list("Research Director", "Roboticist", "Scientist", "Geneticist")
	restricted_desc = "Science"

/obj/item/clothing/under/teshari/captain_seromi
	name = "small command smock"
	path = /obj/item/clothing/under/teshari/science_seromi
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

// teshari dresses
/datum/gear/uniform/xenowear/teshari/dress/grey
	name = "small grey dress"
	path = /obj/item/clothing/under/teshari/teshari_dress_grey

/datum/gear/uniform/xenowear/teshari/dress/grey
	name = "small grey and blue dress"
	path = /obj/item/clothing/under/teshari/teshari_dress_bluegrey

// teshari job dresses
/datum/gear/uniform/xenowear/teshari/dress/security
	name = "small security dress"
	path = /obj/item/clothing/under/teshari/security_dress
	restricted_roles = list("Security Officer", "Warden", "Head of Security")
	restricted_desc = "Security"

/datum/gear/uniform/xenowear/teshari/dress/security
	name = "small officer dress"
	path = /obj/item/clothing/under/teshari/officer_dress
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Quartermaster", "Head of Security", "Research Director", "Chief Engineer")
	restricted_desc = "Heads of staff""

/datum/gear/uniform/xenowear/teshari/dress/captain_dress
	name = "small command dress"
	path = /obj/item/clothing/under/teshari/captain_dress_seromi
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/gear/uniform/xenowear/teshari/dress/captain_formal
	name = "small formal command uniform"
	path = /obj/item/clothing/under/teshari/captain_dress_seromi/formal
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/gear/uniform/xenowear/teshari/dress/medical
	name = "small medical dress"
	/obj/item/clothing/under/teshari/medical_dress
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist")
	restricted_desc = "Medical"

/datum/gear/uniform/xenowear/teshari/dress/science
	name = "small science dress"
	path = /obj/item/clothing/under/teshari/science_dress
	restricted_roles = list("Research Director", "Roboticist", "Scientist", "Geneticist")
	restricted_desc = "Science"

/datum/gear/uniform/xenowear/teshari/dress/engineering
	name = "small engineering dress"
	path = /obj/item/clothing/under/teshari/engineering_dress
	restricted_roles = list("Chief Engineer", "Station Engineer", "Atmospheric Technician")
	restricted_desc = "Engineering"
