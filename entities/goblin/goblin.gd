extends CharacterBody2D

const MOVE_DISTANCE: int = 32
const SNAP_DISTANCE: int = 32
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
    astar_grid.size = ground_node.get_used_rect().size
    astar_grid.cell_size = Vector2i(MOVE_DISTANCE, MOVE_DISTANCE)
    astar_grid.update()

func update_path() -> void:
    print_debug(position, player_node.position)
    start_cell = position / MOVE_DISTANCE
    end_cell = player_node.position / MOVE_DISTANCE
    
    if start_cell == end_cell:
        return

    move_along_path(astar_grid.get_id_path(start_cell, end_cell, true))

func move_along_path(path: PackedVector2Array):
    if path.size() > 0:
        var next_point = path[0]
        var direction = (next_point - global_position).normalized()
        move_and_collide(direction * MOVE_DISTANCE)
        snap_to_grid()
        disable_movement()

func snap_to_grid():
    global_position = global_position.snapped(Vector2(SNAP_DISTANCE, SNAP_DISTANCE))

func disable_movement():
    can_move = false
    timer.start()

func _on_move_timeout():
    can_move = true