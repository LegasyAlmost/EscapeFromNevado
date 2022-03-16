//Ghosts will be reworked, but for now this will do
/mob/dead/observer
	var/can_rest = FALSE

/mob/dead/observer/Initialize()
	. = ..()
	add_verb(src, /mob/dead/observer/proc/second_chance)

/mob/dead/observer/proc/second_chance()
	set name = "Reincarnation"
	set desc = "Live another life."
	set category = "Ghost"

	if(!can_rest)
		to_chat(src, span_warning("My body hasn't been buried or cremated."))
		return

	var/mob/dead/new_player/NP = new()
	NP.key = src.key
	qdel(src)

//-Matt edit
//Ghosts are fucking stupid and I hate them. I'll figure out another way to let people respawn.
/mob/living/verb/ghost()
	set category = "OOC"
	set name = "Ghost"
	set desc = "Relinquish your life and enter the land of the dead."

	if(stat != DEAD)
		succumb()
	if(stat == DEAD)
		if(check_rights(R_ADMIN))//Only admins are allowed to ghost. Players can go fuck themselves.
			ghostize(TRUE)
			return TRUE
		return FALSE
	return TRUE
