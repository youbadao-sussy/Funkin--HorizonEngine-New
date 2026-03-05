package funkin.data.song;


import funkin.data.song.SongData;
import funkin.data.song.SongMetadata;
import haxe.Json;
import lime.utils.Assets;

/**
 * Unfinished it
 */
enum abstract ChartGenerator(String) to String
{
    var HORIZON = 'Horizon Engine'; // default.
	var VSLICE = 'V-Slice'; // V-slice.
	var PSYCH = 'Psych_1.0'; // I want to make it.
	// var CNE = 'Codename Engine'; // awwww... its still undecided...
}

class Chart {
    // _________________________ Metadata __________________________
    public var oppSinger:String = 'dad';
    public var cntSinger:String = 'gf';
    public var plySinger:String = 'dad';
    
	public static var chartPath:String;
	public static var loadedSongName:String;

    // _______________________ Charting Data _______________________
    public var song:String;
    public var notes:Array<ChartData>;
    public var events:Array<Dynamic>;
    public var bpm:Float;
    public var needsVoices:Bool = false;
    public var noteSpeed:Float = 2;
    public var generator:String = 'Horizon Engine';
    // _____________________________________________________________
    // _____________________________________________________________

    public function new(value) {}

    public function convert(songJson:Dynamic) {}

    public function loadJson(jsonInput:String, ?folder:String):ChartInfo
	{
		if(folder == null) folder = jsonInput;
		PlayState.SONG = getChart(jsonInput, folder);
		loadedSongName = folder;
		chartPath = _lastPath;
		#if windows
		// prevent any saving errors by fixing the path on Windows (being the only OS to ever use backslashes instead of forward slashes for paths)
		chartPath = chartPath.replace('/', '\\');
		#end
		StageLoader.loadDirectory(PlayState.METADATA);
		return PlayState.SONG;
	}
    
	static var _lastPath:String;
	public static function getChart(jsonInput:String, ?folder:String):ChartInfo
	{
		if(folder == null) folder = jsonInput;
		var rawData:String = null;
		
		var formattedFolder:String = Paths.formatToSongPath(folder);
		var formattedSong:String = Paths.formatToSongPath(jsonInput);
		_lastPath = Paths.json('$formattedFolder/$formattedSong');

		#if MODS_ALLOWED
		if(FileSystem.exists(_lastPath))
			rawData = File.getContent(_lastPath);
		else
		#end
			rawData = Assets.getText(_lastPath);

		return rawData != null ? parseJSON(rawData, jsonInput) : null;
	}
    
	public static function parseJSON(rawData:String, ?nameForError:String = null, ?convertTo:String = 'psych_v1'):ChartInfo
	{
		var songJson:ChartInfo = cast Json.parse(rawData);
		if(Reflect.hasField(songJson, 'song'))
		{
			var subSong:ChartInfo = Reflect.field(songJson, 'song');
			if(subSong != null && Type.typeof(subSong) == TObject)
				songJson = subSong;
		}

        /*
		if(convertTo != null && convertTo.length > 0)
		{
			var fmt:String = songJson.format;
			if(fmt == null) fmt = songJson.format = 'unknown';

			switch(convertTo)
			{
				case 'psych_v1':
					if(!fmt.startsWith('psych_v1')) //Convert to Psych 1.0 format
					{
						trace('converting chart $nameForError with format $fmt to psych_v1 format...');
						songJson.format = 'psych_v1_convert';
						convert(songJson);
					}
			}
		}
            */
		return songJson;
	}
}