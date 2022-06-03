extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var speed: = Vector2(-25.0, 0)
var _velocity = Vector2.ZERO
var gravity = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TimerAttack.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _physics_process(delta: float) -> void:
	
	move_and_slide(speed)
	#_velocity.y = move_and_slide(speed).y
	


func _on_TimerAttack_timeout() -> void:
	$AnimatedSprite.play("attack")


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == 'attack':
		$AnimatedSprite.play("fly")
	elif $AnimatedSprite.animation == 'death':
		queue_free()
	#$AnimationPlayer.play("prepare_to_attack")
	
func _prepare_to_attack():
	pass


func _on_StompArea_area_entered(area: Area2D) -> void:
	print(area.name)
	if (area.name == "SwordArea"):
		speed.y += gravity
		die()
		
func die():
	set_physics_process(false)
	$StompJumpArea/CollisionShape2D.disabled = true
	$AnimatedSprite.play("death")



func _on_StompJumpArea_area_entered(area: Area2D) -> void:
	if (area.name == "StompJumpEnemy"):
		die()
