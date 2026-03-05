package funkin.util;

import lime.app.Application;
import openfl.Lib;

/**
 * Windows Setting
 */
class WindowUtil
{
	public static var defaultAppTitle(get, never):String;
	
	static function get_defaultAppTitle():String return Application.current.meta['name'];
	
	public static function setTitle(?arg:String, append:Bool = false)
	{
		if (arg == null) arg = defaultAppTitle;
		
		if (append) FlxG.stage.window.title += arg;
		else FlxG.stage.window.title = arg;
    }
}