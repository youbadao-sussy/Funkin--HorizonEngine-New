package funkin.play.ui.notes;

import funkin.data.ui.notes.NotesData;
import funkin.play.ui.UISkin;

class NoteSprite extends FlxSprite
{
	public var defaultNoteTypes:Array<String> = ['', 'Alt Animation', 'Hey!', 'Hurt Note', 'GF Sing', 'No Animation'];
    public var strumTime:Float = 0;
    public var noteData:Int = 0;

	public var mustPress:Bool = false;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;

    public function new(strumTime:Float, noteData:Int, ?prevNote:NoteSprite, ?sustainNote:Bool = false, ?inEditor:Bool = false, ?createdFrom:Dynamic = null)
    {
	    super();
        
		antialiasing = ClientPrefs.globalAntialiasing;
    }
}