extends Action


var dead: bool = true


func die():
	await process_input(dead)
