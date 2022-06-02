extends CanvasLayer
 
export (String, FILE, "*.json") var dialogPath
export(float) var textSpeed = 0.05
 
var dialog

var is_dialogue_active = false
 
var phraseNum = 0
var finished = false
 
func _ready():
	$NinePatchRect.visible = false
	
func play():
	if is_dialogue_active:
		return
		
	phraseNum = 0
	is_dialogue_active = true
	$NinePatchRect.visible = true
	$NinePatchRect/Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
 
func _process(_delta):
	$NinePatchRect/Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$NinePatchRect/Text.visible_characters = len($NinePatchRect/Text.text)
 
func getDialog() -> Array:
	turn_off_the_player()
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	print(dialogPath)
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
 
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		finished = false
		is_dialogue_active = false
		$NinePatchRect.visible = false
		turn_on_the_player()
		return
	
	finished = false
	
	$NinePatchRect/Name.bbcode_text = dialog[phraseNum]["Name"]
	$NinePatchRect/Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$NinePatchRect/Text.visible_characters = 0
	
	var f = File.new()
	var img = "res://assets/characters/" + dialog[phraseNum]["Name"] + "/" + dialog[phraseNum]["Emotion"] + ".png"
	if f.file_exists(img):
		$NinePatchRect/Portrait.texture = load(img)
	else: $NinePatchRect/Portrait.texture = null
	
	while $NinePatchRect/Text.visible_characters < len($NinePatchRect/Text.text):
		$NinePatchRect/Text.visible_characters += 1
		
		$NinePatchRect/Timer.start()
		yield($NinePatchRect/Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
	
func turn_on_the_player():
	if PlayerSingleton:
		PlayerSingleton.active = true

func turn_off_the_player():
	if PlayerSingleton:
		PlayerSingleton.active = false
