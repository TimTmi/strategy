class_name FadeAnimator



static func fade(target: Node2D, to: float, duration: float, from: float = NAN) -> void:
	var tween := target.create_tween()
	var property_tweener := tween.tween_property(target, "modulate:a", to, duration).from_current()
	if is_nan(from):
		property_tweener.from(from)
	await tween.finished


static func fade_in(target: Node2D, duration: float, from: float = -1) -> void:
	await fade(target, 1.0, duration, from)

static func fade_out(target: Node2D, duration: float, from: float = -1) -> void:
	await fade(target, 0.0, duration, from)
