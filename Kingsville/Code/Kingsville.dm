/*
	These are simple defaults for your project.
 */

world
	fps = 25		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default

	view = 7		// show up to 6 tiles outward from center (13x13 view)


// Make objects move 8 pixels per tick when walking
turf
	start
		icon = 'icons/start.dmi'
		invisibility = 1

mob

	icon = 'icons/mob/human.dmi'
	icon_state = "skeleton_s"

	Login()
		loc = locate(/turf/start)
		world << "Welcome to Kingsville!"
		..()




turf/floor
	Ground
		name = "Ground"
		icon = 'icons/turf/floors.dmi'
turf/walls
	Walls
		name = "Walls"
		icon = 'icons/turf/walls.dmi'
		density = 1
		opacity = 1

obj/lantern
	Lantern
		name = "Lantern"
		icon = 'icons/obj/Lantern.dmi'
		icon_state = "lantern 1"
		luminosity = 4

	Unlit_Lantern
		name = "Unlit_Lantern"
		icon = 'icons/obj/Lantern.dmi'
		icon_state = "lantern 2"
		luminosity = 0

obj/smithing
	Anvil
		name = "Anvil"
		icon = 'icons/obj/smithing.dmi'
		icon_state = "anvil"
		density = 1

obj/doors
	Iron_Gate
		name = "Iron Gate"
		icon = 'icons/obj/doors/Irongate.dmi'
		density = 1

/turf/simulated/floor/grass
	name = "Grass patch"
	icon_state = "grass1"
	floor_tile = new/obj/item/stack/tile/grass

	New()
		floor_tile.New() //I guess New() isn't ran on objects spawned without the definition of a turf to house them, ah well.
		icon_state = "grass[pick("1","2","3","4")]"
		..()
		spawn(4)
			if(src)
				update_icon()
				for(var/direction in cardinal)
					if(istype(get_step(src,direction),/turf/simulated/floor))
						var/turf/simulated/floor/FF = get_step(src,direction)
						FF.update_icon() //so siding get updated properly