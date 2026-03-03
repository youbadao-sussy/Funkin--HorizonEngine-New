package funkin.data.animation;

typedef AnimationData =
{
	> UnnamedAnimationData,
	var name:String;
}

typedef UnnamedAnimationData =
{
    @:optional var assetPath:String;
    @:optional var type:String;
    var prefix:String;
    @:optional var indices:Array<Int>;
    @:optional @:default(24) var frameRate:Int;
    @:optional var looped:Bool;
    @:optional var offsets:Array<Float>;
    @:optional @:default(false) var flipX:Bool;
    @:optional @:default(false) var flipY:Bool;
}