extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		PlayerData.take_damage(-2, "How the fuck did you die bitch??")
		get_parent().queue_free()
