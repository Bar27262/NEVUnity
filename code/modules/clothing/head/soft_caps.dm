/obj/item/clothing/head/soft
	name = "cargo cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "cargosoft"
	flags = FPRINT|TABLEPASS|HEADCOVERSEYES
	item_state = "helmet"
	objcolor =  "cargo"
	var/flipped = 0
	siemens_coefficient = 0.9

	dropped()
		src.icon_state = "[objcolor]soft"
		src.flipped=0
		..()

	verb/flip()
		set category = "Object"
		set name = "Flip cap"
		set src in usr
		if(usr.canmove && !usr.stat && !usr.restrained())
			src.flipped = !src.flipped
			if(src.flipped)
				icon_state = "[objcolor]soft_flipped"
				usr << "You flip the hat backwards."
			else
				icon_state = "[objcolor]soft"
				usr << "You flip the hat back in normal position."
			usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/soft/red
	name = "red cap"
	desc = "It's a baseball hat in a tasteless red colour."
	icon_state = "redsoft"
	objcolor =  "red"

/obj/item/clothing/head/soft/blue
	name = "blue cap"
	desc = "It's a baseball hat in a tasteless blue colour."
	icon_state = "bluesoft"
	objcolor =  "blue"

/obj/item/clothing/head/soft/green
	name = "green cap"
	desc = "It's a baseball hat in a tasteless green colour."
	icon_state = "greensoft"
	objcolor =  "green"

/obj/item/clothing/head/soft/yellow
	name = "yellow cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "yellowsoft"
	objcolor =  "yellow"

/obj/item/clothing/head/soft/grey
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	objcolor =  "grey"

/obj/item/clothing/head/soft/orange
	name = "orange cap"
	desc = "It's a baseball hat in a tasteless orange colour."
	icon_state = "orangesoft"
	objcolor =  "orange"

/obj/item/clothing/head/soft/mime
	name = "white cap"
	desc = "It's a baseball hat in a tasteless white colour."
	icon_state = "mimesoft"
	objcolor =  "mime"

/obj/item/clothing/head/soft/purple
	name = "purple cap"
	desc = "It's a baseball hat in a tasteless purple colour."
	icon_state = "purplesoft"
	objcolor =  "purple"

/obj/item/clothing/head/soft/rainbow
	name = "rainbow cap"
	desc = "It's a baseball hat in a bright rainbow of colors."
	icon_state = "rainbowsoft"
	objcolor =  "rainbow"

/obj/item/clothing/head/soft/sec
	name = "security cap"
	desc = "It's baseball hat in tasteful red colour."
	icon_state = "secsoft"
	objcolor =  "sec"

/obj/item/clothing/head/soft/sec/corp
	name = "corporate security cap"
	desc = "It's baseball hat in corpotate colours."
	icon_state = "corpsoft"
	objcolor =  "corp"
