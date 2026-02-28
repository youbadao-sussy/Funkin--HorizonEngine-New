package polycontent;

typedef ContentMetadata =
{
    var modName:String;
    var description:String;
}

typedef ContentManager =
{
    var enabled:Array<String>;
    var disabled:Array<String>;
    var optional:Array<Map<String, String>>;
}