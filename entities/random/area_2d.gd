extends Area2D
var rng = RandomNumberGenerator.new()
var random = rng.randf_range(-3,3)

func _on_body_entered(body: Node2D) -> void:

		if body.is_in_group("player"):
			queue_free()
			PlayerData.take_damage(-random,"Maybe don't try the lottery")
			PlayerData.score += 0

