//Fraggots
/atom/movable/screen/fullscreen/annoying
	name = "annoying"
	icon = 'modular_septic/icons/hud/screen_chungus.dmi'
	icon_state = "annoying"
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/atom/movable/screen/fullscreen/annoying/Initialize(mapload)
	. = ..()
	animate(src, alpha = 255, time = 0, loop = -1, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 64, time = 1 SECONDS)

/atom/movable/screen/fullscreen/annoying/update_for_view(client_view)
	screen_loc = "WEST,SOUTH to EAST,NORTH"
	update_appearance()
