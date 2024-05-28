/datum/job/assistant
	title = "Chattel Laborer"
	required_languages = null

	outfit = /datum/outfit/job/assistant/zoomtech

/datum/job/assistant/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_ILLITERATE, "[type]")

/datum/outfit/job/assistant/zoomtech
	name = "Chattel Laborer"

	uniform = /obj/item/clothing/under/color/grey/ancient
	id = null
	belt = null

	skillchips = null
