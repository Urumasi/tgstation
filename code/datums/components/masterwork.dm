/datum/component/masterwork
	var/desc_text = "" // It is decorated with blah blah blah
	var/original_name
	var/original_desc

/datum/component/masterwork/Initialize()
	var/static/list/materials
	var/static/list/encrust

	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if(!materials)
		materials = list()

		var/mats = subtypesof(/datum/material)
		mats -= typesof(/datum/material/meat)
		mats -= /datum/material/pizza
		mats -= /datum/material/alloy // Not a complete type
		mats -= /datum/material/sand
		for(var/item in mats)
			var/datum/material/mat = item
			materials += initial(mat.name)

		for(var/item in subtypesof(/obj/item/stack/sheet/animalhide))
			var/obj/item/stack/sheet/animalhide/hide = item
			materials += initial(hide.name)

	if(!encrust)
		encrust = world.file2list("strings/gems.txt")

	generate_description(materials, encrust)

/datum/component/masterwork/proc/generate_description(var/list/materials, var/list/encrust)
	var/list/descriptors = list()
	var/list/current_descriptor
	var/list/mats_picked

	// First descriptor
	current_descriptor = list()

	if(prob(75))
		mats_picked = pick_amount_unique(encrust, rand(1, 2))
		current_descriptor += "encrusted with [english_list(mats_picked)]"
	// Always decorated
	mats_picked = pick_amount_unique(materials, rand(1, 3))
	current_descriptor += "decorated with [english_list(mats_picked)]"

	if(prob(75))
		mats_picked = pick_amount_unique(materials, rand(1, 2))
		current_descriptor += "encircled with bands of [english_list(mats_picked)]"

	descriptors += "It is [english_list(current_descriptor)]."

	// Second descriptor
	current_descriptor = list()

	if(prob(75))
		mats_picked = pick_amount_unique(materials, rand(1, 2))
		current_descriptor += "is adorned with hanging rings of [english_list(mats_picked)]"
	if(prob(75))
		mats_picked = pick_amount_unique(materials, rand(1, 2))
		current_descriptor += "menaces with spikes of [english_list(mats_picked)]"

	if(current_descriptor.len)
		descriptors += "This object [english_list(current_descriptor)]."

	descriptors += "On the item is an image of ..."
	descriptors += "On the item is an image of ..."
	descriptors += "On the item is an image of ..."
	desc_text = descriptors.Join(" ")

/datum/component/masterwork/RegisterWithParent()
	var/obj/item/master = parent
	original_name = master.name
	original_desc = master.desc

	master.name = "☼[original_name]☼"
	master.desc = "This is a masterful [original_name]. All craftsmanship is of the highest quality. [desc_text]\n[original_desc]"

/datum/component/masterwork/UnregisterFromParent()
	var/obj/item/master = parent
	master.name = original_name
	master.desc = original_desc

/obj/item/reagent_containers/food/drinks/mug/dorf

/obj/item/reagent_containers/food/drinks/mug/dorf/Initialize()
	. = ..()
	AddComponent(/datum/component/masterwork)
