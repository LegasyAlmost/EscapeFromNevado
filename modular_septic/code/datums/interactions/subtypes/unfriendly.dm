/datum/interaction/unfriendly
	category = INTERACTION_CATEGORY_UNFRIENDLY
	interaction_flags = INTERACTION_RESPECT_COOLDOWN|INTERACTION_NEEDS_PHYSICAL_CONTACT
	user_cooldown_duration = INTERACTION_COOLDOWN
	target_cooldown_duraction = INTERACTION_COOLDOWN
	button_icon = "handshake"
/datum/interaction/unfriendly/middlefinger
	name = "Послать"
	desc = "Послать к черту!"
	message = span_warning("%USER показывает средний палец %TARGET.")
	user_message = span_warning("Я показываю средний палец %TARGET!")
	target_message = span_warning("%USER показывает мне средний палец!")
	usage = INTERACT_OTHER
	user_hands_required = 1
	button_icon = "hand-middle-finger"
	maximum_distance = 7
