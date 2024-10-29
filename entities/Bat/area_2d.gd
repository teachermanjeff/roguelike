extends Area2D

var timer = Timer.new()
var colliding_player = false
var health = 5

func _ready():
	timer.wait_time = Globals.MOVE_DELAY * 1
	timer.one_shot = true
	timer.connect("timeout", _on_move_timeout)
	add_child(timer)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		colliding_player = true
		timer.start()

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		colliding_player = false

func _on_move_timeout():
	if colliding_player:
		health -= 1
		if health <= 0:
			get_parent().queue_free()
		timer.start()
