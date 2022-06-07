extends Control


export var dialogPath = ""#res://src/Dialogs/dialog-end.json"
export(float) var textSpeed = 0.05
signal done_read(value)

var dialog
 
var phraseNum = 0
var finished = false

func _ready():
	pass
	"""
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	"""
 
func _process(_delta):
	#$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)
			visible = true


func getDialog() -> Array:
	
	var f = File.new()
	assert(f.file_exists(dialogPath), "File path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
	

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		emit_signal("done_read",true)
		visible = false
		return
	
	finished = false
	
	$Dialog/Name.bbcode_text = dialog[phraseNum]["Name"]
	$Dialog/Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Dialog/Text.visible_characters = 0
	
	var f = File.new()
	var img = dialog[phraseNum]["Name"] + ".png"
	if dialog[phraseNum]["Name"] == "Player":
		$PortraitPrimary.visible = true
		$PortraitSecondary.visible = false
	elif dialog[phraseNum]["Name"] == "Boss":
		$PortraitPrimary.visible = false
		$PortraitSecondary.visible = true
	
	while $Dialog/Text.visible_characters < len($Dialog/Text.text):
		$Dialog/Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
	
func start():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
