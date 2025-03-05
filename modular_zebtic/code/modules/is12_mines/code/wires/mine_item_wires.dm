/datum/wires/landmine
	holder_type = /obj/item/landmine
	proper_name = "landmine"

/datum/wires/vending/New(atom/holder)
	wires = list(
		WIRE_ARMING, WIRE_EXPLODE
	)
	add_duds(2)
	..()

/datum/wires/vending/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/item/landmine/M = holder
	if(M.open)
		return TRUE

/datum/wires/vending/get_status()
	var/obj/item/landmine/M = holder
	var/list/status = list()
	status += "The green light is [V.can_be_armed ? "on" : "off"]."
	status += "The red light is [V.explode ? "blinking" : "off"]."
	return status

/datum/wires/vending/on_pulse(wire)
	var/obj/item/landmine/M = holder
	switch(wire)
		if(WIRE_ARMING)
			M.can_be_armed = !M.can_be_armed
		if(WIRE_EXPLODE)
			if(M.explode = TRUE)
				return
			M.explode = TRUE
			M.blow_timer = addtimer(CALLBACK(holder, PROC_REF(blow)), 5 SECONDS, TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_DELETE_ME)

/datum/wires/vending/on_cut(wire, mend)
	var/obj/item/landmine/M = holder
	switch(wire)
		if(WIRE_ARMING)
			M.can_be_armed = !M.can_be_armed
		if(WIRE_EXPLODE)
			if(M.explode == TRUE)
				if(mend)
					if(M.blow_timer_id)
						deltimer(M.blow_timer_id)
					M.explode = FALSE
				else
					return
			M.explode = TRUE
			M.blow()
