extends Area2D
var rng = RandomNumberGenerator.new()
func _ready():
	var _my_random_number = rng.randf_range(-3, 3)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
		PlayerData.give_money(rng)
