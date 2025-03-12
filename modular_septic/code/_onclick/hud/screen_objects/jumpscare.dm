//PM9 jumpscare holder
/atom/movable/screen/fullscreen/jumpscare
	icon = 'modular_septic/icons/hud/jumpscare.dmi'
	icon_state = "trumadness"
	base_icon_state = "trumadness"
	plane = FULLSCREEN_PLANE
	layer = JUMPSCARE_LAYER
	show_when_dead = TRUE
	alpha = 0
	/// How many jumpscare sprites we have
	var/jumpscare_amount = 23
	/// Jumpscare sounds we have
	var/list/jumpscare_sounds = list(
		'modular_septic/sound/insanity/trumadness/atumalaka.ogg',
		'modular_septic/sound/insanity/trumadness/bitch.ogg',
		'modular_septic/sound/insanity/trumadness/turi.ogg',
		'modular_septic/sound/insanity/trumadness/darknessimprisoningme.ogg',
		'modular_septic/sound/insanity/trumadness/weegee.ogg',
		'modular_septic/sound/insanity/trumadness/halflifezombie.ogg',
		'modular_septic/sound/insanity/trumadness/badtothebone.ogg',
		'modular_septic/sound/insanity/trumadness/trickortreating.ogg',
		'modular_septic/sound/insanity/trumadness/boywhatthehellboy.ogg',
		'modular_septic/sound/insanity/trumadness/scaryvampire.ogg',
		'modular_septic/sound/insanity/trumadness/leon_moan.ogg',
		'modular_septic/sound/insanity/trumadness/joker_laugh.ogg',
		'modular_septic/sound/insanity/trumadness/secretside.ogg',
		'modular_septic/sound/insanity/trumadness/tlad.ogg',
		'modular_septic/sound/insanity/trumadness/cantbreathe.ogg',
		'modular_septic/sound/insanity/trumadness/slopper.ogg',
		'modular_septic/sound/insanity/trumadness/insideyourhome.ogg',
		'modular_septic/sound/insanity/trumadness/diezduendesreales.ogg',
	)

/atom/movable/screen/fullscreen/jumpscare/proc/flash_scare(mob/user, scare_sound = pick(jumpscare_sounds))
	icon_state = "[base_icon_state][rand(1, jumpscare_amount)]"
	alpha = 255
	add_filter("blur", 1, gauss_blur_filter(3))
	transition_filter("blur", 0.6 SECONDS, gauss_blur_filter(0))
	animate(src, alpha = 0, time = 1 SECONDS, easing = EASE_IN|BOUNCE_EASING)
	if(scare_sound)
		user.playsound_local(scare_sound, scare_sound, vol = 200, vary = FALSE)
