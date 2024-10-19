extends CharacterBody2D

const MOVE_DISTANCE: int = 32
const MOVE_DELAY: float = 0.2

var timer = Timer.new()
var can_move = true
var player_node: CharacterBody2D
var ground_node: TileMapLayer
var astar_grid: AStarGrid2D
var start_cell: Vector2i
var end_cell: Vector2i

func _ready():
	player_node = get_node("/root/Main/Player")
	ground_node = get_node("/root/Main/TileMapGround")
	_init_grid()
	timer.wait_time = MOVE_DELAY
	timer.one_shot = true
	timer.connect("timeout", _on_move_timeout)
	add_child(timer)

func _physics_process(_delta):
	if can_move and player_node:
		update_path()

func _init_grid():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = ground_node.get_used_rect()
	astar_grid.cell_size = Vector2i(MOVE_DISTANCE, MOVE_DISTANCE)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for x in range(ground_node.get_used_rect().size.x):
		for y in range(ground_node.get_used_rect().size.y):
			var cell = ground_node.get_used_rect().position + Vector2i(x, y)
			var tile_id = ground_node.get_cell_alternative_tile(cell)
			if tile_id == 2 and astar_grid.is_in_boundsv(Vector2i(cell.x + 1, cell.y)):
				astar_grid.set_point_solid(Vector2i(cell.x + 1, cell.y), true)

func update_path() -> void:
	start_cell = global_position / MOVE_DISTANCE
	end_cell = player_node.global_position / MOVE_DISTANCE
	
	if start_cell == end_cell:
		return

	var path = astar_grid.get_point_path(start_cell, end_cell, false)
	if path.size() > 0 and path[1] == Vector2(end_cell):
		return

	move_along_path(path)

func move_along_path(path: PackedVector2Array):
	if path.size() > 0:
		var next_point = path[1]
		var direction = (next_point - global_position).normalized()
		move_and_collide(direction * MOVE_DISTANCE)
		snap_to_grid()
		disable_movement()

func snap_to_grid():
	global_position = global_position.snapped(Vector2(MOVE_DISTANCE, MOVE_DISTANCE))

func disable_movement():
	can_move = false
	timer.start()

func _on_move_timeout():
	can_move = true
