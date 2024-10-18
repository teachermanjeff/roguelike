extends CharacterBody2D

@export var MOVE_DISTANCE = 32
@export var SNAP_DISTANCE = 16
const MOVE_DELAY = 0.2

var can_move = true
var move_timer = 0.0
var direction = Vector2.ZERO

func _physics_process(delta):
	if not can_move:
		move_timer -= delta
		if move_timer <= 0:
			can_move = true

	if can_move:
		direction = Vector2.ZERO

		if Input.is_action_pressed("ui_up"):
			direction.y = -1
		elif Input.is_action_pressed("ui_down"):
			direction.y = 1
		elif Input.is_action_pressed("ui_left"):
			direction.x = -1
		elif Input.is_action_pressed("ui_right"):
			direction.x = 1

		if direction != Vector2.ZERO:
			move_and_collide(direction.normalized() * MOVE_DISTANCE)
			snap_to_grid()
			start_move_delay()

func snap_to_grid():
	var snapped_position = Vector2(
		round(position.x / SNAP_DISTANCE) * SNAP_DISTANCE,
		round(position.y / SNAP_DISTANCE) * SNAP_DISTANCE
	)
	position = snapped_position

func start_move_delay():
	can_move = false
	move_timer = MOVE_DELAY
