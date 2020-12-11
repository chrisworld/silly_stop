extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var path_id = 0
export var speed = 10

var path
var path_follower

var start_pos
var start_rot

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# path container for all paths
	$path_container.transform = self.transform

	# get path to follow
	path = $path_container.get_child(path_id)
	
	# get the path follower
	path_follower = path.get_child(0)
	
	# save starting position
	start_pos = self.translation
	start_rot = self.rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# update position on path
	path_follower.set_offset(path_follower.get_offset() + speed * delta)
	
	# update transform
	self.translation = start_pos + path_follower.translation
	self.rotation = start_rot + path_follower.rotation
	
	
