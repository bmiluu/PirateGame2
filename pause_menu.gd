extends Control

@onready var pause_menu = $"."
@onready var player = $".."

func _on_resume_pressed():
	player.show_pause_menu(true)

func _on_exit_pressed():
	get_tree().quit()
