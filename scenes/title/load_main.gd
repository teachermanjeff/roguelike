extends Button

var mainScene = preload("res://scenes/main/main.tscn")

func _on_button_down() -> void:
	get_tree().change_scene_to_packed(mainScene)
