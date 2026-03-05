package funkin.data.song;

typedef ChartInfo =
{
    var scrollSpeed:Map<String, Float>;
	var voicesPlaying:Bool;
    var events:Array<SongEventData>;
	var notes:Array<ChartData>;
}

typedef SongEventData =
{
    /**
     * Time
     */
	var ETIME:Int;

    /**
     * Event Name
     */
	var EVENT:String;

    /**
     * Event Value
     */
	var VALUE:Dynamic;
}

typedef ChartData =
{
	var SECTION:Array<ChartNoteData>;
	var BEAT:Float;
}

typedef ChartNoteData =
{
    /**
     * Time
     */
	var TIME:Int;

    /**
     * Note Number
     */
	var ID:Int;

    /**
     * Note Length
     */
	var LENGTH:Float;

	/**
	 * Note Type
	 */
	var DATA:String;
}