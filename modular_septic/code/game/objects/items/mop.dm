/obj/item/mop
	carry_weight = 1.5 KILOGRAMS
	mopcap = 50

/obj/item/mop/proc/attack_on_liquids_turf(obj/item/mop/the_mop, turf/T, mob/user, atom/movable/liquid/liquids)
	var/free_space = the_mop.reagents.maximum_volume - the_mop.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_warning("Тряпка на швабре измокла!"))
		return TRUE
	var/datum/reagents/temporary_holder = liquids.take_reagents_flat(free_space)
	temporary_holder.trans_to(the_mop.reagents, temporary_holder.total_volume)
	to_chat(user, span_notice("Я намокнул тряпку на швабре."))
	qdel(temporary_holder)
	user.changeNext_move(attack_delay)
	return TRUE

/obj/item/mop/advanced
	mopcap = 100
