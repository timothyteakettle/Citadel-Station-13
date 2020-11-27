/datum/keybinding/client/communication
	category = CATEGORY_COMMUNICATION

/datum/keybinding/client/communication/say
	hotkey_keys = list("CtrlT")
	name = "Say"
	full_name = "IC Say"

/datum/keybinding/client/communication/ooc
	hotkey_keys = list("O")
	name = "OOC"
	full_name = "Out Of Character Say (OOC)"

/datum/keybinding/client/communication/me
	hotkey_keys = list("CtrlM")
	name = "Me"
	full_name = "Me (emote)"

//indicators
/datum/keybinding/client/communication/say_with_indicator
	hotkey_keys = list("T")
	classic_keys = list()
	name = "say_with_indicator"
	full_name = "Say with Typing Indicator"

/datum/keybinding/client/communication/say_with_indicator/down(client/user)
	var/mob/M = user.mob
	M.say_typing_indicator()
	return TRUE

/datum/keybinding/client/communication/me_with_indicator
	hotkey_keys = list("M")
	classic_keys = list()
	name = "me_with_indicator"
	full_name = "Me (emote) with Typing Indicator"

/datum/keybinding/client/communication/me_with_indicator/down(client/user)
	var/mob/M = user.mob
	M.me_typing_indicator()
	return TRUE

/datum/keybinding/client/communication/subtle
	hotkey_keys = list("5")
	classic_keys = list()
	name = "Subtle"
	full_name = "Subtle Emote"

/datum/keybinding/client/communication/subtler
	hotkey_keys = list("6")
	classic_keys = list()
	name = "Subtler"
	full_name = "Subtler Anti-Ghost Emote"

/datum/keybinding/client/communication/whisper
	hotkey_keys = list("Y")
	classic_keys = list()
	name = "Whisper"
	full_name = "Whisper"

/datum/keybinding/client/communication/looc
	hotkey_keys = list("L")
	classic_keys = list()
	name = "LOOC"
	full_name = "Local Out of Character chat"