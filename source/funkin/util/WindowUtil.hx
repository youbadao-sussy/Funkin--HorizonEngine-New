package funkin.util;

import lime.app.Application;
import openfl.Lib;

/**
 * Windows Setting
 */
class WindowUtil
{
	public static final HORIZON_VERSION:String = '0.1.0';
	public static final FUNKIN_VERSION:String = '0.2.7';

	public static var defaultAppTitle(get, never):String;
	
	static function get_defaultAppTitle():String return Application.current.meta['name'];
	
	public static function setTitle(?arg:String, append:Bool = false)
	{
		if (arg == null) arg = defaultAppTitle;
		
		if (append) FlxG.stage.window.title += arg;
		else FlxG.stage.window.title = arg;
    }
}