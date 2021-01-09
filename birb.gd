extends KinematicBody2D


export var GRAVITY := .08
export var FLAP_STRENGTH := 2
export var FLY_SPEED := .4

var MAX_FALL_SPEED := .4

# our velocity
var velocity := Vector2(FLY_SPEED, 0)
var birb_state := 'flying'


# Called when the node enters the scene tree for the first time.
func _ready():
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
  if is_on_floor():
    birb_state = 'sitting'
  elif is_on_wall():
    birb_state = 'hanging'
  
  # calculate velocity
  if Input.is_action_just_pressed('flap'):
    velocity.y += - FLAP_STRENGTH
    
    if birb_state != 'flying:':
      # todo we want to do like new_state here?....
      birb_state = 'flying'
      
  else:
    if birb_state == 'hanging':
      velocity.y = 0
    else:
      velocity.y += GRAVITY
        
    if birb_state == 'sitting':
      velocity.x = 0
    else:
      velocity.x = FLY_SPEED
    
  # clamp the velocity
  velocity.y = min(velocity.y, MAX_FALL_SPEED)
  
  print(birb_state)

# animation
  if birb_state == 'flying':
    $anim.set_animation('flying')
    $title.hide()
  elif birb_state == 'sitting':
    $anim.set_animation('sitting')
    $title.show()
  elif birb_state == 'hanging':
    $anim.set_animation('hanging')
    $title.show()
  else:
    print('bad birb state!')
  
  
func _physics_process(delta):
  move_and_slide(velocity * 100, Vector2(0, -1))
  
func _on_birb_collided():
  print('birb landed!')

  
  

  
  
  
  
  
  
