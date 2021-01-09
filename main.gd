extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var BUILDING_BASE_HEIGHT = 120

# list of possible buildings
var building_paths := [
  'building_type1.tscn',
  'building_type2.tscn'
]

var timer


# Called when the node enters the scene tree for the first time.
func _ready():
  timer = Timer.new()
  timer.set_wait_time(2)
  timer.connect('timeout', self, '_on_timer_timeout')
  add_child(timer)
  timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  if $birb.birb_state == 'flying':
    pass
    # hide title
  else:
    pass
    
  
func _on_timer_timeout():
  if $birb.birb_state == 'flying' and building_paths.size() > 0:
    var random_building_path = building_paths[randi() % building_paths.size()]
    var building = load('res://buildings/' + random_building_path).instance()
    add_child(building)

    var height = BUILDING_BASE_HEIGHT - (randi() % 10)
    var birb_x = $birb.get_position().x
    building.set_position(Vector2(birb_x + 256, height)) 
