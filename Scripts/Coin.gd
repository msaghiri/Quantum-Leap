extends Node2D

func _ready():
	$AnimatedSprite2D.play("coinspin")
	pass 

func _process(delta):
	pass
	
	



func _on_coin_area_body_entered(body):
	if body is CharacterBody2D && body.name == "Player":
		$CoinArea/CollisionShape2D.queue_free()
		SingletonVariables.coins += 1;
		$AnimatedSprite2D.play("pickup")
		await $AnimatedSprite2D.animation_finished
		queue_free();
		pass
	pass 
