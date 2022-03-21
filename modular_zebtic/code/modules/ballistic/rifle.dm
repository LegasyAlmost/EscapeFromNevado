/obj/item/gun/ballistic/automatic/warfare
	icon = 'modular_zebtic/icons/obj/items/guns/48x32.dmi'
	worn_icon = 'modular_zebtic/icons/obj/items/guns/worn/back.dmi'
	lefthand_file = 'modular_zebtic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_zebtic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	equip_sound = list('modular_septic/sound/weapons/guns/rifle_holster1.ogg', 'modular_septic/sound/weapons/guns/rifle_holster2.ogg')
	slot_flags = ITEM_SLOT_BACK
	rack_sound_vary = FALSE
	suppressed = SUPPRESSED_NONE
	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	mag_display = TRUE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	empty_icon_state = TRUE
	wielded_inhand_state = TRUE
	weapon_weight = WEAPON_HEAVY
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_RIFLE

/obj/item/gun/ballistic/automatic/warfare/m545
	name = "\improper Peacekeeper 545"
	desc = "Named nicknamed for the type of PMC armies that are generally found carrying them."
	icon = 'modular_zebtic/icons/obj/items/guns/48x32.dmi'
	worn_icon_state = "inverno"
	inhand_icon_state = "m4"
	icon_state = "m4"
	base_icon_state = "m4"
	mag_type = /obj/item/ammo_box/magazine/a545
	full_auto = TRUE
	fire_delay_auto = 1.2
	burst_size_auto = 1
	burst_size = 1
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/g3.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/mmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/mrack.wav'
	fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	force = 14
	custom_price = 45000
	carry_weight = 3
	recoil_animation_information = list("recoil_angle_upper" = -15, \
										"recoil_angle_lower" = -25)


/obj/item/gun/ballistic/automatic/warfare/m545/ak
	name = "\improper Eclipse 545"
	desc = "Often found on... less than scrupulous PMC groups."
	inhand_icon_state = "ak"
	icon_state = "ak"
	base_icon_state = "ak"
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/ak.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/rifle/ak_silenced.wav'
	load_sound = 'modular_septic/sound/weapons/guns/rifle/akmagin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/rifle/akmagin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/rifle/akmagout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/rifle/akmagout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.wav'
	fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
