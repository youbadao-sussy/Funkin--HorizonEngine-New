package funkin.play;

import flixel.FlxObject;
import flixel.group.FlxContainer.FlxTypedContainer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxStringUtil;
import funkin.data.stage.StageData.StageMetadata;
import haxe.Timer;
import haxe.ds.Vector;
import openfl.events.KeyboardEvent;

class PlayState extends MusicBeatState
{
	public static var SONG:ChartInfo = null;
	public static var METADATA:SongMetadataMain = null;
	
	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;
	public var camOther:FlxCamera;
	public var cameraSpeed:Float = 1;
	
	public var defaultCamZoom:Float = 1.05;
	public var defaultHudZoom:Float = 1;

	public var curStage:String = '';

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
	function applyStageData(file:Null<StageMetadata>):Void
	{
		if (file == null)
			return;

		defaultCamZoom = METADATA.playData.songStartCamera.zoom ?? 1.0;
		FlxG.camera.zoom = METADATA.playData.songStartCamera.zoom ?? 1.0;
		// isPixelStage = file.isPixelStage;

		PLY_X = file.character.player.position[0];
		PLY_Y = file.character.player.position[1];

		/*
			GF_X = file.girlfriend[0];
			GF_Y = file.girlfriend[1];

			DAD_X = file.opponent[0];
			DAD_Y = file.opponent[1];
		 */

		/*
		if (file.cameraSpeed != null)
			cameraSpeed = file.cameraSpeed;
		 */

		playerCameraOffset = file.character.player.cameraPos ?? [0, 0];

		/*
			opponentCameraOffset = file.camera_opponent ?? [0, 0];

			girlfriendCameraOffset = file.camera_girlfriend ?? [0, 0];
		 */

		plyGroup ??= new FlxSpriteGroup();
		plyGroup.x = PLY_X;
		plyGroup.y = PLY_Y;

		/*
			dadGroup ??= new FlxSpriteGroup();
			dadGroup.x = DAD_X;
			dadGroup.y = DAD_Y;

			gfGroup ??= new FlxSpriteGroup();
			gfGroup.x = GF_X;
			gfGroup.y = GF_Y;
		 */

		// plyGroup.zIndex = file.character.player.zIndex ?? 0;
		/*
			dadGroup.zIndex = file.dadZIndex ?? 0;
			gfGroup.zIndex = file.gfZIndex ?? 0;
		 */
	}

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

		curStage = METADATA.playData.stage;

		var stageData:StageMetadata = StageLoader.getStageFile(curStage);
		applyStageData(stageData);
		
		player = new Character('bf', true);
		startCharacterPos(player);
		plyGroup.add(player);
		plyMap.set(player.curCharacter, player);

		
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
	public function addCharacterToList(newCharacter:String, type:Int)
	{
		switch (type)
		{
			case 0:
				if (!plyMap.exists(newCharacter))
				{
					var newPlayer:Character = new Character(0, 0, newCharacter, true);
					plyMap.set(newCharacter, newPlayer);
					plyGroup.add(newPlayer);
					startCharacterPos(newPlayer);
					newPlayer.alpha = 0.00001;
					// startCharacterScripts(newPlayer.curCharacter);
				}
				/*
					case 1:
						if(!dadMap.exists(newCharacter)) {
							var newDad:Character = new Character(0, 0, newCharacter);
							dadMap.set(newCharacter, newDad);
							dadGroup.add(newDad);
							startCharacterPos(newDad, true);
							newDad.alpha = 0.00001;
							startCharacterScripts(newDad.curCharacter);
						}

					case 2:
						if(gf != null && !gfMap.exists(newCharacter)) {
							var newGf:Character = new Character(0, 0, newCharacter);
							newGf.scrollFactor.set(0.95, 0.95);
							gfMap.set(newCharacter, newGf);
							gfGroup.add(newGf);
							startCharacterPos(newGf);
							newGf.alpha = 0.00001;
							startCharacterScripts(newGf.curCharacter);
						}
				 */
		}
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
	override public function beatHit()
	{
		super.beatHit();
		handleBoppers(curBeat);
	}
	
	function noteHit(anim:String):Void
	{
		
		// final char:Null<Character> = note.gfNote ? gf : note.owner ?? field.owner;
		
		player.playAnim(anim, true);
		
		//handleBoppers(2);
	}
	
	public function handleBoppers(beat:Int)
	{
		player?.onBeatHit(beat);
	}
}
