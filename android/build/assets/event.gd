extends Node
class_name Event


var callable: Callable
var awaited_signal: Signal


signal executed


func _init(_callable: Callable, _awaited_signal: Signal = Signal()):
	callable = _callable
	awaited_signal = _awaited_signal

func execute():
	if not awaited_signal.is_null():
		awaited_signal.connect(_on_execution_complete, CONNECT_ONE_SHOT)
	callable.call()

func _on_execution_complete():
	executed.emit()
