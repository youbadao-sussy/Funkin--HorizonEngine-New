package funkin.play.ui;

import funkin.data.ui.UIData;
import funkin.data.ui.notes.NotesData.NoteStyleAssets;

/*
class UISkin
{
	public static final DEFAULT_UI:String = 'funkin';

    public var uiImage:String = '';
    public var jsonPath:String = '';

    public static function skinNew(skin:String, id:String)
    {
        var jsonPath = Paths.getPath('data/ui/' + skin + '.json');
        var data = id;

        var rauUI:String = '';
        
		try
		{
			rawUI = FunkinAssets.getContent(jsonPath);
		}
		catch (e) {}
        
		final rawJson:Null<Any> = FunkinAssets.parseJson5(rawUI);

        if (id == 'notes')
            uiNoteData(rawJson);
    }

    static function uiNoteData(data:Null<Dynamic>):NoteStyleAssets
    {
        final baseNoteMeta:NoteStyleAssets = getTemplateMeta();

        if (data == null) return baseNoteMeta;
    }

    static function getTemplateNoteMeta():NoteStyleAssets
    {
        return {
            note: {
                assetPath: "notes/notes",
                scale: 0.7,
                data: {
                    left: {prefix: "noteLeft"},
                    down: {prefix: "noteDown"},
                    up: {prefix: "noteUp"},
                    right: {prefix: "noteRight"},
                }
            },
            noteStrumline: {
                assetPath: ""
            },
            holdNote: {}
        }
    }
}
    */