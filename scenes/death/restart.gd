extends Button

var mainScene = preload("res://scenes/main/main.tscn")

func _ready():
	get_parent().get_node("Reason").text = PlayerData.deathReason

func _on_button_down() -> void:
	PlayerData.player_health = 5
	get_tree().change_scene_to_packed(mainScene)
