extends Component
class_name Action



var processors: Array[Callable]



func process_input(input: Variant) -> void:
	for i in processors:
		await i.call(input)
