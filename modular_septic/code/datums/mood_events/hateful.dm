/datum/mood_event/fraggot
	description = span_flashingdanger(span_big("I must kill the fraggot!"))
	mood_change = -6
	timeout = 0

/datum/mood_event/fraggot/add_effects(mob/living/fraggot)
	description = span_flashingdanger(span_big("I must kill [fraggot.real_name]!"))
	RegisterSignal(fraggot, COMSIG_LIVING_DEATH, .proc/fraggot_died)

/datum/mood_event/fraggot/proc/fraggot_died(mob/living/fraggot)
	SIGNAL_HANDLER

	qdel(src)

/datum/mood_event/insult
	description = span_userdanger("I'm not a guttersnipe!")
	mood_change = -4
	timeout = 0

/datum/mood_event/insult/add_effects(mob/living/insulter)
	description = span_userdanger("[insulter] called me a guttersnipe!")
	RegisterSignal(insulter, COMSIG_LIVING_DEATH, .proc/insulter_died)

/datum/mood_event/insult/proc/insulter_died(mob/living/insulter)
	SIGNAL_HANDLER

	qdel(src)
