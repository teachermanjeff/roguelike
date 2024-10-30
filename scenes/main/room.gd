extends Node
class_name Room

var connections: Array[Vector2] = []
var original_connection: Vector2 = Vector2.ZERO
var connection_offsets = {}
var grid_position: Vector2 = Vector2.ZERO
var tile_pos: Vector2 = Vector2.ZERO
var glo_pos: Vector2 = Vector2.ZERO
var room_cleared = false