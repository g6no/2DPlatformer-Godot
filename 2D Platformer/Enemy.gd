extends Area2D

export var speed : int = 100
export var move_distance : int = 100

onready var start_x : float = position.x
onready var target_x : float = position.x + move_distance

func _physics_process(delta):
	
	position.x = move_to(position.x, target_x, speed * delta)
	
	if position.x == target_x:
		if target_x == start_x:
			target_x = position.x + move_distance
		else:
			target_x = start_x

func move_to(current, target, step):
	var new = current
	
	if new < target:
		new += step
		
		if new > target:
			new = target
	else:
		new -= step
		if new < target:
			new = target
	return new


func _on_Enemy_body_entered(body):
	if body.name == "Player":
		body.die()
