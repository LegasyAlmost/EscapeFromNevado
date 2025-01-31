// c20r
/obj/item/gun/ballistic/automatic/c20r
	pin = /obj/item/firing_pin
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_SMG

// m90
/obj/item/gun/ballistic/automatic/m90
	pin = /obj/item/firing_pin
	skill_melee = SKILL_IMPACT_WEAPON
	skill_ranged = SKILL_SMG

/obj/item/gun/ballistic/automatic/remis/smg
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	equip_sound = list('modular_septic/sound/weapons/guns/rifle_holster1.ogg', 'modular_septic/sound/weapons/guns/rifle_holster2.ogg')
	skill_melee = SKILL_IMPACT_WEAPON
	slot_flags = ITEM_SLOT_BACK
	skill_ranged = SKILL_SMG
	suppressed = SUPPRESSED_NONE
	full_auto = TRUE

// ppsh
/obj/item/gun/ballistic/automatic/remis/smg/ppsh
	name = "\improper ПП Папасши"
	desc = "Пистолет пулемёт Папасши. Переделка ППШ 20-го века оружейным гением - Папасшем. Калибр - 9мм."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	base_icon_state = "ppsh"
	icon_state = "ppsh"
	mag_type = /obj/item/ammo_box/magazine/ppsh9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	fire_delay = 2
	burst_size = 3
	custom_price = 4000

// hksmg
/obj/item/gun/ballistic/automatic/remis/smg/solitario
	name = "\improper 'Solitario Inseguro' SMG R-5"
	desc = "Лёгкий пистолет пулемёт компании S&I для гражданского рынка и военного контингента. Калибр - 22 Long Rifle."
	icon = 'modular_septic/icons/obj/items/guns/smg.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	inhand_icon_state = "hksmg"
	base_icon_state = "hksmg"
	icon_state = "hksmg"
	rack_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_rack.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockin.wav'
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/hksmg.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_silenced.ogg'
	mag_type =	/obj/item/ammo_box/magazine/hksmg22lr
	weapon_weight = WEAPON_LIGHT
	bolt_type = BOLT_TYPE_LOCKING
	slot_flags = ITEM_SLOT_BELT
	force = 10
	recoil = 0.2
	fire_delay = 2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 9
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 2, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
	custom_price = 10000

/obj/item/gun/ballistic/automatic/remis/smg/bastardo
	name = "\improper 'Bastardo' R-1"
	desc = "Полностью автоматический пистолет пулемёт 'Bastardo' модификации R-1 предназначен для офицеров ЧОП ZoomTech. Имеет складной приклад и насадку под глушитель. Калибр - 9мм"
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	worn_icon_state = "vityaz"
	inhand_icon_state = "vityaz"
	base_icon_state = "vityaz"
	icon_state = "vityaz"
	load_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/rifle/akrack.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/vityaz_silenced.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/vityaz.ogg'
	fireselector_auto = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_burst = 'modular_septic/sound/weapons/guns/rifle/aksafety2.wav'
	fireselector_semi = 'modular_septic/sound/weapons/guns/rifle/aksafety1.wav'
	mag_type =	/obj/item/ammo_box/magazine/bastardo9mm
	weapon_weight = WEAPON_MEDIUM
	force = 10
	recoil = 0.2
	fire_delay = 0.8
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 6
	gunshot_animation_information = list("pixel_x" = 15, \
										"pixel_y" = 2, \
										"inactive_when_silenced" = TRUE)
	recoil_animation_information = list("recoil_angle_upper" = -10, \
										"recoil_angle_lower" = -20, \
										"recoil_burst_speed" = 0.5, \
										"return_burst_speed" = 0.5)
	custom_price = 20000

/obj/item/gun/ballistic/automatic/remis/smg/thump
	name = "\improper 'Solitario Inseguro' SMG R-2"
	desc = "Полностью автоматический пистолет пулемёт компании S&I. Имеет три режима стрельбы. Калибр - .45 ACP."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	worn_icon_state = "ump"
	inhand_icon_state = "ump"
	base_icon_state = "ump"
	icon_state = "ump"
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/thump_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/thump_lockin.wav'
	rack_sound = 'modular_septic/sound/weapons/guns/smg/thump_rack.wav'
	load_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magin.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/smg/thump_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/thump.wav'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/thump_silenced.wav'
	mag_type =	/obj/item/ammo_box/magazine/thump45
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_LOCKING
	force = 10
	recoil = 0.2
	fire_delay = 1.2
	burst_size = 2
	can_suppress = TRUE
	suppressor_x_offset = 6
	can_flashlight = TRUE
	flight_x_offset = 30
	flight_y_offset = 14

// s-hksmg
/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed
	name = "'Solitario-SD Inseguro' R-7 \"Saber\" submachine gun"
	desc = "Пистолет пулемёт компании S&I со встроенным глушителем. Калибр - .380."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/hksmg380_silenced.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/hksmg380_silenced.ogg'
	weapon_weight = WEAPON_MEDIUM
	worn_icon_state = "hksmg-s"
	inhand_icon_state = "hksmg-s"
	base_icon_state = "hksmg-s"
	icon_state = "hksmg-s"
	fire_delay = 1.4
	burst_size = 3
	mag_type = /obj/item/ammo_box/magazine/hksmg380
	slot_flags = ITEM_SLOT_BACK
	can_suppress = TRUE
	can_unsuppress = FALSE
	foldable = TRUE
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

/obj/item/gun/ballistic/automatic/remis/smg/solitario/suppressed/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/remis/smg/vector
	name = "\improper 'Victor' SMG"
	desc = "Компактный пистолет пулемёт компании Bastardo. В основном встречается у Частных Охранных Организациях (ЧОО). Калибр - .45 caseless."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/smg_righthand.dmi'
	inhand_icon_state = "vector"
	base_icon_state = "vector"
	icon_state = "vector"
	rack_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_rack.wav'
	lock_back_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockback.wav'
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/smg/hksmg_lockin.wav'
	load_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.wav'
	load_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magin.wav'
	eject_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.wav'
	eject_empty_sound = 'modular_septic/sound/weapons/guns/pistol/pistol_magout.wav'
	safety_off_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	safety_on_sound = 'modular_septic/sound/weapons/guns/rifle/msafety.wav'
	fire_sound = 'modular_septic/sound/weapons/guns/smg/vector.ogg'
	suppressed_sound = 'modular_septic/sound/weapons/guns/smg/vector_silenced.ogg'
	mag_type =	/obj/item/ammo_box/magazine/vector45
	weapon_weight = WEAPON_MEDIUM
	force = 7
	recoil = 0.1
	fire_delay = 1.2
	burst_size = 3
	slot_flags = ITEM_SLOT_BELT
	can_suppress = TRUE
	foldable = TRUE
	suppressor_x_offset = 7
	custom_price = 65633
