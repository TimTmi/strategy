extends Action



signal healed(interaction: Interaction)



func heal(interaction: Interaction):
	await process_input(interaction)
	var target: Character = interaction.target
	var amount: float = interaction.amount
	await target.set_health(target.health.current + interaction.amount)
	healed.emit(interaction)
