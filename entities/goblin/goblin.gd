extends CharacterBody2D

const MOVE_DISTANCE: int = 32
const SNAP_DISTANCE: int = 32
const MOVE_DELAY: float = 0.2

var timer = Timer.new()
var can_move = true
var player_node = null

func _ready():
    player_node = get_node("/root/Main/Player")
    timer.wait_time = MOVE_DELAY
    timer.one_shot = true
    timer.connect("timeout", _on_move_timeout)
    add_child(timer)

func _physics_process(_delta):
    if can_move and player_node:
        var to_player = (player_node.global_position - global_position).normalized()
        var movement_dir = get_axis_aligned_direction(to_player)
        
        if movement_dir != Vector2.ZERO:
            move_and_collide(movement_dir * MOVE_DISTANCE)
            snap_to_grid()
            disable_movement()

func get_axis_aligned_direction(to_player: Vector2) -> Vector2:
    if abs(to_player.x) > abs(to_player.y):
        return Vector2(sign(to_player.x), 0)
    else:
        return Vector2(0, sign(to_player.y))

func snap_to_grid():
    global_position = global_position.snapped(Vector2(SNAP_DISTANCE, SNAP_DISTANCE))

func disable_movement():
    can_move = false
    timer.start()

func _on_move_timeout():
    can_move = true
