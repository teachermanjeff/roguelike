extends Node2D

var score
var sprites = {
	"0": preload("res://sprites/digits/zero_symbol.png"),
	"1": preload("res://sprites/digits/one_symbol.png"),
	"2": preload("res://sprites/digits/two_symbol.png"),
	"3": preload("res://sprites/digits/three_symbol.png"),
	"4": preload("res://sprites/digits/four_symbol.png"),
	"5": preload("res://sprites/digits/five_symbol.png"),
	"6": preload("res://sprites/digits/six_symbol.png"),
	"7": preload("res://sprites/digits/seven_symbol.png"),
	"8": preload("res://sprites/digits/eight_symbol.png"),
	"9": preload("res://sprites/digits/nine_symbol.png"),
}

func _process(_delta):
	var new_score = str(PlayerData.score)
	if score == new_score:
		return
	score = new_score
	
	var digits = score.split('')
	var ones_node: Sprite2D = $Score/Ones
	var tens_node: Sprite2D = $Score/Tens
	
	ones_node.texture = sprites.get(digits[digits.size() - 1])
	if digits.size() > 1:
		tens_node.texture = sprites.get(digits[digits.size() - 2])
	else:
		tens_node.texture = sprites.get("0")
