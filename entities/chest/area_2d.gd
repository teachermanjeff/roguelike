extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
		PlayerData.take_damage(-2, "How the fuck did you die bitch??")
		PlayerData.score += 3
