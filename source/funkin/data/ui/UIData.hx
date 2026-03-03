package funkin.data.ui;

import funkin.data.ui.notes.NotesData;

typedef SkinDataInfo =
{
    var name:String; // for example: funkin'
    var folderPath:String; // for example: funkin
    var author:String;
    //var color:NoteColorData;
    @:optional var fallbacks:Null<String>;
    var noteAssets:NoteStyleAssets;
    var generatedBy:String;
}
