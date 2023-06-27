extends Node

## Here you can edit the parameters for all the tracks that derive from this main track. 
@export_group("MainTrack Parameters")

## Volume of track, in dB. [br][b]This parameter affects all the tracks that belong to it[/b].
@export_range(-80.0, 24.0) var volume_db : float = 0.0 : set = set_volume_db, get = get_volume_db

## Pitch and tempo of the audio. [br][b]This parameter affects all the tracks that belong to it[/b].
@export_range(0.01, 4.0) var pitch : float = 1.0 : set = set_pitch, get = get_pitch

## Audio Bus of the audio. [br][b]This parameter affects all the tracks that belong to it[/b]
@export var bus : String = "Master"

var layers = []
var groups = {}

func _ready():
	#AudioManager.debug._print("DEBUG: " + str(self.name) + " in bus " + bus)
	
	## Parameters set in Layers
	for i in get_children():
		layers.append(i)
		i.volume_db = volume_db
		i.set_bus(bus)
		
		## AudioStream in Layer
		for n in i.get_children():
			n.volume_db = volume_db
			n.set_bus(bus)
			
		## Add Groups
		for n in i.groups:
			var arr = []
			if groups.keys().has(n):
				arr = groups[n]
			arr.append(i)
			groups[n] = arr
			
	
func on_play(fade_time := 0.0, _skip_intro := false, _loop_index := 0):
	if get_stream_playing() != null:
		AudioManager.debug._print("DEBUG: ParallelTrack already playing")
		return
	
	## Layers
	for i in layers:
		if i.playing_type == "Always":
			if i.listening_from_start:
				i.volume_db = volume_db
				
				## AudioStream in Layer
				for n in i.get_children():
					n.volume_db = volume_db
					
				i.on_play(fade_time, volume_db)
			else:
				i.volume_db = -50.0
				i.on_play(fade_time, -50.0)
				
func play_layer(layer_names : Array, fade_time := 3.0):
	for i in layer_names:
		if typeof(i) == TYPE_INT:
			if i > get_child_count() - 1:
				AudioManager.debug._print("DEBUG: Layer not found")
			else:
				var node = get_children()[i]
				if node != null:
					node.on_play(fade_time, volume_db) 
				else:
					AudioManager.debug._print("DEBUG: Layer not found")
		if typeof(i) == TYPE_STRING:
			if groups.has(i):
				for n in groups[i]:
					n.on_play(fade_time, volume_db) 
			else:
				var node = get_layer(i)
				if node != null:
					node.on_play(fade_time, volume_db) 
				else:
					AudioManager.debug._print("DEBUG: Layer not found")
			
func on_stop(fade_time := 0.0, can_destroy := false):
	var arr = []
	for i in layers:
		arr.append(str(i.name))
		
	stop_layer(arr, fade_time)
		
func stop_layer(layer_names : Array, fade_time := 3.0):
	for i in layer_names:
		if typeof(i) == TYPE_INT:
			if i > get_child_count() - 1:
				check_node(null, fade_time, false)
			else:
				var node = get_children()[i]
				check_node(node, fade_time, false)
		if typeof(i) == TYPE_STRING:
			if groups.has(i):
				for n in groups[i]:
					n.change(volume_db, fade_time, false)
			else:
				var node = get_layer(i)
				check_node(node, fade_time, false)

func on_trigger_layer(layer_name : String, fade_time := 0.5):
	var layer = get_layer(layer_name)
	layer.on_play()


func on_layers(layers_names : Array, fade_in := 2.0):
	for i in layers_names:
		if typeof(i) == TYPE_INT:
			if i > get_child_count() - 1:
				check_node(null, fade_in, true)
			else:
				var node = get_children()[i]
				check_node(node, fade_in, true)
		if typeof(i) == TYPE_STRING:
			if groups.has(i):
				for n in groups[i]:
					n.change(volume_db, fade_in, true)
			else:
				var node = get_layer(i)
				check_node(node, fade_in, true)


func off_layers(layers_names : Array, fade_out := 3.0):
	for i in layers_names:
		if typeof(i) == TYPE_INT:
			if i > get_child_count() - 1:
				check_node(null, fade_out, false, false)
			else:
				var node = get_children()[i]
				check_node(node, fade_out, false, false)
		if typeof(i) == TYPE_STRING:
			if groups.has(i):
				for n in groups[i]:
					n.change(volume_db, fade_out, false, false)
			else:
				var node = get_layer(i)
				check_node(node, fade_out, false, false)


func check_node(node, fade_time, fade_type, can_stop := true):
	if node != null:
		node.change(volume_db, fade_time, fade_type, can_stop) 
	else:
		AudioManager.debug._print("DEBUG: Layer not found")




#########################
## From AdaptiveTracks ##
#########################

func on_fade_in(volume_db, fade_in):
	on_play(fade_in)
func on_fade_out(fade_out):
	on_stop(fade_out)



	#######################
	# Getters and Setters #
	#######################
	
func get_layer(layer_name : String):
	var childrens = get_children()
	for i in childrens:
		if i.name == layer_name:
			return i
			
func get_stream_playing():
	var childs = get_children()
	for i in childs:
		for n in i.get_children():
			if n.playing:
				return i
		if i.playing:
			return i
			
	return null
	
func set_volume_db(value : float):
	volume_db = value
	for i in get_children():
		for n in i.get_children():
			n.volume_db = volume_db
			
		i.volume_db = volume_db
	
func get_volume_db():
	return volume_db

func set_pitch(value):
	pitch = value
	for i in get_children():
		for n in i.get_children():
			n.pitch = pitch
			
		i.pitch = pitch
	
func get_pitch():
	return pitch
