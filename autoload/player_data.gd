extends Node

var player_health = 100
var score = 0

func take_damage(amount: int, death_message: String) -> void:
	player_health = max(0, player_health - amount)

	if player_health <= 0:
		print(death_message)
		get_tree().reload_current_scene()
