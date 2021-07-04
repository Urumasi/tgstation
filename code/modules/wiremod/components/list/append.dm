/**
 * # List append component
 *
 * Append a value to a list, but disallow appending lists into other lists for OOM concerns. Then return the list.
 */
/obj/item/circuit_component/list_append
	display_name = "List Append"
	display_desc = "A component that appends a non-list value to a list."

	/// The input ports
	var/datum/port/input/list_port
	var/datum/port/input/value_port

	/// The result from the output
	var/datum/port/output/output
	circuit_flags = CIRCUIT_FLAG_INPUT_SIGNAL|CIRCUIT_FLAG_OUTPUT_SIGNAL

/obj/item/circuit_component/list_append/Initialize()
	. = ..()
	value_port = add_input_port("Value", PORT_TYPE_ANY)
	list_port = add_input_port("List", PORT_TYPE_LIST)

	output = add_output_port("List", PORT_TYPE_LIST)

/obj/item/circuit_component/list_append/Destroy()
	list_port = null
	value_port = null
	output = null
	return ..()

/obj/item/circuit_component/list_append/input_received(datum/port/input/port)
	. = ..()
	if(.)
		return

	var/value = value_port.input_value
	var/list/list_input = list_port.input_value

	if(!islist(list_input))
		output.set_output(null)
		return

	if(!value || islist(value) || length(list_input) >= 136)
		output.set_output(list_input)
		return

	var/list_output = list_input.Copy()
	list_output += value

	output.set_output(list_output)
