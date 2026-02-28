package funkin.data.song;

typedef ChartInfo =
{
    var scrollSpeed:Map<String, Float>;
    var events:Array<SongEventData>;
    var notes:Map<String, Array<ChartData>>;
}

typedef SongEventData =
{
    /**
     * Time
     */
    var T:Int;

    /**
     * Event Name
     */
    var E:String;

    /**
     * Event Value
     */
    var V:Dynamic;
}

typedef ChartData =
{
    /**
     * Time
     */
    var T:Int;

    /**
     * Note Number
     */
    var D:Int;

    /**
     * Note Length
     */
    var L:Float;
}