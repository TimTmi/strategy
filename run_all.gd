class_name FunctionSet



var _remaining: int = 0
var _functions: Array[Callable]
var _results: Array[Variant]



signal _done



func _init(init_functions: Array[Callable]) -> void:
	_functions = init_functions
	_results.resize(_functions.size())

func call_all() -> Array[Variant]:
	var set_size: int = _functions.size()
	
	_remaining = set_size
	_results.fill(null)
	
	for i: int in set_size:
		var function: Callable = _functions.get(i)
		_call(function, i)
	
	if _remaining == 0:
		return _results
	
	return await _done

func _call(function: Callable, index: int) -> void:
	var result: Variant = await function.call()
	_results.set(index, result)
	_remaining -= 1
	if _remaining == 0:
		_done.emit(_results)
