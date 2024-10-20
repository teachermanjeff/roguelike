extends CharacterBody2D

var can_move = true
var timer = Timer.new()

func _ready():
	timer.wait_time = Globals.MOVE_DELAY
	timer.one_shot = true
	timer.connect("timeout", _on_move_timeout)
	add_child(timer)

func _process(_delta):
	if can_move:
		var direction = Vector2.ZERO

		if Input.is_action_pressed("ui_up"):
			direction = Vector2.UP
		elif Input.is_action_pressed("ui_down"):
			direction = Vector2.DOWN
		elif Input.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
		elif Input.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT

		if direction != Vector2.ZERO:
			move_and_collide(direction.normalized() * Globals.MOVE_DISTANCE)
			snap_to_grid()
			disable_movement()

func snap_to_grid():
	global_position = global_position.snapped(Vector2(Globals.MOVE_DISTANCE, Globals.MOVE_DISTANCE))

func disable_movement():
	can_move = false
	timer.start()

func _on_move_timeout():
	can_move = true
