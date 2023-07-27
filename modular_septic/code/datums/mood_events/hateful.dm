/datum/mood_event/fraggot
	description = span_flashingdanger(span_big("I must kill the fraggot!"))
	mood_change = -8
	timeout = 0

/datum/mood_event/fraggot/add_effects(mob/living/fraggot)
	description = span_flashingdanger(span_big("I must kill [fraggot.real_name]!"))
	RegisterSignal(fraggot, list(COMSIG_LIVING_DEATH, COMSIG_PARENT_QDELETING), .proc/fraggot_died)

/datum/mood_event/fraggot/proc/fraggot_died(mob/living/fraggot)
	SIGNAL_HANDLER

	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, category)
	UnregisterSignal(insulter, list(COMSIG_LIVING_DEATH, COMSIG_PARENT_QDELETING))

/datum/mood_event/insult
	description = span_userdanger("I'm not a guttersnipe!")
	mood_change = -6
	timeout = 0

/datum/mood_event/insult/add_effects(mob/living/insulter, insult = "guttersnipe")
	description = span_flashingdanger("[insulter] called me \a [insult]!")
	RegisterSignal(insulter, list(COMSIG_LIVING_DEATH, COMSIG_PARENT_QDELETING), .proc/insulter_died)

/datum/mood_event/insult/proc/insulter_died(mob/living/insulter)
	SIGNAL_HANDLER

	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, category)
	UnregisterSignal(insulter, list(COMSIG_LIVING_DEATH, COMSIG_PARENT_QDELETING))
