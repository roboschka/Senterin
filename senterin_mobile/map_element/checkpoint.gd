extends Area2D
 
onready var anim = $AnimationPlayer

func _on_checkpoint_body_entered(body):
	if body.is_in_group("player"):
		
		anim.play("lit")
