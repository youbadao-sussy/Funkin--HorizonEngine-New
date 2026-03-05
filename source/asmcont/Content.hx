package asmcont;


typedef AsmcontParam =
{
    var modRoot:String;
}

class ContentHandler {
    public function new(value) {}

    public static function init(params:AsmcontParam)
    {
        var contentRoot = params.modRoot;
    }
}