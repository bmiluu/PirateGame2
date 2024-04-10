extends Area2D

@onready var game_manager = $"../GameManager"

func _on_body_entered(body):
	queue_free()
	game_manager.add_point(6)


func _on_finish_body_entered(body):
	pass # Replace with function body.
