/obj/item/landmine
	name = "landmine"
	desc = "Use it to place a landmine in front of you. Be careful..."
	icon = 'modular_zebtic/code/modules/is12_mines/sprites/warfare.dmi'
	icon_state = "mine_item"
	var/open = FALSE
	var/can_be_armed = TRUE
	var/explode = FALSE

	var/blow_timer_id

/obj/item/landmine/Initialize(mapload)
	. = ..()
	wires = new /datum/wires/landmine_item(src)

/obj/item/landmine/attack_self(var/mob/user)
	if(open)
		to_chat(user, "Panel of mine is open!")
		return
	if(explode)
		to_chat(user, "Mine is going to explode!")
		return
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
			new /obj/structure/landmine(T, can_be_armed)


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

	var/open = FALSE
	var/explode = FALSE

	var/blow_timer_id

/obj/structure/landmine/Initialize(mapload, )
	. = ..()
	wires = new /datum/wires/vending(src)
	update_icon()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		COMSIG_ATOM_ENTERED = PROC_REF(on_enter)
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/landmine/proc/blow()
	AddComponent(/datum/component/pellet_cloud, projectile_type=/obj/projectile/bullet/shrapnel, magnitude=4)
	explosion(loc, 2, 2, 1, 1)
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


/obj/structure/landmine/attackby(obj/item/W as obj, mob/user as mob)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(istype(W, /obj/item/wirecutters))
		if(!can_be_armed)
			return
		H.visible_message("<span class='danger'>[H] begins to disarm the landmine...</span>")
		if(do_after(user,100))
			armed = FALSE
			can_be_armed = FALSE
			to_chat(H, "You successfully disarm the [src]")
			playsound(src, 'sound/items/Wirecutter.ogg', 100, FALSE)
			update_icon()
			stepper = null
			return
		blow()
	if(istype(W, /obj/item/wrench))
		if(can_be_armed)
			to_chat(H, "Disarm mine with wirecutters!")
			return
		new /obj/item/landmine(loc)
		qdel(src)
		return

/obj/structure/landmine/screwdriver_act(mob/living/user, obj/item/tool)
	open = !open
	to_chat(user, "You open panel of [src]")
	playsound(src, 'sound/items/screwdriver.ogg', 100, FALSE)


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
				blow()
