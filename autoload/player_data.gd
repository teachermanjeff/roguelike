extends Node

var player_health = 5
var score = 0
var deathScene = preload("res://scenes/death/death.tscn")

func take_damage(amount: int, death_message: String) -> void:
	player_health = max(0, player_health - amount)

	if player_health <= 0:
		get_tree().change_scene_to_packed(deathScene)
