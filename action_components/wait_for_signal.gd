extends ActionComponent



@export var target: StringName
@export var signal_name: StringName



func apply(context: Dictionary) -> void:
	var object: Object = context.get(target)
	
	if not object:
		push_warning("target '%s' not found in context" %target)
		return
	
	if signal_name.is_empty():
		push_warning("signal name is empty")
		return
	
	if not object.has_signal(signal_name):
		push_warning("target '%s' does not have the signal '%s'" %[target, signal_name])
		return
	
	await Signal(object, signal_name)
