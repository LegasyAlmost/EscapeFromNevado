#define ACTIVATING_TIME 25 SECONDS

/obj/machinery/computer/shuttle_console
	name = "Hacking console"
	desc = "A console used to hack control of space shuttles"
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	flags_1 = NODECONSTRUCT_1

	var/ID_amount = 0
	var/shuttle_timerid
	var/datum/looping_sound

/obj/machinery/computer/shuttle_console/Initialize(mapload)
	. = ..()

/obj/machinery/computer/shuttle_console/attack_hand(mob/living/user, list/modifiers)
	if(ID_amount >= 4)
		activate(user)
	else to_chat(user, "You need [4 - ID_amount] more ID")

/obj/machinery/computer/shuttle_console/attackby(obj/item/weapon, mob/user, params)
	if(istype(weapon, /obj/item/shuttle_card))
		ID_amount++
		qdel(weapon)
		playsound(src, 'modular_zebtic/code/modules/shuttle_items/sounds/floppy_disk.ogg', 90, TRUE)
		to_chat(user, "You put ID in the console. Now here is [ID_amount] ID inside.")

/obj/machinery/computer/shuttle_console/proc/activate(mob/user)
	if(SSshuttle.emergency.mode != SHUTTLE_IDLE)
		return
	to_chat(user, "You start activating the hacking protocol.")
	user.changeNext_move(5 SECONDS)
	playsound(src, 'modular_zebtic/code/modules/shuttle_items/sounds/console_typing.ogg', 90, TRUE)
	if(do_after(user, ACTIVATING_TIME, src))
		call_shuttle()

/obj/machinery/computer/shuttle_console/proc/call_shuttle()
	SSshuttle.emergency.request(null, null, redAlert = 1)
	SSshuttle.emergencyNoRecall = TRUE
	spawn(2 SECONDS)
		sound_to_playing_players('modular_zebtic/code/modules/shuttle_items/sounds/alarm.ogg')
	ID_amount = 0

#undef ACTIVATING_TIME
