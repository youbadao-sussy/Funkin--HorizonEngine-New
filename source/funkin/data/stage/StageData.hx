package funkin.data.stage;

import funkin.data.animation.AnimationData;

typedef StageMetadata =
{
	var directory:String;
    var name:String;
	var cameraSpeed:Float;
    var character:BGCharacterMetadata;
	@:optional var props:Array<StageObject>;
	@:optional var editorMeta:EditorMeta;
}

typedef EditorMeta =
{
	// var OPP:String;
	// var CNT:String;
	var PLY:String;
}

typedef BGCharacterMetadata =
{
    var player:BGCharacterData;
}

typedef BGCharacterData =
{
    var zIndex:Int;
	var position:Array<Float>;
	var cameraPos:Array<Float>;
}

typedef StageObject =
{
    /**
     * Object CallName / オブジェクトの呼び名
     */
    var name:String;

    /**
     * Object Typ / オブジェクトの種類
     * @default 'image'
     */
	@:optional var assetType:String; // image, sprite, player(ply), opponent(opp), centerChar(cntr)
    
    /**
     * Object's Asset Path / オブジェクトのファイルパス
     */
    var assetPath:String;

    /**
     * Object Scale / オブジェクトの大きさ
     * @default [1.0, 1.0]
     */
    var scale:Array<Float>;

    /**
     * Object Scroll Factor / オブジェクトのスクロール変動数
     * @default [1.0, 1.0]
     */
    @:optional var scroll:Array<Int>;

    /**
     * Object Position / オブジェクトの位置
     */
    var objPosition:Array<Float>;

    /**
     * Antialias Disabled / 画像をギザギザにするか
     * @default false
     */
    @:optional var isPixel:Bool;

    /**
     * Z Index / z座標の数字
     * @default 0
     */
    @:optional var zIndex:Int;

    /**
     * animation / あにめーしょん
     */
    @:optional var animation:Array<AnimationData>;
}