/mob/living/simple_animal/hostile/itobe // this is base
	name = "\improper Itobe Operative"
	desc = "Человек, со странным личиком. Выглядит достаточно опасным"
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "faceless"
	icon_living = "faceless"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 2
	speed = 2
	maxHealth = 100
	health = 100
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_continuous = "ударяет"
	attack_verb_simple = "бить"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	var/list/secondary_loot = list()
	loot = list(/obj/effect/mob_spawn/human/itobe,
				/obj/item/knife/combat)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list("itobe")
	status_flags = CANPUSH
	del_on_death = 1
	wander = TRUE
	footstep_type = FOOTSTEP_MOB_SHOE
	secondary_loot = list()

/mob/living/simple_animal/hostile/itobe/drop_loot()
	..()
	if(secondary_loot.len)
		for(var/i in secondary_loot)
			if(prob(50))
				new i(loc)


/mob/living/simple_animal/hostile/itobe/itobe_agent
	name = "\improper Itobe Agent"
	desc = "Человек, со странной внешностью, в официальном стиле и в очках. Выглядит достаточно странным."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "itobe_agent_gun"
	icon_living = "itobe_agent_gun"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	loot = list(/obj/effect/mob_spawn/human/itobe/agent,
 				/obj/item/gun/ballistic/automatic/pistol/glock17)
	ranged = TRUE
	retreat_distance = 3
	minimum_distance = 4
	check_friendly_fire = TRUE
	projectilesound = 'modular_septic/sound/weapons/guns/pistol/glock1.wav'
	projectiletype = /obj/projectile/bullet/c9mm
	casingtype = /obj/item/ammo_casing/c9mm
	secondary_loot = list(/obj/item/ammo_box/magazine/ammo_stack/c9mm/loaded, /obj/item/ammo_box/magazine/ammo_stack/c9mm)

/mob/living/simple_animal/hostile/itobe/itobe_agent/smg
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "itobe_agent_smg"
	icon_living = "itobe_agent_smg"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	loot = list(/obj/effect/mob_spawn/human/itobe/agent,
				/obj/item/gun/ballistic/automatic/remis/smg/bolsa)
	ranged = TRUE
	retreat_distance = 3
	minimum_distance = 3
	projectilesound = 'modular_septic/sound/weapons/guns/smg/bolsa.wav'
	casingtype = /obj/item/ammo_casing/c9mm
	secondary_loot = list(/obj/item/ammo_box/magazine/uzi9mm, /obj/item/ammo_box/magazine/uzi9mm)

/mob/living/simple_animal/hostile/itobe/itobe_engineer
	name = "\improper Itobe Engineer"
	desc = "Какое-то существо, со странной внешностью, походит на боевого инженера. Выглядит достаточно странным."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "itobe_engineer_gun"
	icon_living = "itobe_engineer_gun"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	maxHealth = 120
	health = 120
	loot = list(/obj/effect/mob_spawn/human/itobe/engineer,
 				/obj/item/gun/ballistic/automatic/remis/smg/solitario)
	ranged = TRUE
	retreat_distance = 3
	minimum_distance = 4
	check_friendly_fire = TRUE
	projectilesound = 'modular_septic/sound/weapons/guns/smg/hksmg.wav'
	projectiletype = /obj/projectile/bullet/c22lr
	casingtype = /obj/item/ammo_casing/c22lr
	secondary_loot = list(/obj/item/ammo_box/magazine/hksmg22lr, /obj/item/ammo_box/magazine/hksmg22lr)

/mob/living/simple_animal/hostile/itobe/itobe_engineer/shotgun
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "itobe_engineer_shotgun"
	icon_living = "itobe_engineer_shotgun"
	icon_dead = "russianmelee_dead"
	icon_gib = "syndicate_gib"
	loot = list(/obj/effect/mob_spawn/human/itobe/engineer,
				/obj/item/gun/ballistic/shotgun/denominator)
	ranged = TRUE
	retreat_distance = 3
	minimum_distance = 3
	projectilesound = 'modular_septic/sound/weapons/guns/shotgun/spas1.ogg'
	casingtype = /obj/item/ammo_casing/c9mm
	secondary_loot = list(/obj/item/ammo_box/magazine/ammo_stack/shotgun/loaded, /obj/item/ammo_box/magazine/ammo_stack/shotgun/loaded)

