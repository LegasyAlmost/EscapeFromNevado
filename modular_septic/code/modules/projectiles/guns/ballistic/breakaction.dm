//BASE BREAK ACTION RIFLE
/obj/item/gun/ballistic/breakaction
	worn_icon = 'modular_septic/icons/obj/items/guns/worn/back.dmi'
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	lefthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_lefthand.dmi'
	righthand_file = 'modular_septic/icons/obj/items/guns/inhands/rifle_righthand.dmi'
	equip_sound = 'modular_septic/sound/weapons/guns/weap_away.ogg'
	bolt_type = BOLT_TYPE_BREAK_ACTION
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	rack_sound_vary = FALSE
	suppressed = SUPPRESSED_NONE
	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	mag_display = FALSE
	mag_display_ammo = FALSE
	empty_indicator = FALSE
	empty_icon_state = FALSE
	wielded_inhand_state = TRUE
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	skill_melee = SKILL_IMPACT_WEAPON_TWOHANDED
	skill_ranged = SKILL_RIFLE
	can_bayonet = FALSE
	can_be_sawn_off = FALSE
	safety_flags = NONE
	semi_auto = TRUE
	cylinder_shows_open = TRUE
	internal_magazine = TRUE

//DUENDE MALDITO UNIVERSAL GUN
/obj/item/gun/ballistic/breakaction/duende
	name = "\improper Duende Maldito all-purpose rifle"
	desc = "A very high tech, low usability weapon capable of loading any kind of ammunition you throw at it. \
			Looking at it makes you feel slightly ill."
	icon = 'modular_septic/icons/obj/items/guns/48x32.dmi'
	inhand_icon_state = "bobox"
	base_icon_state = "duende"
	icon_state = "duende"
	worn_icon_state = "duende"
	wielded_inhand_state = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	cylinder_wording = "barrel"
	// hammer sound
	rack_sound = list(
		'modular_septic/sound/weapons/guns/revolver/hammer1.ogg', \
		'modular_septic/sound/weapons/guns/revolver/hammer2.ogg', \
	)
	drop_sound = 'modular_septic/sound/weapons/guns/drop_lightgun.ogg'
	// close cylinder sound
	lock_back_sound = 'modular_septic/sound/weapons/guns/shotgun/db_in.ogg'
	// open cylinder sound
	bolt_drop_sound = 'modular_septic/sound/weapons/guns/shotgun/db_out.ogg'
	fire_sound = 'modular_septic/sound/weapons/guns/rifle/duendemaldito.ogg'
	load_sound = 'modular_septic/sound/weapons/guns/shotgun/db_load.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/duende
	slot_flags = ITEM_SLOT_BELT
	tetris_width = 96
	tetris_height = 32

/obj/item/gun/ballistic/breakaction/duende/examine(mob/user)
	. = ..()
	//the gun is vile and disgusting
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		carbon_user.adjust_blurriness(1)
		carbon_user.adjust_disgust(4)
		carbon_user.HeadRape(4 SECONDS)
