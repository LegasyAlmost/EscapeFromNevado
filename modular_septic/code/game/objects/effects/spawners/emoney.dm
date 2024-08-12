/datum/outfit/job/emoney
	name = "Emoney"

	uniform = /obj/item/clothing/under/color/grey/ancient
	suit = /obj/item/clothing/suit/armor/vest/alt/heavy
	backpack_contents = list(
		/obj/item/reagent_containers/food/drinks/bottle/maltliquor = 1,
		)
	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/helmet/heavy/visor
	shoes = /obj/item/clothing/shoes/jackboots
	id = null
	backpack = /obj/item/storage/backpack/itobe


/datum/outfit/job/emoney/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	//Gun
	if(prob(10))
		r_hand = /obj/item/gun/ballistic/automatic/remis/abyss
		backpack_contents = list(/obj/item/ammo_box/magazine/a545 = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(15))
		r_hand = /obj/item/gun/ballistic/automatic/remis/smg/bolsa
		backpack_contents = list(/obj/item/ammo_box/magazine/uzi9mm = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if (prob(25))
		r_hand = /obj/item/gun/ballistic/shotgun/automatic/combat
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(1))
		r_hand = /obj/item/gun/ballistic/shotgun/bolas
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/bolas/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(10))
		r_hand = /obj/item/gun/ballistic/automatic/remis/svd
		backpack_contents = list(/obj/item/ammo_box/magazine/a762svd = 4,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	else if(prob(5))
		r_hand = /obj/item/gun/ballistic/rifle/boltaction/remis/federson
		backpack_contents = list(/obj/item/ammo_box/magazine/ammo_stack/a276/loaded = 6,
		/obj/item/reagent_containers/hypospray/medipen/retractible/blacktar = 1, /obj/item/flashlight/seclite = 1)

	if(prob(50))//random chance for the colt instead of the glock
		r_hand = /obj/item/gun/ballistic/automatic/pistol/m1911
		r_pocket = /obj/item/ammo_box/magazine/m45
	else if(prob(1))
		r_hand = /obj/item/gun/ballistic/revolver/poppy
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
