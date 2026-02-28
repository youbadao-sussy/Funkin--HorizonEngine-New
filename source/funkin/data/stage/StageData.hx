package funkin.data.stage;

import funkin.data.animation.AnimationData;

typedef StageMetadata =
{
    var name:String;
    var cameraDefZoom:Float;
    var character:BGCharacterMetadata;
    var props:Array<StageObject>;
}

typedef BGCharacterMetadata =
{
    var player:BGCharacterData;
}

typedef BGCharacterData =
{
    var zIndex:Int;
    var offsets:Array<Float>;
    var cameraOffsets:Array<Float>;
}

typedef StageObject =
{
    /**
     * Object CallName / オブジェクトの呼び名
     */
    var name:String;

    /**
     * Object Typ / オブジェクトの種類
     */
    @:optional @:default('image') var assetType:String; // image, sprite, player(ply), opponent(opp), centerChar(cntr)
    
    /**
     * Object's Asset Path / オブジェクトのファイルパス
     */
    var assetPath:String;

    /**
     * Object Scroll Factor / オブジェクトのスクロール変動数
     */
    @:optional @:default([1.0, 1.0]) var scroll:Array<Int>;

    /**
     * Object Position / オブジェクトの位置
     */
    var offsets:Array<Float>;

    /**
     * Antialias Disabled / 画像をギザギザにするか
     */
    @:optional @:default(false) var isPixel:Bool;

    /**
     * Z Index / z座標の数字
     */
    @:optional @:default(0) var zIndex:Int;

    @:optional @:default([]) var animation:Array<AnimationData>;
}