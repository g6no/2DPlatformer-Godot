extends KinematicBody2D


var score : int = 0

# Movement
export var speed : int = 200
export var jump_force : int = 700
export var gravity : int = 800

var velocity : Vector2  = Vector2()

onready var anim = $AnimatedSprite

#onready var score_text = get_node("/root/Main/CanvasLayer/UI/ScoreLabel")

onready var ui = $"../CanvasLayer/UI"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	horizontal_movement()
	vertical_movement(delta)
	handle_animations(delta)

func horizontal_movement():
	velocity.x = 0
	
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	
	velocity = move_and_slide(velocity, Vector2.UP)

func vertical_movement(delta):
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
	

func handle_animations(delta):
	
	if velocity.x > 0:
		anim.flip_h = false
	if velocity.x < 0:
		anim.flip_h = true
		
	# Animations
	if velocity.x == 0:
		anim.play("idle")
	elif velocity.x != 0:
		anim.play("walk")
	
	if int(velocity.y) != int(gravity * delta):
		anim.play("jump")
		

func die():
	get_tree().reload_current_scene()
	
func collect_coin(value):
	score += value
	var score_text = ui.get_node("ScoreLabel")
	score_text.text = str(score)
