/datum/job/denominator
	title = "Denominator"
	department_head = list("misery")

	outfit = /datum/outfit/denominator
	mob_species = /datum/species/denominator

/datum/job/denominator_shotgunner
	title = "Denominator Shotgunner"
	outfit = /datum/outfit/denominator/shotgunner
	mob_species = /datum/species/denominator

/datum/outfit/denominator
	name = "Denominator"

	uniform = /obj/item/clothing/under/denomination
	suit = /obj/item/clothing/suit/armor/denominator
	backpack_contents = list(
		/obj/item/keycard/red = 1,
		/obj/item/melee/truncheon/black = 1,
		/obj/item/ammo_box/magazine/hksmg380 = 3
		)
	l_pocket = /obj/item/simcard
	r_pocket = /obj/item/ammo_box/magazine/hksmg380
	id = /obj/item/cellphone
	glasses = /obj/item/clothing/glasses/night
	head = /obj/item/clothing/head/denominator
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots

	suit_store = /obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed
	back = /obj/item/storage/backpack/satchel/itobe

/datum/outfit/denominator/shotgunner
	name = "Denominator Shotgunner"
	suit = /obj/item/clothing/suit/armor/denominator/shotgunner
	glasses = /obj/item/clothing/glasses/night
	head = /obj/item/clothing/head/denominator/shotgunner
	suit_store = /obj/item/gun/ballistic/shotgun/denominator
	r_pocket = /obj/item/ammo_box/magazine/ammo_stack/shotgun/buckshot/loaded
	backpack_contents = list(
		/obj/item/keycard/red = 1,
		/obj/item/melee/truncheon/black = 1,
		/obj/item/ammo_box/magazine/ammo_stack/shotgun/buckshot/loaded = 4
		)


/datum/job/denominator/after_spawn(mob/living/spawned, client/player_client)
	..()
	var/mob/living/carbon/human/spawned_human = spawned

	spawned_human.mind.add_antag_datum(/datum/antagonist/denominator)
	spawned_human.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator)

	spawned_human.hairstyle = "Bald"
	spawned_human.facial_hairstyle = "Shaved"
	spawned_human.skin_tone = "albino"
	spawned_human.update_body()
	spawned_human.update_hair()

	spawned_human.real_name = "[denominator_first()] [prob(1) ? "Sixty-Nine" : denominator_last()]"
	spawned_human.update_name()
	spawned_human.update_sight()

/datum/job/denominator_shotgunner/after_spawn(mob/living/spawned, client/player_client)
	..()

	var/mob/living/carbon/human/spawned_human = spawned
	spawned_human.mind.add_antag_datum(/datum/antagonist/denominator/shotgunner)
	spawned_human.attributes.add_sheet(/datum/attribute_holder/sheet/job/denominator/shotgunner)

	spawned_human.hairstyle = "Bald"
	spawned_human.facial_hairstyle = "Shaved"
	spawned_human.skin_tone = "albino"
	spawned_human.update_body()
	spawned_human.update_hair()

	spawned_human.real_name = "[denominator_first()] [prob(1) ? "Sixty-Nine" : denominator_last()]"
	spawned_human.update_name()
