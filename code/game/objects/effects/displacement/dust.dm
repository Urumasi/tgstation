/obj/effect/abstract/displacement/temp/dust
	icon_state = "dust2"
	filter_name = "dusting_anim"
	duration = 14

/obj/effect/abstract/displacement/temp/dust/Initialize(mapload, atom/movable/target)
	. = ..(mapload, target)
	animate(target, alpha=0, time=2 SECONDS, easing=(EASE_IN | SINE_EASING))

