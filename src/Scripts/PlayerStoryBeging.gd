extends KinematicBody2D

var speed: = Vector2(200.0, 700.0)
var _velocity = Vector2(0, 0)
var gravity = 2000
const FLOOR_NORMAL: = Vector2.UP
var position_initial:Vector2;
const distance: int = 200
var can_run = false
signal stop_run(stop)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position_initial = global_position
	_velocity.x = speed.x
	set_physics_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$AnimatedSprite.play("run")
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	"""
	var calculate_distance = abs(global_position.x - position_initial.x)
	if calculate_distance < distance:
		$AnimatedSprite.play("run")
		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	else:
		$AnimatedSprite.play("idle")
		emit_signal("stop_run", true)
		set_physics_process(false)
	"""

func run( time_run_in_sec: int):
	set_physics_process(true)
	$TimerPlayer.start(time_run_in_sec)


func _on_TimerPlayer_timeout() -> void:
	$AnimatedSprite.play("idle")
	emit_signal("stop_run", true)
	set_physics_process(false)
