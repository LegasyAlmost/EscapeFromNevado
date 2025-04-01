/datum/job/inborn
	title = "Inborn"
	department_head = list("famine")
	mob_species = /datum/species/inborn
	outfit = /datum/outfit/inborn

/datum/job/inborn/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	spawned.fully_replace_character_name(spawned.real_name, "Inborn")
	spawned.mind.add_antag_datum(/datum/antagonist/inborn)
	spawned.attributes.add_sheet(/datum/attribute_holder/sheet/job/inborn)
	spawned.apply_status_effect(/datum/status_effect/thug_shaker)

/datum/outfit/inborn
	name = "Inborn uniform"

	uniform = /obj/item/clothing/under/stray
	r_pocket = /obj/item/keycard/inborn
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots
	r_hand = /obj/item/changeable_attacks/sword/kukri
