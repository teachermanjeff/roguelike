extends Button

var mainScene = preload("res://scenes/title/title.tscn")

func _on_button_down() -> void:
	PlayerData.player_health = 5
	get_tree().change_scene_to_packed(mainScene)
