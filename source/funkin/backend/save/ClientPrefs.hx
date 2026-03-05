package funkin.backend.save;


import flixel.input.keyboard.FlxKey;
class ClientPrefs
{
	// _______________________ Camera ________________________
	public var cameraMoveOnPush:Bool = false;
    
	// _______________________ Visual ________________________
	public static var globalAntialiasing:Bool = true;

	// ______________________ Graphics _______________________
	public var gpuCaching:Bool = false;

	// ______________________ Gameplay _______________________
	public var controllerMode:Bool = false;
	public var inDevMode:Bool = true;

	public static var noteOffset:Int = 0;
	public var comboOffset:Array<Int> = [0, 0, 0, 0];
	public var ratingOffset:Int = 0;
	public var sickWindow:Float = 45.0;
	public var goodWindow:Float = 90.0;
	public var badWindow:Float = 135.0;
	public var safeFrames:Int = 10;


    
	public var keyBinds:Map<String, Array<FlxKey>> = [
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