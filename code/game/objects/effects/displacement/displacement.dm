/obj/effect/abstract/displacement
	icon = 'icons/effects/displacement/displacement.dmi'
	var/filter_name = "displacement"
	var/atom/movable/parent = null

/obj/effect/abstract/displacement/Initialize(mapload, atom/movable/target)
	. = ..()
	parent = target
	render_target = "*[filter_name][ref(src)]" // * at the start makes it invisible
	flick(icon, src)
	target.add_filter(filter_name, 2, displacement_map_filter(render_source=render_target))

/obj/effect/abstract/displacement/Destroy()
	. = ..()
	if(!QDELETED(parent))
		parent.remove_filter(filter_name)


/obj/effect/abstract/displacement/temp
	var/duration = 0
	var/timerid = null

/obj/effect/abstract/displacement/temp/Initialize(mapload, atom/movable/target)
	. = ..(mapload, target)
	if(duration)
		timerid = QDEL_IN(src, duration)

/obj/effect/abstract/displacement/temp/Destroy()
	. = ..()
	if(timerid)
		deltimer(timerid)
