/obj/item/reagent_containers/food/drinks/soda_cans
	drop_sound = 'modular_septic/sound/effects/soda.wav'

/obj/item/reagent_containers/food/drinks/mug/tea/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/mug/coco/Initialize()
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/coke
	name = "Coca Cola"
	desc = "An abandoned beverage. Only found deep within the Abandoned Warehouse, could be useful for <b>bartering.</b>"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "coke"
	list_reagents = list(/datum/reagent/consumable/coke = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/coke/empty
	list_reagents = list()
	popped_open = TRUE
	desc = "Well, it could have been tasty I guess."
	name = "empty can"

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi
	name = "Pepsi"
	desc = "A plentiful soda found within the surface areas of the Abandoned Warehouse."
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "pepsi"
	list_reagents = list(/datum/reagent/consumable/pepsi = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/open_soda(mob/user)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/cum, 5, 3 MINUTES)

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/empty
	name = "empty can"
	list_reagents = list()
	popped_open = TRUE
	desc = "Well, it could have been tasty I guess."

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/diet
	name = "Diet Pepsi"
	desc = "A refreshing cola that tastes like water and doesn't offer any benefits."
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "pepsi_diet"
	list_reagents = list(/datum/reagent/consumable/pepsi/diet = 30)
	foodtype = MEAT

/obj/item/reagent_containers/food/drinks/soda_cans/pepsi/diet/empty
	name = "empty can"
	list_reagents = list()
	popped_open = TRUE
	desc = "Well, it could have been tasty I guess."

/obj/item/reagent_containers/food/drinks/soda_cans/mug
	name = "Mug Root Beer"
	desc = "DUDE, THAT'S FUCKING HELLA MUG MOMENT DUDE!"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "mug"
	list_reagents = list(/datum/reagent/consumable/mug = 30)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/mug/empty
	name = "empty can"
	list_reagents = list()
	popped_open = TRUE
	desc = "Well, it could have been tasty I guess."

/obj/item/reagent_containers/food/drinks/soda_cans/lean
	name = "Lean"
	desc = "doubleyou"
	icon = 'modular_septic/icons/obj/items/soder.dmi'
	icon_state = "lean"
	list_reagents = list(/datum/reagent/drug/lean = 30)
	foodtype = ALCOHOL
