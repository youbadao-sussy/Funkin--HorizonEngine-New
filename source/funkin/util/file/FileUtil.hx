package funkin.util.file;

import haxe.io.Path;
import haxe.ui.containers.dialogs.Dialog.DialogButton;
import haxe.ui.containers.dialogs.Dialogs.FileDialogExtensionInfo;
import haxe.ui.containers.dialogs.Dialogs.SelectedFileInfo;
import haxe.ui.containers.dialogs.Dialogs;
import haxe.zip.Entry;
import lime.ui.FileDialog;
import lime.utils.Bytes;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileFilter;
import openfl.net.FileReference;


class FileUtil
{
    public static final FILE_FILTER_HRC:FileFilter = new FileFilter("FNF' Horizon Engine Chart (.hrc)", "*.fnfc");
    public static final FILE_FILTER_JSON:FileFilter = new FileFilter("JSON Data File (.json)", "*.json");
    public static final FILE_FILTER_ZIP:FileFilter = new FileFilter("ZIP Archive (.zip)", "*.zip");
    public static final FILE_FILTER_PNG:FileFilter = new FileFilter("PNG Image (.png)", "*.png");
    public static final FILE_FILTER_FNFS:FileFilter = new FileFilter("FNF' Horizon Engine Stage (.fnfs)", "*.fnfs");

    
    public static final FILE_EXTENSION_INFO_FNFC:FileDialogExtensionInfo = {
        extension: 'hrc',
        label: 'Friday Night Funkin\' Chart',
    };
    public static final FILE_EXTENSION_INFO_ZIP:FileDialogExtensionInfo = {
        extension: 'zip',
        label: 'ZIP Archive',
    };
    public static final FILE_EXTENSION_INFO_PNG:FileDialogExtensionInfo = {
        extension: 'png',
        label: 'PNG Image',
    };

    public static final FILE_EXTENSION_INFO_FNFS:FileDialogExtensionInfo = {
        extension: 'hrs',
        label: 'Friday Night Funkin\' Stage',
    };


    public static var PROTECTED_PATHS(get, never):Array<String>;

    public static function get_PROTECTED_PATHS():Array<String>
    {
        final protected:Array<String> = ['', '.', 'assets', 'assets/*', 'backups', 'backups/*', 'manifest', 'manifest/*', 'plugins', 'plugins/*', 'Friday Night Funkin.exe', 'Friday Night Funkin', 'icon.ico', 'libvlc.dll', 'libvlccore.dll', 'lime.ndll', 'scores.json'];

        #if sys
        for (i in 0...protected.length)
        {
            protected[i] = sys.FileSystem.fullPath(Path.join([gameDirectory, protected[i]]));
        }
        #end

        return protected;
    }

    public function new(value) {}
}