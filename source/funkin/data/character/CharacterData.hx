package funkin.data.character;

import funkin.data.animation.AnimationData;

typedef CharacterMetadata =
{
    /**
     * Display name in the chart editor
     */
    var name:String;

    /**
     * Assets File Path
     */
    var assetPath:String;

    /**
     * Sprite File Type
     */
    var renderType:CharacterRenderType;

    /**
     * If enabled, Anti-alias dose not apply
     */
    var isPixel:Bool;

    /**
     * X Flip
     */
    var flipX:Bool;

    /**
     * Position Offsets
     */
    var offsets:Array<Float>;

    /**
     * Camera Offsets
     */
    var cameraOffsets:Array<Float>;

    /**
     * Idling Beat
     */
    var idleBeat:Int;

    /**
     * Singing Time
     */
    var singDuration:Float;

    /**
     * V Slice Sustain
     */
    var sustainStopAnim:Bool;

    /**
     * Double Note Ghost
     */
    var ghostEffect:Bool;
    
    /**
     * Icon Data
     */
    var healthIcon:IconData;

    /**
     * Death Screen Data
     */
    var deathData:DeathData;

    /**
     * Sprite Scale
     */
    var scale:Float;

    /**
     * Animation Data
     */
    var animations:Array<AnimationData>;
}


typedef DeathData =
{
    /**
     * The amount to offset the camera by while focusing on this character as they die.
     * Default value focuses on the character's graphic midpoint.
     * @default [0, 0]
     */
    var ?cameraOffsets:Array<Float>;

    /**
     * The amount to zoom the camera by while focusing on this character as they die.
     * Value is a multiplier of the default camera zoom for the stage.
     * @default 1.0
     */
    var ?cameraZoom:Float;

    /**
     * Impose a delay between when the character reaches `0` health and when the death animation plays.
     * @default 0.0
     */
    var ?preTransitionDelay:Float;
}

typedef IconData =
{
    var id:String;
    /*
    @:optional @:default(1) var scale:Float;
    @:optional @:default(0) var angle:Int;
    @:optional @:default(false) var flipX:Bool;
    @:optional @:default(false) var isPixel:Bool;
    @:optional @:default(0, 0) var offsets:Array<Float>;
    */
    // var animation:Bool
}


/**
 * Describes the available rendering types for a character.
 */
enum abstract CharacterRenderType(String) from String to String
{
  /**
   * Renders the character using a single spritesheet and XML data.
   */
  public var Sparrow = 'sparrow';

  /**
   * Renders the character using a single spritesheet and TXT data.
   */
  public var Packer = 'packer';

  /**
   * Renders the character using multiple spritesheets and XML data.
   */
  public var MultiSparrow = 'multisparrow';

  /**
   * Renders the character using a single spritesheet of symbols and JSON data.
   */
  public var AnimateAtlas = 'animateatlas';

  /**
   * Renders the character using multiple spritesheets of symbols and JSON data.
   */
  public var MultiAnimateAtlas = 'multianimateatlas';

  /**
   * Renders the character using a custom method.
   */
  public var Custom = 'custom';
}

class CharacterParser
{
    public static function charInfo(id:String):CharacterMetadata
    {
        var charPath = Paths.findFileWithExts('data/characters/$id', ['json']);
		
		if (!FunkinAssets.exists(charPath)) charPath = Paths.findFileWithExts('characters/$id', ['json']);
		
		if (!FunkinAssets.exists(charPath)) charPath = Paths.getDirectoryPath('data/characters/${Character.DEFAULT_CHARACTER}.json');
        
		var raw:String = '';
		
		try
		{
			raw = FunkinAssets.getContent(charPath);
		}
		catch (e) {}
		
		final rawJson:Null<Any> = FunkinAssets.parseJson5(raw);
		
		return validateData(rawJson);
    }
    
	static function validateData(data:Null<Dynamic>):CharacterMetadata
	{
		final baseInfo:CharacterMetadata = getTemplateCharInfo();
		
		if (data == null) return baseInfo;
		
        data.name ??= baseInfo.name;
        data.assetPath ??= baseInfo.assetPath;
        data.renderType ??= baseInfo.renderType;
        data.isPixel ??= baseInfo.isPixel;
        data.flipX ??= baseInfo.flipX;
        data.offsets ??= baseInfo.offsets;
        data.cameraOffsets ??= baseInfo.cameraOffsets;
        data.idleBeat ??= baseInfo.idleBeat;
        data.idleBeat ??= baseInfo.idleBeat;
        data.idleBeat ??= baseInfo.idleBeat;
        data.ghostEffect ??= baseInfo.ghostEffect;
        data.healthIcon ??= baseInfo.healthIcon;
        data.deathdata ??= baseInfo.deathData;
        data.scale ??= baseInfo.scale;
        data.animations ??= baseInfo.animations;
		
		return cast data;
	}
    
	static function getTemplateCharInfo():CharacterMetadata
	{
		return {
            name: 'Boyfriend',
			assetPath: 'characters/bf/BOYFRIEND',
            renderType: 'sparrow',
			isPixel: false,
			flipX: false,
			offsets: [0, 0],
			cameraOffsets: [0, 0],
			idleBeat: 2,
			singDuration: 8,
			sustainStopAnim: true,
			ghostEffect: false,
			healthIcon: {
                id: 'face'
            },
            deathData: {
                cameraOffsets: [0, 0]
            },
			scale: 1,
			animations: []
		};
	}
}