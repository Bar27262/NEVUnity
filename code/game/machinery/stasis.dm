/obj/machinery/stasispod
	name = "\improper Stasis pod"
	desc = "It places SSD persons in stasis."
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "scanner_0"
	density = 1
	var/mob/occupant = null
	anchored = 1.0
	use_power = 1
	idle_power_usage = 50
	active_power_usage = 300

/obj/machinery/stasispod/allow_drop()
	return 0

/obj/machinery/stasispod/relaymove(mob/user as mob)
	if (user.stat)
		return
	src.go_out()
	return

/obj/machinery/stasispod/verb/eject()
	set src in oview(1)
	set category = "Object"
	set name = "Eject Stasis Pod"

	if (usr.stat != 0)
		return
	src.go_out()
	for(var/obj/O in src)
		O.loc = get_turf(src)//Ejects items that manage to get in there (exluding the components)
	if(!occupant)
		for(var/mob/M in src)//Failsafe so you can get mobs out
			M.loc = get_turf(src)
	add_fingerprint(usr)
	return

/obj/machinery/stasispod/verb/move_inside()
	set src in oview(1)
	set category = "Object"
	set name = "Enter Stasis Pod"

	if (usr.stat != 0)
		return
	if (src.occupant)
		usr << "\blue <B>The scanner is already occupied!</B>"
		return
	if (usr.abiotic())
		usr << "\blue <B>Subject cannot have abiotic items on.</B>"
		return
	usr.stop_pulling()
	usr.client.perspective = EYE_PERSPECTIVE
	usr.client.eye = src
	usr.loc = src
	src.occupant = usr
	src.icon_state = "scanner_1"
	/*
	for(var/obj/O in src)    // THIS IS P. STUPID -- LOVE, DOOHL
		//O = null
		del(O)
		//Foreach goto(124)
	*/
	src.add_fingerprint(usr)
	return


/obj/machinery/stasispod/attackby(obj/item/weapon/grab/G as obj, user as mob)
	if ((!( istype(G, /obj/item/weapon/grab) ) || !( ismob(G.affecting) )))
		return
	if (src.occupant)
		user << "\blue <B>The scanner is already occupied!</B>"
		return
	if (G.affecting.abiotic())
		user << "\blue <B>Subject cannot have abiotic items on.</B>"
		return
	var/mob/M = G.affecting
	if(M.client)
		M.client.perspective = EYE_PERSPECTIVE
		M.client.eye = src
	M.loc = src
	src.occupant = M
	src.icon_state = "scanner_1"
	src.add_fingerprint(user)
	return

/obj/machinery/stasispod/proc/go_out()
	if ((!( src.occupant )))
		return
	if (src.occupant.client)
		src.occupant.client.eye = src.occupant.client.mob
		src.occupant.client.perspective = MOB_PERSPECTIVE
	src.occupant.loc = src.loc
	src.occupant = null
	src.icon_state = "scanner_0"
	return
/obj/machinery/stasispod/process()
	if(src.occupant)
		if(!src.occupant.client && (src.occupant.stat==0||src.occupant.stat==1))//if the living creature has no client
			for(var/obj/item/W in occupant) //remove everything they are wearing
			//Items with the STASIS_DEL flag are deleted
				if (W.flags & STASIS_DEL)
					if(istype(W, /obj/item/device/pda))
						for(var/obj/item/weapon/card/X in W)
							if(X.flags & STASIS_DEL)
								del(X)
					del(W)
				occupant.drop_from_inventory(W)
		//free up their job slot
			var/job = src.occupant.mind.assigned_role
			job_master.FreeRole(job)
			//check objectives TODO
			if(src.occupant.mind.special_role = "traitor")
				for(var/datum/objectives/O in src.occupant.mind)
					del(O)
				src.occupant.mind.special_role = null
			else
				possible_traitors.Remove(src.occupant)
			
			//delete them from datacore
			for(var/datum/data/record/R in data_core.medical)
				if ((R.fields["name"] == occupant.real_name))
					del(R)
			for(var/datum/data/record/T in data_core.security)
				if ((T.fields["name"] == occupant.real_name))
					del(T)
			for(var/datum/data/record/G in data_core.general)
				if ((G.fields["name"] == occupant.real_name))
					del(G)	
			var/obj/item/device/radio/intercom/a = new /obj/item/device/radio/intercom(null)
			a.autosay("[occupant.real_name] has entered stasis.", "Stasis Management Computer")
			src.icon_state = "scanner_0"
/*			for(var/mob/traitor in player_list)
				for(var/datum/objective/objectives in traitor)
					if(objectives.target == src.occupant.mind) //This isn't returning true or we aren't reaching this
						a.autosay("DEBUG: TRAITOR OBJECTIVE MATCHES DESPAWNING MOB","DEBUG")
						del(objectives)
						switch(rand(1,100))
							if(1 to 33)
								var/datum/objective/demote/demote_objective = new
								demote_objective.owner = traitor.mind
								demote_objective.find_target()
								traitor.mind.objectives += demote_objective
							if(34 to 50)
								var/datum/objective/brig/brig_objective = new
								brig_objective.owner = traitor.mind
								brig_objective.find_target()
								traitor.mind.objectives += brig_objective
							if(51 to 66)
								var/datum/objective/harm/harm_objective = new
								harm_objective.owner = traitor.mind
								harm_objective.find_target()
								traitor.mind.objectives += harm_objective
							else
								var/datum/objective/steal/steal_objective = new
								steal_objective.owner = traitor.mind
								steal_objective.find_target()
								traitor.mind.objectives += steal_objective */
			del(src.occupant)//delete the mob
		return
