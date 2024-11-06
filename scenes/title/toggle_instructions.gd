extends Button

func _on_button_down() -> void:
	var instructions = get_node("/root/TextureRect/instructions")
	instructions.visible = !instructions.visible
