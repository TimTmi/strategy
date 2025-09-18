extends Action



signal received_attack(interaction: Interaction)



func receive_attack(interaction: Interaction):
	var init_target: Character = interaction.target
	await process_input(interaction)
	if init_target:
		var target: Character = interaction.target
		if init_target == target:
			await target.take_damage(interaction)
		else:
			await target.receive_attack(interaction)
	received_attack.emit(interaction)
