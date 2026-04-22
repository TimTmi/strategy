class_name CallMethod extends ActionComponent



@export var target: StringName
@export var method_name: StringName
@export var args: Array = []



func apply(context: Dictionary) -> void:
	var object: Object = context.get(target)
	
	if not object:
		push_warning("target '%s' not found in context" %target)
		return
	
	if method_name.is_empty():
		push_warning("method name is empty")
		return
	
	if not object.has_method(method_name):
		push_warning("target '%s' does not have the method '%s'" %[target, method_name])
		return
	
	await object.callv(method_name, args)
