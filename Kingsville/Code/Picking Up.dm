/atom/proc/Adjacent(var/atom/neighbor) // basic inheritance, unused
	return 0




obj/Click(Adjacent(usr))

      set src in usr.loc
      loc = usr



obj/verb
	drop()
		set src in usr  //actually this is the default
		loc = usr.loc





