extends CharacterBody2D

## prueba de description xd.
@export var namess = "jaksdjkasd"

@onready var object = get_parent().get_node("Node2D")

@export var audios : Array[Resource]

var transition = AudioTransitions.new()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _input(_event):
	if Input.is_action_just_pressed("ui_up"):
		AudioManager.play_music("Theme1")
		
	if Input.is_action_just_pressed("ui_down"):
		#AudioManager.to_outro("Theme1")
		AudioManager.layer_off("Theme1", [1])
		
	if Input.is_action_just_pressed("ui_left"):
		AudioManager.change_loop("Theme1", 2, true)
		
	if Input.is_action_just_pressed("ui_right"):
		#AudioManager.change_loop("Theme1", 2, true)
		AudioManager.change_loop("Theme1", 1, true)
		
	if Input.is_action_just_pressed("ui_accept"):
		AudioManager.layer_on("Theme1", [1])
		#AudioManager.ABGM. ("Theme1")
		


func _ready():
	pass
	"""
	var dic = {
	"filename": {"name":"file"}
	}
	#var keys = dic.keys()
	for i in dic:
		var iner = dic[i]
		if "name" in iner:
			print(i)"""

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
	var mouse_pos = get_global_mouse_position()
	object.global_position = mouse_pos
