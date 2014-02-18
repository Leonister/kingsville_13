
/atom/proc/Adjacent(var/atom/neighbor) // basic inheritance, unused
	return 0


/area/Adjacent(var/atom/neighbor)
	CRASH("Call to /area/Adjacent(), unimplemented proc")



/turf/Adjacent(var/atom/neighbor, var/atom/target = null)
	var/turf/T0 = get_turf(neighbor)
	if(T0 == src)
		return 1
	if(get_dist(src,T0) > 1)
		return 0

	if(T0.x == x || T0.y == y)

		return T0.ClickCross(get_dir(T0,src), border_only = 1) && src.ClickCross(get_dir(src,T0), border_only = 1, target_atom = target)

	var/in_dir = get_dir(neighbor,src) // eg. northwest (1+8)
	var/d1 = in_dir&(in_dir-1)		// eg west		(1+8)&(8) = 8
	var/d2 = in_dir - d1			// eg north		(1+8) - 8 = 1

	for(var/d in list(d1,d2))
		if(!T0.ClickCross(d, border_only = 1))
			continue

		var/turf/T1 = get_step(T0,d)
		if(!T1 || T1.density || !T1.ClickCross(get_dir(T1,T0) & get_dir(T1,src), border_only = 0))
			continue

		if(!src.ClickCross(get_dir(src,T1), border_only = 1, target_atom = target))
			continue

		return 1
	return 0

/atom/movable/Adjacent(var/atom/neighbor)
	if(neighbor == loc) return 1
	if(!isturf(loc)) return 0
	for(var/turf/T in locs)
		if(isnull(T)) continue
		if(T.Adjacent(neighbor,src)) return 1
	return 0

/obj/item/Adjacent(var/atom/neighbor, var/recurse = 1)
	if(neighbor == loc) return 1
	if(istype(loc,/obj/item))
		if(recurse > 0)
			return loc.Adjacent(neighbor,recurse - 1)
		return 0
	return ..()

/obj/machinery/door/Adjacent(var/atom/neighbor)
	var/obj/machinery/door/firedoor/border_only/BOD = locate() in loc
	if(BOD)
		BOD.throwpass = 1
		. = ..()
		BOD.throwpass = 0
		return .
	return ..()
/turf/proc/ClickCross(var/target_dir, var/border_only, var/target_atom = null)
	for(var/obj/O in src)
		if( !O.density || O == target_atom || O.throwpass) continue
		if( O.flags&ON_BORDER)
			if( O.dir & target_dir || O.dir&(O.dir-1) )
				return 0

		else if( !border_only )
			return 0
	return 1
