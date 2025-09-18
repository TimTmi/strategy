extends Node
class_name Event


var callable: Callable
var awaited_signal: Signal
var dependencies: Array[Node]
var valid: bool = true


signal executed
signal invalidated()


func _init(init_callable: Callable = Callable(), init_awaited_signal: Signal = Signal(), init_dependencies: Array[Node] = []):
	callable = init_callable
	awaited_signal = init_awaited_signal
	dependencies = init_dependencies
	executed.connect(invalidate)
	for i: Node in dependencies:
		i.tree_exiting.connect(invalidate, CONNECT_ONE_SHOT)

func execute():
	for i in callable.get_bound_arguments():
		if not is_instance_valid(i):
			executed.emit()
			return
	if not awaited_signal.is_null():
		awaited_signal.connect(func(): executed.emit(), CONNECT_ONE_SHOT)
	callable.call()
	#prints(callable, callable.get_bound_arguments())

func invalidate():
	valid = false
	invalidated.emit()
	queue_free()
