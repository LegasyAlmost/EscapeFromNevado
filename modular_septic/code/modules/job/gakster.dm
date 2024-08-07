/datum/job/gakster
	title = "Gakster Scavenger"
	department_head = list("pain")
	supervisors = "no-one"

	outfit = /datum/outfit/gakster
	attribute_sheet = /datum/attribute_holder/sheet/job/gakster

/datum/job/gakster/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	//if(ishuman(spawned))
	//	spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
	if(!prob(5))
		return
	qdel(spawned.get_item_by_slot(ITEM_SLOT_ID))
	qdel(spawned.get_item_by_slot(ITEM_SLOT_LPOCKET))
	spawned.equip_to_slot(new /obj/item/cellphone/hacker(spawned.loc), ITEM_SLOT_ID)
	//to_chat(spawned, "")


//It is time to equip our warriors...
/datum/outfit/gakster/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()

	if(!get_guns)
		return

	//Gun
	if(prob(10))
		suit_store = /obj/item/gun/ballistic/automatic/remis/abyss
		backpack_contents = list(/obj/item/ammo_box/magazine/a545 = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(15))
		suit_store = /obj/item/gun/ballistic/automatic/remis/smg/bolsa
		backpack_contents = list(/obj/item/ammo_box/magazine/uzi9mm = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if (prob(25))
		suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(1))
		r_hand = /obj/item/gun/ballistic/shotgun/bolas
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(10))
		suit_store = /obj/item/gun/ballistic/automatic/remis/svd
		backpack_contents = list(/obj/item/ammo_box/magazine/a762svd = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(5))
		suit_store = /obj/item/gun/ballistic/rifle/boltaction/remis/federson
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/a276/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else
		backpack_contents = list(/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	if(prob(50))//random chance for the colt instead of the glock
		belt = /obj/item/gun/ballistic/automatic/pistol/m1911
		r_pocket = /obj/item/ammo_box/magazine/m45
	else if(prob(1))
		belt = /obj/item/gun/ballistic/revolver/poppy
		r_pocket = /obj/item/ammo_box/magazine/ammo_stack/a500

	//Armor
	if(prob(50))
		suit = /obj/item/clothing/suit/armor/vest/alt
	else if (prob(25))
		suit = /obj/item/clothing/suit/armor/vest/alt/medium
	else if(prob(10))
		suit = /obj/item/clothing/suit/armor/vest/alt/heavy


	if(prob(50))
		head = /obj/item/clothing/head/helmet/heavy
	else if (prob(25))
		head = /obj/item/clothing/head/helmet/medium

	if(prob(50))
		mask = /obj/item/clothing/mask/balaclava

/datum/outfit/gakster
	var/get_guns = TRUE
	name = "Gakster Scavenger"
	uniform = /obj/item/clothing/under/itobe
	id = /obj/item/cellphone
	belt = /obj/item/gun/ballistic/automatic/pistol/glock17
	l_pocket = /obj/item/simcard
	r_pocket = /obj/item/ammo_box/magazine/glock9mm
	back = /obj/item/storage/backpack/satchel/chestrig
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots


/datum/outfit/gakster/tutorial
	get_guns = FALSE
	back = /obj/item/storage/backpack/satchel/itobe
	backpack_contents = list(/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)
	belt = null
	r_pocket = null

/datum/job/tutorial
	title = "Tutorial"
	department_head = list("pain")
	supervisors = "no-one"

	outfit = /datum/outfit/gakster/tutorial
	attribute_sheet = /datum/attribute_holder/sheet/job/gakster

/datum/job/tutorial/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(ishuman(spawned))
		spawned.apply_status_effect(/datum/status_effect/gakster_dissociative_identity_disorder)
		//spawned.AddElement(/datum/element/waddling)
	/*
	if(!prob(5))
		return
	qdel(spawned.get_item_by_slot(ITEM_SLOT_ID))
	qdel(spawned.get_item_by_slot(ITEM_SLOT_LPOCKET))
	spawned.equip_to_slot(new /obj/item/cellphone/hacker(spawned.loc), ITEM_SLOT_ID)
	//to_chat(spawned, "")
	*/
