/obj/item/reagent_containers/food/drinks/mug/tea/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/mug/coco/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/coke
	name = "Conk"
	desc = "Sippy sippy on that good shit!\n\
			<span class='warning'>WARNING: Do not shake!</span>"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "cocaine_cola"
	list_reagents = list(/datum/reagent/consumable/coke = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/coke/open_soda(mob/user)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/cum, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi
	name = "Shlorp Bepis"
	desc = "A fitting name for a drink, and your serious character!"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "pepsi"
	list_reagents = list(/datum/reagent/consumable/pepsi = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/open_soda(mob/user)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/cum, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/diet
	name = "Diet Shlorp Bepis"
	desc = "Replacing the sugar in the original drink with a concentrated \"Baphomet\" essence.\n\
			<span class='dead'>WARNING: Excessive consumption of this product is linked with:\n\
			Depression, anhedonia, autism, gynecomastia, tumor growth around the pubic region, erectile dysfunction, \
			premature ejaculation, retrograde ejaculation, wet dreams, infertility, elevated libido, compulsive sexual behavior, \
			post-coital tristesse, dyspareunia, vaginismus, vulvodynia, vulvar vestibulitis, peyronie's disease, priapism, \
			pelvic floor dysfunctions, urinary incontinence, pelvic organ prolapse, menopause, male periods.</span>"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "cocaine_cola_diet"
	list_reagents = list(/datum/reagent/consumable/pepsi/diet = 30)
	foodtype = MEAT

/obj/item/reagent_containers/food/drinks/soda_cans/mug
	name = "Mug Root Beer"
	desc = "DUDE, THAT'S FUCKING HELLA MUG MOMENT DUDE!"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "mug"
	list_reagents = list(/datum/reagent/consumable/mug = 30)
	foodtype = SUGAR
