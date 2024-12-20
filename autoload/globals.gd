extends Node

const MOVE_DISTANCE: int = 32
const MOVE_DELAY: float = 0.2
var astar_grid: AStarGrid2D

func get_astar_grid(pathToMap = "/root/Main/TileMapGround"): 
	if !astar_grid: return create_grid(pathToMap)
	return astar_grid

func create_grid(pathToMap):
	var tile_map = get_node(pathToMap)
	if !tile_map: return

	if (astar_grid):
		astar_grid.clear()
	else:
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

	return astar_grid
