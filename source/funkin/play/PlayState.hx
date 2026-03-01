package funkin.play;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;

class PlayState extends FlxState
{
	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camOther:FlxCamera;
	public var cameraSpeed:Float = 1;
	
	public var defaultCamZoom:Float = 1.05;
	public var defaultHudZoom:Float = 1;

	/**
	 * Disables automatic camera movements if enabled.
	 */
	public var isCameraOnForcedPos:Bool = false;

	public var cameraLerping:Bool = true;

	public var oppMap:Map<String, Character> = new Map();
	public var centerMap:Map<String, Character> = new Map();
	public var plyMap:Map<String, Character> = new Map();

	public var oppGroup:FlxSpriteGroup;
	public var centerGroup:FlxSpriteGroup;
	public var plyGroup:FlxSpriteGroup;

	public var player:Character;

	
	public var playerCameraOffset:Array<Float> = [0, 0];
	public var opponentCameraOffset:Array<Float> = [0, 0];
	public var centerCameraOffset:Array<Float> = [0, 0];
	
	/**
		Reference to the player stage position
	**/
	public var PLY_X:Float = 770;
	public var PLY_Y:Float = 100;
	
	/**
		Reference to the opponent stage position
	**/
	public var OPP_X:Float = 100;
	public var OPP_Y:Float = 100;
	
	/**
		Reference to the girlfriend stage position
	**/
	public var CEN_X:Float = 400;
	public var CEN_Y:Float = 130;
	
	public var playAnimData:Array<String> = ["singLeft", "singDown", "singUp", "singRight"];

	
	/**
	 * Target the game camera follows
	 */
	var camFollow:FlxObject;

	/**
	 * Previous cameras target. used in story mode for a more seamless transition
	 */
	static var prevCamFollow:Null<FlxObject> = null;

	override public function create()
	{
		super.create();
		FunkinAssets.cache.clearStoredMemory();
		
		camGame = new FlxCameraEx();
		camHUD = new FlxCameraEx();
		camOther = new FlxCameraEx();
		
		camHUD.bgColor = 0x0;
		camOther.bgColor = 0x0;
		
		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.add(camOther, false);
		// FlxG.cameras.setDefaultDrawTarget(camGame, true);

		var text = new FlxText(0, 0, 0, "Hello World", 64);
		text.screenCenter();
		add(text);

    	plyGroup ??= new FlxSpriteGroup();
		plyGroup.x = PLY_X;
		plyGroup.y = PLY_Y;
		
		player = new Character('bf', true);
		startCharacterPos(player);
		plyGroup.add(player);
		plyMap.set(player.curCharacter, player);
		
    	add(plyGroup);

		
		var camPos:FlxPoint = FlxPoint.get(playerCameraOffset[0], playerCameraOffset[1]);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(camPos.x, camPos.y);
		camPos.put();
		add(camFollow);
		
		// FlxG.camera.follow(camFollow, LOCKON, 0);
		FlxG.camera.follow(plyGroup, LOCKON, 0);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.snapToTarget();
		
    	FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FunkinAssets.cache.clearUnusedMemory();
	}

  	function startCharacterPos(char:Character, ?gfCheck:Bool = false)
  	{
		if (char == null) return;

  		char.x += char.positionOffset[0];
  		char.y += char.positionOffset[1];
  	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		player?.onBeatHit(2);

		if (FlxG.keys.justPressed.LEFT)
			noteHit('singLeft');
		if (FlxG.keys.justPressed.DOWN)
			noteHit('singDown');
		if (FlxG.keys.justPressed.UP)
			noteHit('singUp');
		if (FlxG.keys.justPressed.RIGHT)
			noteHit('singRight');
		if (FlxG.keys.justPressed.ENTER)
			noteHit('hey');
	}
	
	function noteHit(anim:String):Void
	{
		
		// final char:Null<Character> = note.gfNote ? gf : note.owner ?? field.owner;
		
		player.playAnim(anim, true);
		
		//handleBoppers(2);
	}
	
	public function handleBoppers(beat:Int)
	{
		// player?.onBeatHit(2);
	}
}
