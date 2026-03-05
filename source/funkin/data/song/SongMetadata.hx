package funkin.data.song;

// _________________ Main Data ___________________________
typedef SongMetadataMain =
{
    var version:String;
    var songName:String;
    var songStuff:SongStuff;
    var contributor:SongCredits;
    var playData:SongPlayData;
    var generatedBy:String;
}

typedef SongPlayData =
{
    var difficulties:Array<String>;
    @:optional var variations:Array<String>;
    var characters:SongCharacterDataHead;
    var audio:SongAudioData;
    var stage:String;
    var songStartCamera:SongCameraStartData;
    var noteStyle:String;
}

// _________________ Sub Data ___________________________
typedef SongCharacterDataHead =
{
    var opponent:SongCharacterDataBody;
    var center:SongCharacterDataBody;
    var player:SongCharacterDataBody;
}

typedef SongCharacterDataBody =
{
    var id:String;
    @:optional var color:SongCharacterColorData;
}

typedef SongCharacterColorData =
{
    var hue:Int;
    var saturation:Int;
    var brightness:Int;
    var contrast:Int;
}

typedef SongAudioData =
{
    var splitVocals:Bool;
    @:optional var altInstrumentals:Array<String>;
    @:optional var opponentVocals:Array<String>;
    @:optional var playerVocals:Array<String>;
}

typedef SongCameraStartData =
{
    var zoom:Float;
    @:optional var focus:String;
    @:optional var offsets:Array<Float>;
}

typedef SongStuff =
{
    var bpm:Float;
    var beat:Array<Int>;
}

typedef SongCredits =
{
    var music:String;
    @:optional var chart:String;
    @:optional var art:String;
    @:optional var code:String;
}