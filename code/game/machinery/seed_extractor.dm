/obj/machinery/seed_extractor
	name = "seed extractor"
	desc = "Extracts and bags seeds from produce."
	icon = 'icons/obj/hydroponics.dmi'
	icon_state = "sextractor"
	density = 1
	anchored = 1

obj/machinery/seed_extractor/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O, /obj/item/weapon/reagent_containers/food/snacks/grown/))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/F = O
		user.drop_item()
		user << "<span class='notice'>You extract some seeds from the [F.name].</span>"
		var/seed = text2path(F.seed)
		var/t_amount = 0
		var/t_max = rand(1,4)
		while(t_amount < t_max)
			var/obj/item/seeds/t_prod = new seed(loc)
			t_prod.species = F.species
			t_prod.lifespan = F.lifespan
			t_prod.endurance = F.endurance
			t_prod.maturation = F.maturation
			t_prod.production = F.production
			t_prod.yield = F.yield
			t_prod.potency = F.potency
			t_amount++
		del(O)

	else if(istype(O, /obj/item/weapon/grown/))
		var/obj/item/weapon/grown/F = O
		user.drop_item()
		user << "<span class='notice'>You extract some seeds from the [F.name].</span>"
		var/seed = text2path(F.seed)
		var/t_amount = 0
		var/t_max = rand(1,4)
		while(t_amount < t_max)
			var/obj/item/seeds/t_prod = new seed(loc)
			t_prod.species = F.species
			t_prod.lifespan = F.lifespan
			t_prod.endurance = F.endurance
			t_prod.maturation = F.maturation
			t_prod.production = F.production
			t_prod.yield = F.yield
			t_prod.potency = F.potency
			t_amount++
		del(O)

	else if(istype(O, /obj/item/stack/tile/grass))
		var/obj/item/stack/tile/grass/S = O
		user << "<span class='notice'>You extract some seeds from the [S.name].</span>"
		S.use(1)
		new /obj/item/seeds/grassseed(loc)

	return