extends KinematicBody


export(int) var movement_speed := 600

var _velocity := Vector3.ZERO
var _direction := Vector3.ZERO


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta: float) -> void:
    _direction = Vector3.ZERO
    if Input.is_action_pressed("move_forward"):
        _direction.x = -1
    if Input.is_action_pressed("move_backward"):
        _direction.x = +1

    if Input.is_action_pressed("move_left"):
        _direction.z = +1
    if Input.is_action_pressed("move_right"):
        _direction.z = -1

    _direction *= $Camera.translation + $Pivot.translation

    if _direction != Vector3.ZERO:
        _direction = _direction.normalized()


func _input(event: InputEvent) -> void:
    if event is InputEventMouse:
        rotation.y -= deg2rad(event.relative.x)


func _physics_process(delta: float) -> void:
    _velocity = _direction * movement_speed * delta
    _velocity = move_and_slide(_velocity, Vector3.UP)
