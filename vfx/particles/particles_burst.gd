extends GPUParticles2D



func set_radius(radius: int, damping := 3):
	if process_material is ParticleProcessMaterial:
		var velocity: float = radius / lifetime * (2 ** damping)
		var internal_damping: float = int(damping > 0) * (velocity ** 2) * 0.5 / radius
		
		process_material.initial_velocity_max = velocity
		process_material.damping_min = internal_damping * 0.9
		process_material.damping_max = internal_damping * 1.1
		amount = radius * 2
