mob
	verb
		Say(txt as text)
			world << "[usr] says,\"[txt]\" " // This makes it so when the player types "Say", it will automatically bring up quotes.

		Me(txt as text)
			world << "[usr] [txt]"
