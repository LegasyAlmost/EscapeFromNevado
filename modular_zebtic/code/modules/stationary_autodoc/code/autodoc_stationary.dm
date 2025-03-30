#define AUTODOC_INJECT_AMOUNT 75

/obj/structure/autodoc
	name = "Autodoc"
	desc = "A healing machine"
	icon = 'modular_zebtic/code/modules/stationary_autodoc/icons/autodoc.dmi'
	icon_state = "autodoc"

	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/last_use

	var/obj/item/reagent_containers/cartridge/cartridge

/obj/structure/autodoc/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/reagent_containers/cartridge))
		if(cartridge)
			to_chat(user, ("Here is already cartridge!"))
			return
		playsound(src, 'modular_zebtic/code/modules/stationary_autodoc/sounds/cartridge_insert.ogg', 100, FALSE)
		I.forceMove(src)
		cartridge = I
		say("CARTRIDGE FOUND")

	else
		return ..()

/obj/structure/autodoc/attack_hand(mob/user, list/modifiers)
	if(!ishuman(user))
		return
	var/choice = tgui_input_list(user, "What you want?",,list("Eject cartridge", "Use autodoc"))
	switch(choice)
		if("Eject cartridge")
			eject_cartridge(user)
		if("Use autodoc")
			autodoc_use(user)


/obj/structure/autodoc/proc/eject_cartridge(mob/living/carbon/human/user)
	if(!cartridge)
		to_chat(user, ("Here is no cartridge!"))
		return
	if(istype(cartridge, /obj/item/reagent_containers/cartridge/infinite))
		to_chat(user, "You cannot take a cartridge from this machine!")
		return
	if(user.put_in_active_hand(cartridge))
		cartridge = null
	else
		to_chat(user, "You need a free hand to take cartridge!")
/obj/structure/autodoc/proc/autodoc_use(mob/living/carbon/human/user)
	if(!cartridge)
		say("ERROR 404: CARTRIDGE NOT FOUND")
		return
	if(cartridge.using_amount <= 0)
		say("ERROR 101: NOT ENOUGH CHEMICALS")
		return

	if(last_use + 15 SECONDS >= world.time)
		say("ERROR 301: CHEMICALS ARE INJECTING IN INTERNAL CHAMBER. WAIT.")
		return

	if(user.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE))
		cartridge.reagents.copy_to(user, AUTODOC_INJECT_AMOUNT)
		last_use = world.time
		cartridge.using_amount--
		cartridge.update_icon()
		say("CHEMICALS INJECTED.")
	else
		say("ERROR 201: CANNOT INJECT CHEMICALS. TRY REMOVE CLOTHES.")
		return

/obj/structure/autodoc/infinite
	cartridge = new /obj/item/reagent_containers/cartridge/infinite()
