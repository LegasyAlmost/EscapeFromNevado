#define DOOR_CLOSE_WAIT 60

/obj/machinery/door/metal_door
	name = "Металлическая дверь"
	desc = "Широкая металлическая дверь с замком для ключей, обычно не запертая. Если замок есть, то дай ей хорошего крепкого пинка."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal"
	icon_state = "metal"
	key_worthy = TRUE
	var/doorOpen = 'modular_septic/sound/doors/door_metal_open.ogg'
	var/doorClose = 'modular_septic/sound/doors/door_metal_close.ogg'
	var/doorDeni = list('modular_septic/sound/doors/door_metal_try1.ogg', 'modular_septic/sound/doors/door_metal_try2.ogg')
	var/kickfailure = 'modular_septic/sound/doors/door_metal_freeman_impersonator.ogg'
	var/kicksuccess = 'modular_septic/sound/doors/smod_freeman.ogg'
	var/kickcriticalsuccess = 'modular_septic/sound/doors/smod_freeman_extreme.ogg'

	var/obj/structure/metal_door_frame/door_frame
	var/obj/structure/metal_door/thrown_door

	var/kicking_cooldown_duration = 0.8 SECONDS
	var/open_cooldown_duration = 2 SECONDS

	COOLDOWN_DECLARE(kicking_cooldown)
	COOLDOWN_DECLARE(open_cooldown)
	auto_align = FALSE

/obj/machinery/door/metal_door/north
	dir = NORTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/south
	dir = SOUTH
	pixel_x = -16
	pixel_y = -8

/obj/machinery/door/metal_door/east
	dir = EAST
	pixel_x = -16

/obj/machinery/door/metal_door/west
	dir = WEST
	pixel_x = -16

/obj/machinery/door/metal_door/open(mob/user)
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(!density)
		return 1
	if(operating)
		return
	if(locked)
		playsound(src, doorDeni, 70, FALSE)
		sound_hint()
		COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
		if(user)
			visible_message(span_danger("[user] дёргает ручку [src]."), \
			if(src, SPECIES_HOMIE)
				span_notice("Закрыто, сука!")
			else
				span_notice("Заперто"))
		return
	operating = TRUE
	do_animate("opening")
	set_opacity(0)
	set_density(FALSE)
	flags_1 &= ~PREVENT_CLICK_UNDER_1
	layer = initial(layer)
	update_appearance()
	set_opacity(0)
	operating = FALSE
	air_update_turf(TRUE, FALSE)
	update_freelook_sight()
	if(autoclose)
		autoclose_in(DOOR_CLOSE_WAIT)
	playsound(src, doorOpen, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return 1

/obj/machinery/door/metal_door/close()
	if(!COOLDOWN_FINISHED(src, open_cooldown))
		return
	if(density)
		return TRUE
	if(operating || welded)
		return
	if(safe)
		for(var/atom/movable/M in get_turf(src))
			if(M.density && M != src) //something is blocking the door
				if(autoclose)
					autoclose_in(DOOR_CLOSE_WAIT)
				return
	operating = TRUE
	do_animate("closing")
	layer = closingLayer
	set_density(TRUE)
	flags_1 |= PREVENT_CLICK_UNDER_1
	update_appearance()
	if(visible && !glass)
		set_opacity(1)
	operating = FALSE
	air_update_turf(TRUE, TRUE)
	update_freelook_sight()
	if(!can_crush)
		return TRUE
	if(safe)
		CheckForMobs()
	else
		crush()
	playsound(src, doorClose, 65, FALSE)
	COOLDOWN_START(src, open_cooldown, open_cooldown_duration)
	return TRUE

/obj/structure/metal_door_frame
	name = "Дверная рамка"
	desc = "Дверь не запилили."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_broken"
	icon_state = "metal_broken"
	density = FALSE
	opacity = FALSE
	plane = GAME_PLANE_ABOVE_WINDOW
	layer = OPEN_DOOR_LAYER
	move_resist = MOVE_FORCE_VERY_STRONG

/obj/structure/metal_door
	name = "Металлическая дверь"
	desc = "ДВЕРЬ МНЕ ЗАПИЛИ."
	icon = 'modular_septic/icons/obj/structures/metal_door.dmi'
	base_icon_state = "metal_freeman_evidence"
	icon_state = "metal_freeman_evidence"
	density = FALSE
	anchored = FALSE
	throwforce = 75
	var/state_variation = 2

/obj/structure/metal_door/Initialize(mapload)
	. = ..()
	if(state_variation)
		icon_state = "[base_icon_state][rand(1, 2)]"

/obj/machinery/door/metal_door/attack_foot(mob/user)
	. = ..()
	gordan_freeman_speedrunner(user, src)

/obj/machinery/door/metal_door/proc/imbatublow(mob/living/user, atom/source)
	var/turf/doorturf = get_turf(src)
	var/flying_dir = get_dir(user, source.loc)
	var/turf/freeman = get_ranged_target_turf(user, flying_dir, 3)
	doorturf.pollute_turf(/datum/pollutant/dust, 250)
	generate_door_combo()
	thrown_door.throw_at(freeman, range = 4, speed = 2)
	sound_hint()
	playsound(src, kickcriticalsuccess, 100, FALSE, 5)
	door_frame.dir = dir
	qdel(src)

/obj/machinery/door/metal_door/proc/generate_door_combo()
	var/turf/doorturf = get_turf(src)
	door_frame = new /obj/structure/metal_door_frame(doorturf)
	thrown_door = new /obj/structure/metal_door(doorturf)

/obj/machinery/door/metal_door/proc/gordan_freeman_speedrunner(mob/living/user)
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(!COOLDOWN_FINISHED(src, kicking_cooldown))
		return
	if(!(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 11))
		playsound(src, kickfailure, 75, FALSE, 2)
		visible_message(span_danger("[user] вышибает с ноги [src]!"), \
			span_danger("Я ударил с ноги [src], но это даётся тяжко!"))
		sound_hint()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)
		return
	if(user.diceroll(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH)+1) <= DICE_FAILURE)
		playsound(src, kickfailure, 75, FALSE, 2)
		visible_message(span_danger("[user] вышибает с ноги [src]!"), \
			span_danger("Я ударил с ноги [src]!"))
		sound_hint()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)
		return
	else if(GET_MOB_ATTRIBUTE_VALUE(user, STAT_STRENGTH) > 18)
		playsound(src, kicksuccess, 100, FALSE, 5)
		visible_message(span_bigdanger("[user] хуярит с ноги по [src], отчега она отлетает в сторону к хуям!"), \
			span_bolddanger("Я ёбнул по [src] и она уебалась в пол!"))
		sound_hint()
		locked = FALSE
		imbatublow(user, src)
		return
	else
		playsound(src, kicksuccess, 90, FALSE, 2)
		sound_hint()
		visible_message(span_danger("[user] вышибает [src] и она открывается!"), \
			span_danger("Я вдарил ногой по [src] и она открылась."))
		locked = FALSE
		open()
		COOLDOWN_START(src, kicking_cooldown, kicking_cooldown_duration)

/obj/machinery/door/metal_door/try_door_unlock(user)
	if(allowed(user))
		if(locked)
			unlock()
		else
			lock()
	return TRUE
