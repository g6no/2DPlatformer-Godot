extends Area2D

export var value : int = 1

func _process(delta):
	rotation_degrees += 45 * delta


func _on_Coin_body_entered(body):
	if body.name == "Player":
		queue_free()
		body.collect_coin(value)
