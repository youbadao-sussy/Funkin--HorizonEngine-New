package funkin.backend.save;


import flixel.input.keyboard.FlxKey;
class ClientPrefs
{
    public static var gpuCaching:Bool = false;

    // ________________ Camera _________________
    public static var cameraMoveOnPush:Bool = false;
    
    public static var globalAntialiasing:Bool = true;

    public static var controllerMode:Bool = false;

    public static var inDevMode:Bool = true;


    
	@saveVar(false, false) public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Key Bind, Name for ControlsSubState
		'note_left' => [A, LEFT],
		'note_down' => [S, DOWN],
		'note_up' => [W, UP],
		'note_right' => [D, RIGHT],
		'dodge' => [SPACE, NONE],
		'ui_left' => [A, LEFT],
		'ui_down' => [S, DOWN],
		'ui_up' => [W, UP],
		'ui_right' => [D, RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [BACKSPACE, ESCAPE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R, NONE],
		'volume_mute' => [ZERO, NONE],
		'volume_up' => [NUMPADPLUS, PLUS],
		'volume_down' => [NUMPADMINUS, MINUS],
		'debug_1' => [SEVEN, NONE],
		'debug_2' => [EIGHT, NONE]
	];
}