package funkin.api.modding;

class ContentHandler
{
    public static var API_VERSION(get, never):String;

    static function get_API_VERSION():String
    {
        return Constants.HORIZON_VERSION;
    }
    
    public static final API_VERSION_RULE:String = ">=1.0.0 <2.0.0";

    public function new(value) {}
}