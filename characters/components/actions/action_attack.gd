extends Action



signal attacked(interaction: Interaction)



func attack(interaction: Interaction):
	await process_input(interaction)
	await interaction.target.receive_attack(interaction)
	attacked.emit(interaction)
