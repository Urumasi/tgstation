/datum/component/masterwork
	var/original_name
	var/original_desc

/datum/component/masterwork/Initialize()


/datum/component/masterwork/RegisterWithParent()
	original_name = parent.name
	original_desc = parent.desc

/datum/component/masterwork/UnregisterFromParent()
	parent.name = original_name
	parent.desc = original_desc
