extends Node

var player_health = 5
var score = 0
var deathScene = preload("res://scenes/death/death.tscn")
var winScene = preload("res://scenes/win/win.tscn")
var deathReason = "sigma"

func give_money(amount: int) -> void:
	score += amount 

	if score >= 15:
		get_tree().change_scene_to_packed(winScene) 

func take_damage(amount: int, death_message: String) -> void:
	player_health = max(0, player_health - amount)

	if player_health <= 0:
		deathReason = death_message
		get_tree().change_scene_to_packed(deathScene)
		score=0
