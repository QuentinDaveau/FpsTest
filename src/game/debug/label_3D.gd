extends Sprite3D
class_name Label3D


var _viewport: Viewport
var _label: Label


func _init() -> void:
	_viewport = Viewport.new()
	_label = Label.new()
	add_child(_viewport)
	_viewport.add_child(_label)
	
	_label.rect_scale = Vector2.ONE * 2.0
	
	texture = _viewport.get_texture()
	_viewport.render_target_v_flip = true
	_viewport.transparent_bg = true
	billboard = SpatialMaterial.BILLBOARD_ENABLED



func _physics_process(delta: float) -> void:
	_viewport.size = _label.rect_size * _label.rect_scale



func set_text(text: String) -> void:
	_label.text = text

