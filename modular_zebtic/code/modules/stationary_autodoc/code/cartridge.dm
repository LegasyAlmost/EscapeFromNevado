#define USING_INFINITE 10000
/obj/item/reagent_containers/cartridge
	name = "Cartridge"
	desc = "Used in autodocs"
	icon = 'modular_zebtic/code/modules/stationary_autodoc/icons/autodoc.dmi'
	icon_state = "cartridge"
	volume = 100
	possible_transfer_amounts = null
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 15,
	/datum/reagent/medicine/sal_acid = 15,
	/datum/reagent/medicine/oxandrolone = 15,
	/datum/reagent/medicine/epinephrine = 15,
	/datum/reagent/medicine/omnizine = 15,
	)
	var/using_amount = 2

/obj/item/reagent_containers/cartridge/update_icon()
	. = ..()
	if(using_amount == 0)
		icon_state+="_used"

/obj/item/reagent_containers/cartridge/infinite
	using_amount = USING_INFINITE
