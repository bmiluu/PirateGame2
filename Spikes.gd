extends Node2D

@onready var collision_polygon_2d = $Area2D/CollisionPolygon2D



func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().die()
