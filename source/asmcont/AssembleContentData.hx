package asmcont;

typedef ContentMetadata =
{
    var modName:String;
    var description:String;
    var contributor:Array<{
        var creatorName:String;
        @:optional var about:String;
        var role:String;
        @:optional var email:String;
        @:optional var url:String;
        var note:String;
    }>;
    var global:Bool;
    var dependencies:Array<Map<String, String>>;
    var api_version:String;
    var mod_version:String;
    var iconPath:String;
    var license:String;
}

typedef ContentManager =
{
    var enabled:Array<String>;
    var disabled:Array<String>;
    var optional:Array<Map<String, String>>;
}