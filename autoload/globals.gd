extends Node

const MOVE_DISTANCE: int = 32
const MOVE_DELAY: float = 0.2

var astar_grid: AStarGrid2D = AStarGrid2D.new()
var created_grid = false

func _process(_delta):
	var tile_map = get_node("/root/Main/TileMapGround")

	if !tile_map or created_grid: return

	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2i(Globals.MOVE_DISTANCE, Globals.MOVE_DISTANCE)
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for x in range(tile_map.get_used_rect().size.x):
		for y in range(tile_map.get_used_rect().size.y):
			var cell = tile_map.get_used_rect().position + Vector2i(x, y)
			var tile_id = tile_map.get_cell_alternative_tile(cell)
			if tile_id == 2 and astar_grid.is_in_boundsv(Vector2i(cell.x + 1, cell.y)):
				astar_grid.set_point_solid(Vector2i(cell.x + 1, cell.y), true)

	created_grid = true