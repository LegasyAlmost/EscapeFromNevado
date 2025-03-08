/obj/machinery/vending/healther
	name = "GodForBlooded"
	desc = "God. For. Blood. Бартерный автомат, выдающий медицину за что-то... \n\
	<div class='infobox'> \
	П Р И Н И М А Ю: 1 КНИГА CCP - П О Л У Ч И Ш Ь = АПТЕЧКА МОРАНГО \n\
	П Р И Н И М А Ю: 1 экран LSD - П О Л У Ч И Ш Ь = АПТЕЧКА ПЕРВОЙ ПОМОЩИ \n\
	П Р И Н И М А Ю: 1 ПЕЧЕНЬ - П О Л У Ч И Ш Ь = СКАЛЬПЕЛЬ \n\
	П Р И Н И М А Ю: 1 ЛЕВАЯ РУКА И 1 ПРАВАЯ РУКА - П О Л У Ч И Ш Ь = ИНЪЕКЦИЯ BLACKTAR \n\
	П Р И Н И М А Ю: 1 СЕРДЦЕ - П О Л У Ч И Ш Ь = 1 СЫВОРОТКУ ВЫЖИВАНИЯ \
    </div>"
	density = FALSE
	onstation = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	slogan_delay = 600
	icon_state = "tiktok"
	base_icon_state = "tiktok"
	icon = 'modular_septic/icons/obj/machinery/vending.dmi'
	product_slogans = "Idiot. FUCKING IDIOT!; Your birth certicificate is an APOLOGY LEGGER from the CLINIC; Shut up, retard.; The King is Coming!!; We are in the last moments of the end of days.; Prophesised to happen before the return of Jesus; The Marshmellow Time was wrong then and it; Salvation from God is a Gift.; The Ultimate sacrifice for all of our sins.; Ultimate Metaphysics: Divine Unity, or the Conjugate Whole"
	products = list(
		/obj/item/storage/backpack/satchel/itobe = 40,
		/obj/item/clothing/under/itobe = 40,
		/obj/item/clothing/shoes/jackboots = 40,
		/obj/item/clothing/gloves/color/black = 40,
		/obj/item/clothing/suit/armor/vest/alt/discrete = 40,
		/obj/item/wrench = 45,
	)
	var/list/tiktoklines = list('modular_septic/sound/effects/singer1.wav', 'modular_septic/sound/effects/singer2.wav')
	var/refuse_sound_cooldown_duration = 1 SECONDS
	var/barfsound = 'modular_septic/sound/emotes/vomit.wav'
	var/crushersound = list('modular_septic/sound/effects/crusher1.wav', 'modular_septic/sound/effects/crusher2.wav', 'modular_septic/sound/effects/crusher3.wav')
	COOLDOWN_DECLARE(refuse_cooldown)

/obj/machinery/vending/healther/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!GLOB.healther_inputs[I.type])
		if(COOLDOWN_FINISHED(src, refuse_cooldown))
			sound_hint()
			playsound(src, 'modular_septic/sound/effects/clunk.wav', 60, vary = FALSE)
			COOLDOWN_START(src, refuse_cooldown, refuse_sound_cooldown_duration)
		return
	if(user.transferItemToLoc(I, src))
		sound_hint()
		playsound(src, crushersound, 70, vary = FALSE)
		INVOKE_ASYNC(src, PROC_REF(crushing_animation))
		check_healther()

/obj/machinery/vending/healther/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(!isliving(usr) || !usr.Adjacent(src) || usr.incapacitated())
		return
	if(over == loc)
		vomit_items()

/obj/machinery/vending/healther/process(delta_time)
	if(machine_stat & BROKEN | NOPOWER)
		return PROCESS_KILL
	if(!active)
		return

	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--

	//Pitch to the people! Really sell it!
	if((last_slogan + slogan_delay <= world.time) && (LAZYLEN(slogan_list) > 0) && !shut_up && DT_PROB(2.5, delta_time))
		var/slogan = pick(slogan_list)
		flick("[base_icon_state]-speak", src)
		playsound(src, tiktoklines, 70, vary = FALSE)
		speak(slogan)
		last_slogan = world.time

/obj/machinery/vending/healther/proc/crushing_animation()
	add_overlay("[base_icon_state]-eat")
	sleep(11)
	cut_overlay("[base_icon_state]-eat")

/obj/machinery/vending/healther/proc/check_healther()
	var/datum/healther_recipe/healther_recipe
	//loop through every bartering recipe and attempt to execute it
	for(var/recipe_type as anything in GLOB.healther_recipes)
		healther_recipe = GLOB.healther_recipes[recipe_type]
		//associated list, every item we end up needing to use in the recipe and the associated input path type
		var/list/valid_inputs = list()
		//associated list, every input path type associated with the amount we have
		var/list/input_counter = list()
		var/recipe_failed = FALSE
		for(var/input_type in healther_recipe.inputs)
			var/amount_needed = healther_recipe.inputs[input_type]
			for(var/obj/item/thing_inside_us in contents)
				if(input_counter[input_type] >= amount_needed)
					break
				if(istype(thing_inside_us, input_type))
					//stack shitcode very cool
					valid_inputs[thing_inside_us] = input_type
					if(!input_counter[input_type])
						input_counter[input_type] = 0
					if(isstack(thing_inside_us))
						var/obj/item/stack/stack_item = thing_inside_us
						input_counter[input_type] = min(amount_needed, input_counter[input_type] + stack_item.amount)
					else
						input_counter[input_type] = input_counter[input_type] + 1
			if(input_counter[input_type] < amount_needed)
				recipe_failed = TRUE
				break
		if(recipe_failed)
			continue
		for(var/obj/item/input as anything in valid_inputs)
			var/input_type = valid_inputs[input]
			var/amount_yoink = input_counter[input_type]
			if(isstack(input))
				var/obj/item/stack/stack_input = input
				var/amount_yoinked = min(stack_input.amount, amount_yoink)
				stack_input.use(amount_yoinked)
				input_counter[input_type] -= amount_yoinked
			else
				input_counter[input_type] -= 1
				qdel(input)
		for(var/output in healther_recipe.outputs)
			var/output_amount = healther_recipe.outputs[output]
			for(var/i in 1 to output_amount)
				new output(loc)
		playsound(src, 'modular_septic/sound/effects/ring.wav', 90, TRUE)
		speak("Take from me.")

/obj/machinery/vending/healther/proc/vomit_items()
	//remis please add a vomiting blorf sound right below this comment
	playsound(src, barfsound, 65, FALSE)
	for(var/obj/item/vomited in src)
		vomited.forceMove(loc)

//	remove_overlay("[base_icon_state]-eat")
/obj/machinery/vending/healther/directional/north
	dir = SOUTH
	pixel_y = 32

/obj/machinery/vending/healther/directional/south
	dir = NORTH
	pixel_y = -32

/obj/machinery/vending/healther/directional/east
	dir = WEST
	pixel_x = 32

/obj/machinery/vending/healther/directional/west
	dir = EAST
	pixel_x = -32

