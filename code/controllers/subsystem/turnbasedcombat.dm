SUBSYSTEM_DEF(turnbasedcombat)
	name = "Turn Based Combat"
	flags = SS_NO_FIRE

	var/active_combat = FALSE
	var/list/combatants = list()
	var/list/enemies = list()
	var/list/turn_order = list()


/mob
	var/active_turn = FALSE //If it's their turn or not.
	var/turnbased_active = FALSE //Stops them from moving. Also stops processing if it's not their turn.

/mob/proc/end_turnbased_turn()
	active_turn = FALSE
	SSturnbasedcombat.turn_order -= src //Their turn is over, remove them.
	SSturnbasedcombat.process_turn()//See if the round is over.
	to_chat(world, "TURN ENDS")

/datum/controller/subsystem/turnbasedcombat/proc/process_turn()
	if(!enemies.len)
		end_combat()
		return
	if(!turn_order.len)
		turn_order = shuffle(combatants) //Reshuffle the list.
		for(var/mob/M in turn_order)
			if(!M.client && M.stat == DEAD)
				turn_order -= M
		var/mob/first_up = turn_order[1]//First guy is up.
		first_up.active_turn = TRUE
	else
		turn_order = shuffle(turn_order)
		for(var/mob/M in turn_order)
			if(!M.client && M.stat == DEAD)
				turn_order -= M
		var/mob/first_up = turn_order[1]//First guy is up.
		first_up.active_turn = TRUE

/datum/controller/subsystem/turnbasedcombat/proc/end_combat()
	if(!active_combat)//We were never in combat... somehow.
		return
	for(var/mob/M in combatants)
		M.turnbased_active = FALSE
	combatants.Cut()
	enemies.Cut()
	turn_order.Cut()
	active_combat = FALSE
	to_chat(world, "COMBAT OVER")

/datum/controller/subsystem/turnbasedcombat/proc/initalize_combat(list/potential_combatants)
	if(active_combat)//We're already in combat don't do this again.
		return
	if(!potential_combatants.len)
		return
	to_chat(world, "COMBAT BEGINS")
	for(var/mob/M in potential_combatants)
		combatants |= M
		if(!M.client)//Non clients are in the enemies slot. For now.
			enemies |= M
	turn_order = shuffle(combatants) //Complete RNG who goes first. For now.
	active_combat = TRUE
	var/mob/first_up = turn_order[1]//First guy is up.
	first_up.active_turn = TRUE
	for(var/mob/MM in turn_order)
		MM.handle_turn_based()

/mob/proc/handle_turn_based()
	turnbased_active = TRUE
	if(client && active_turn)
		var/datum/action/end_turn/endTurn = new()
		endTurn.Grant(src)



/obj/structure/combat_test
	name = "combat test"
	desc = "Testing combat"
	icon = 'modular_septic/icons/obj/structures/gptdfm.dmi'
	icon_state = "child_transporter"
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	anchored = TRUE

/obj/structure/combat_test/Crossed(atom/movable/crossed_atom, oldloc)
	. = ..()
	var/list/to_kill = list()
	for(var/mob/M in view(15))
		to_kill += M
	SSturnbasedcombat.initalize_combat(to_kill)
