extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var sprite_2d = $Sprite2D
@onready var sprite_2d_2 = $Dust
@onready var death_timer = $DeathTimer
@onready var pause_menu = $PauseMenu


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_dead = false

func _ready():
	Engine.max_fps = 60
	
func _physics_process(delta):
	if Input.is_action_pressed("pause"):
		show_pause_menu()
	if not is_dead:
		if velocity.x > 1 || velocity.x < -1 :
			sprite_2d.animation = "running"
			if is_on_floor():
				sprite_2d_2.play("run_dust")
			else:
				sprite_2d_2.play("default")
		else:
			sprite_2d.animation = "default"
			sprite_2d_2.play("default")
		
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			sprite_2d.animation = "jump"
			if velocity.y > 0:
				sprite_2d.animation = "fall"

		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, 10)

		move_and_slide()

		if Input.is_action_pressed("left"):
			sprite_2d.flip_h = true
			sprite_2d_2.position.x = 35
			sprite_2d_2.flip_h = true
		
		if Input.is_action_pressed("right"):
			sprite_2d.flip_h = false
			sprite_2d_2.position.x = -35
			sprite_2d_2.flip_h = false


func die():
	is_dead = true
	sprite_2d_2.visible = false
	sprite_2d.animation = "death"
	death_timer.start()


func _on_death_timer_timeout():
	get_tree().reload_current_scene()

func show_pause_menu():
	Engine.time_scale = 0
	pause_menu.visible = true
	
