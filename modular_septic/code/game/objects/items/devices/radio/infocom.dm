#define BEEPING 1
#define FAST_BEEPING 2

/obj/machinery/infocom
	name = "Infocom"
	desc = "An information communication machine, a very creative name! It's a device used to dispense information when used, how do you know that? I don't fucking know, click on it to learn how."
	icon = 'modular_septic/icons/obj/machinery/intercom.dmi'
	icon_state = "infocom"
	base_icon_state = "infocom"
	plane = GAME_PLANE_UPPER
	layer = WALL_OBJ_LAYER
	density = FALSE
	var/radiotune = list('modular_septic/sound/efn/infocom1.ogg', 'modular_septic/sound/efn/infocom2.ogg', 'modular_septic/sound/efn/infocom3.ogg', 'modular_septic/sound/efn/infocom4.ogg')
	var/virused = FALSE
	var/tip_sound = 'modular_septic/sound/efn/infocom_trigger.ogg'
	var/untip_sound = 'modular_septic/sound/efn/infocom_untrigger.ogg'
	var/list/voice_lines = list("This place is damp and dirty, many of the rooms don't make sense but I can help you.", "Find more Infocoms next to things you're curious about, they say different things.", "It'll tell you the location name and what you can find there.", \
	"Avoid everyone! Or kill them, they're out to get your loot and your life.")
	var/tipped = FALSE
	var/voice_delay = 3 SECONDS
	var/cooldown_delay = 1 SECONDS
	var/speak_prob = 80
	var/state
	var/choice = null

/obj/machinery/infocom/tutorial/Initialize(mapload)
	. = ..()
	voice_lines = list("Oh good, you're alive.", "Whoa there easy buddy, get your bearings, it's not easy being born is it.", "Looks like cyatoreplicator must have gotten broken again for the machine to spit another one of you out.")
	choice = div_infobox("<span class='notice'><a href='?src=[REF(src)];action=cytoreplicator'>Cytoreplicator?</a></span>")


/obj/machinery/infocom/tutorial/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/tutorial/Topic(href, href_list, hsrc)
	..()
	switch(href_list["action"])
		if("cytoreplicator")
			if(tipped)
				return
			voice_lines = list("Yeah, cytoreplicator.", "When shit like that breaks an inborn like you gets produced and spat out here.", "Don't worry about it.", "Here, pick up that gun off the table and load it up. Click on it with an empty hand, and then press X to swap to your other hand.", "After that, click on the magazine on the table to pick it up in your other hand. Easy right?")
			choice = div_infobox("<span class='notice'><a href='?src=[REF(src)];action=nowwhat'>Now what?</a></span>")
			playsound(src, tip_sound, 65, FALSE)
			tipped = TRUE
			update_appearance(UPDATE_ICON)
			INVOKE_ASYNC(src, .proc/start_spitting_fax, usr)

		if("nowwhat")
			if(tipped)
				return
			voice_lines = list("Click on the gun with your hand that has the magazine loaded.", "You're not done yet though. You still gotta chamber the gun. Press Z to chamber the round.", "Easy as pie. Now you're ready to kill.", "Press E to put the gun in your belt slot, and head out the door, down, and to the east. There's another comm there I'll continue there.")
			choice = null
			playsound(src, tip_sound, 65, FALSE)
			tipped = TRUE
			update_appearance(UPDATE_ICON)
			INVOKE_ASYNC(src, .proc/start_spitting_fax, usr)

		if("outofammo")
			if(tipped)
				return
			voice_lines = list("See the red machine on the wall? That's Verina's Heartbeat.", "The godforesaken factory is constantly spitting out ammo and the likes through Verina's bloodestream, and it stocks these. They're all over the underbelly.", "Click drag your gun into your other hand to unload your mag, then click the machine it with your mag in your active hand, and it should restock your mag.", "Once you've done that, reload your gun, and kill that creacher.")
			choice = div_infobox("<span class='notice'><a href='?src=[REF(src)];action=outofammo'>I'm out of ammo...</a></span>\n<span class='notice'><a href='?src=[REF(src)];action=killedit'>I killed it now what?</a></span>")
			playsound(src, tip_sound, 65, FALSE)
			tipped = TRUE
			update_appearance(UPDATE_ICON)
			INVOKE_ASYNC(src, .proc/start_spitting_fax, usr)


		if("killedit")
			if(tipped)
				return
			var/mob/living/simple_animal/sloth/creacher/G = locate() in get_area(src)
			if(G.health > 0)
				playsound(src, radiotune, 40, FALSE)
				say("No you didn't.")
				choice = null
				playsound(src, tip_sound, 65, FALSE)
				tipped = TRUE
				update_appearance(UPDATE_ICON)
				INVOKE_ASYNC(src, .proc/start_spitting_fax, usr)
				voice_lines = list("Make sure your safety is off.", "Once you've done that, go to the east, and shoot the little creacher. I put him there for you to target practice on.")
				choice = div_infobox("<span class='notice'><a href='?src=[REF(src)];action=outofammo'>I'm out of ammo...</a></span>\n<span class='notice'><a href='?src=[REF(src)];action=killedit'>I killed it now what?</a></span>")
				return
			voice_lines = list("Good. You're a natural inborn killer. Grab the other mag and put it in your satchel.", "Pick it up in an empty hand, and then click on your satchel.", "Click on the satchel with an empty hand to open it up.", "You can fit whatever you got space for in your satchel. Shift Right Click on an item in your hand to change how it's arranged.", "Your inventory is not permanent, you can take your satchel off by click dragging it onto an empty hand if you want.", "Don't lose it now.", "Head down south to the purple glowing squares. I'm gonna send you into the factory proper to fix the cytoreplicator.")
			choice = null
			playsound(src, tip_sound, 65, FALSE)
			tipped = TRUE
			update_appearance(UPDATE_ICON)
			INVOKE_ASYNC(src, .proc/start_spitting_fax, usr)

/obj/machinery/infocom/tutorial/two
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/tutorial/two/Initialize(mapload)
	. = ..()
	voice_lines = list("Alright, now that you got your gun loaded up, you're probably eager to shoot it.", "Sick bastards you inborns are huh.", "Click on your pistol to put it from your belt into your active hand.", "If it's already in your hand and you click on it, you'll rack a shell out of it. Don't do that unless you want to pick it up again.", "Right click on your gun to toggle the safety off.", "Once you've done that, go to the east, and shoot the little creacher. I put him there for you to target practice on.")
	choice = div_infobox("<span class='notice'><a href='?src=[REF(src)];action=outofammo'>I'm out of ammo...</a></span>\n<span class='notice'><a href='?src=[REF(src)];action=killedit'>I killed it now what?</a></span>")


/obj/machinery/infocom/combat
	name = "Evil Infocom"
	desc = "An information communication machine, specifically used for relaying calm and concise information about combat."
	icon_state = "infocom_evil"
	base_icon_state = "infocom_evil"
	radiotune = list('modular_septic/sound/efn/evilcom1.ogg', 'modular_septic/sound/efn/evilcom2.ogg', 'modular_septic/sound/efn/evilcom3.ogg')
	voice_lines = list("NO-ONE BUT YOU CAN ESCAPE WILLINGLY.", "TAKE A GUN, TAKE SOMETHING HEAVY", "DEFEND YOURSELF AT ALL COSTS, KILL EVERYONE IN YOUR WAY", "DON'T THINK, SHOOT.")
	voice_delay = 2.5 SECONDS
	speak_prob = 100

/obj/machinery/infocom/combat/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/combat/east
	dir = WEST
	pixel_x = 12

/obj/machinery/infocom/combat/west
	dir = EAST
	pixel_x = -12

/obj/machinery/infocom/proc/set_hacking()
	return new /datum/hacking/infocom(src)

/obj/machinery/infocom/proc/spit_facts()
	if(prob(speak_prob))
		playsound(src, radiotune, 40, FALSE)

/obj/machinery/infocom/Initialize(mapload)
	. = ..()
	hacking = set_hacking()
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/update_overlays()
	. = ..()
	switch(state)
		if(BEEPING)
			. += "[base_icon_state]_blipper"
		if(FAST_BEEPING)
			. += "[base_icon_state]_blipper_fast"
	if(!tipped)
		. += "[icon_state]_beeper"

/obj/machinery/infocom/attackby(obj/item/W, mob/living/user, params)
	var/list/modifiers = params2list(params)
	if(is_wire_tool(W) && !IS_HARM_INTENT(user, modifiers))
		attempt_hacking_interaction(user)
		return
	return ..()

/obj/machinery/infocom/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(tipped)
		var/explicit = pick("fucking", "goddamn", "goshdarn", "fricking")
		to_chat(user, span_notice("I need to let it [explicit] speak."))
		return
	playsound(src, tip_sound, 65, FALSE)
	tipped = TRUE
	update_appearance(UPDATE_ICON)
	INVOKE_ASYNC(src, .proc/start_spitting_fax, user, modifiers)

/obj/machinery/infocom/proc/start_spitting_fax(mob/living/user, list/modifiers)
	beep()
	sleep(9)
	for(var/line in voice_lines)
		spit_facts()
		say(line)
		sound_hint()
		sleep(voice_delay)
	if(choice)
		to_chat(user, choice)
	sleep(cooldown_delay)
	tipped = FALSE
	playsound(src, untip_sound, 45, FALSE)
	beep_fast()
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/proc/beep()
	state = BEEPING
	update_appearance(UPDATE_ICON)
	sleep(6)
	state = null
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/proc/beep_fast()
	state = FAST_BEEPING
	update_appearance(UPDATE_ICON)
	sleep(4)
	state = null
	update_appearance(UPDATE_ICON)

/obj/machinery/infocom/north
	dir = SOUTH
	pixel_y = 33

/obj/machinery/infocom/east
	dir = WEST
	pixel_x = 12

/obj/machinery/infocom/west
	dir = EAST
	pixel_x = -12

#undef BEEPING
#undef FAST_BEEPING
