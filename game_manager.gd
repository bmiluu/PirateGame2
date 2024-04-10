extends Node

@onready var points_label = %PointsLabel

var points = 0

func add_point(worth):
	points += worth
	print(points)
	points_label.text = "     " + str(points)
