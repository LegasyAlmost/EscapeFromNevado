/obj/item/landmine
	name = "landmine"
	desc = "Use it to place a landmine in front of you. Be careful..."
	icon = 'modular_zebtic/code/modules/is12_mines/sprites/warfare.dmi'
	icon_state = "mine_item"
	var/mine_type = /obj/structure/landmine

/obj/item/landmine/Initialize(mapload, mine_type)
	if(mine_type)
		src.mine_type = mine_type
	. = ..()

/obj/item/landmine/attack_self(var/mob/user)
	var/turf/T = get_step(user, user.dir)
	if(T)
		if(isopenspaceturf(T))
			return
		if(HAS_TRAIT(user, TRAIT_PACIFISM))
			to_chat(user, span_warning("You can't bring yourself to place \the [src]! You don't want to risk harming anyone..."))
			return
		if(T.is_blocked_turf() || iswallturf(T))
			to_chat(user, "There's already something there!")
			return
		visible_message("[user] begins to place the mine!")
		if(do_after(user, 20))
			qdel(src)
			new mine_type(T)

/obj/structure/landmine
	name = "landmine"
	desc = "If you step on this you'll probably fucking die."
	icon = 'modular_zebtic/code/modules/is12_mines/sprites/warfare.dmi'
	icon_state = "mine"
	anchored = TRUE
	density = FALSE
	var/armed = FALSE//Whether or not it will blow up.
	var/can_be_armed = TRUE//Whether or not it can be armed to blow up. Disarmed mines won't blow.
	var/mob/stepper = null
	var/heavy_impact = 2
	var/light_impact = 2
	var/magnitude = 4
	var/reject_chance = 5
	var/shred_triggerer = FALSE

/obj/structure/landmine/Initialize(mapload)
	. = ..()
	update_icon()
	AddComponent(/datum/component/pellet_cloud, projectile_type=/obj/projectile/bullet/shrapnel, magnitude=src.magnitude)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		COMSIG_ATOM_ENTERED = PROC_REF(on_enter)
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/landmine/proc/blow(mob/living/stepper)
	SEND_SIGNAL(src, COMSIG_MINE_TRIGGERED, stepper)
	explosion(loc, heavy_impact_range=heavy_impact, light_impact_range=light_impact)
	qdel(src)

/obj/structure/landmine/update_icon()
	. = ..()
	overlays.Cut()
	var/image/I = image(icon=src.icon, icon_state="mine_glow")
	I.plane = ABOVE_FRILL_PLANE_BLOOM
	overlays += I
	if(!can_be_armed)
		overlays.Cut()
		icon_state = "mine_disarmed"

/obj/structure/landmine/wrench_act(mob/living/user, obj/item/tool)
	if(can_be_armed)
		to_chat(user, "Disarm mine with wirecutters!")
		return
	var/doing = FALSE
	if(doing)
		to_chat(user, "You already wrenching landmine")
		return
	doing = TRUE
	if(do_after(user,50))
		new /obj/item/landmine(loc, src.type)
		qdel(src)
	doing = FALSE

/obj/structure/landmine/wirecutter_act(mob/living/user, obj/item/tool)
	if(!can_be_armed)
		return
	user.visible_message("<span class='danger'>[user] begins to disarm the landmine...</span>")
	if(do_after(user,50))
		armed = FALSE
		can_be_armed = FALSE
		to_chat(user, "You successfully disarm the [src]")
		playsound(src, 'sound/items/Wirecutter.ogg', 100, FALSE)
		update_icon()
		stepper = null
		return

/obj/structure/landmine/proc/on_enter(datum/source, atom/movable/leaving, direction)
	if(isliving(leaving))
		var/mob/living/M = leaving
		if(istype(M, /mob/living/simple_animal/mouse) || istype(M, /mob/living/basic/cockroach))
			return
		if(!armed && can_be_armed)
			to_chat(M, "<span class='danger'>You hear a sickening click!</span>")
			playsound(src, 'modular_zebtic/code/modules/is12_mines/sounds/mine_arm.ogg', 100, FALSE)
			armed = TRUE
			stepper = M

/obj/structure/landmine/proc/on_exit(datum/source, atom/movable/leaving, direction)
	if(isliving(leaving))
		var/mob/living/M = leaving
		if(armed)
			if(M == stepper)
				if(prob(reject_chance))
					to_chat(M, "<span class='danger'>Nothing happend. The mine didn't work!</span>")
					armed = FALSE
					stepper = null
					return
				blow(stepper)

/obj/structure/landmine/Destroy()
	. = ..()

/obj/structure/landmine/old
	desc = "If you step on this you'll probably fucking die. It's covered with a thick layer of dust"

	reject_chance = 30

/obj/structure/landmine/defective
	desc = "If you step on this you'll probably fucking die. It looks odd"

	reject_chance = 50

