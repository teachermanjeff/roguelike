extends CharacterBody2D

var timer = Timer.new()
var can_move = true
var player_node: CharacterBody2D
var start_cell: Vector2i
var end_cell: Vector2i

func _ready():
	player_node = get_node("/root/Main/Player")
	timer.wait_time = Globals.MOVE_DELAY
	timer.one_shot = true
	timer.connect("timeout", _on_move_timeout)
	add_child(timer)

func _process(_delta):
	if can_move and player_node:
		update_path()

func update_path() -> void:
	start_cell = global_position / Globals.MOVE_DISTANCE
	end_cell = player_node.global_position / Globals.MOVE_DISTANCE
	
	if start_cell == end_cell:
		return

	var path = Globals.get_astar_grid().get_point_path(start_cell, end_cell, false)
	if path.size() > 0 and path[1] == Vector2(end_cell) or path.size() > 10:
		return

	move_along_path(path)

func move_along_path(path: PackedVector2Array):
	if path.size() > 0:
		var next_point = path[1]
		var direction = (next_point - global_position).normalized()
		move_and_collide(direction * Globals.MOVE_DISTANCE)
		snap_to_grid()
		disable_movement()

func snap_to_grid():
	global_position = global_position.snapped(Vector2(Globals.MOVE_DISTANCE, Globals.MOVE_DISTANCE))

func disable_movement():
	can_move = false
	timer.start()

func _on_move_timeout():
	can_move = true
