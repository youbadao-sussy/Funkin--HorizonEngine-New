package funkin.api.modding.script.hscript;

import crowplexus.iris.Iris;
import extensions.hscript.InterpEx;
import extensions.hscript.IrisEx;
import extensions.hscript.Sharables;

class FunkinScriptIris {
	public static final H_EXTS:Array<String> = ['hx', 'hxs', 'hscript', 'hxc'];
	public static function getPath(path:String):String
	{
		for (extension in H_EXTS)
		{
			final file = '$path.$extension';

			final targetPath = Paths.getPath(file, null, true);
			if (FunkinAssets.exists(targetPath))
				return targetPath;
		}
		return path;
	}

	/**
	 * Helper to check if a path ends with a support hx extension
	 */
	public static function isHxFile(path:String):Bool
	{
		for (extension in H_EXTS)
			if (path.endsWith(extension))
				return true;

		return false;
	}

	/**
	 * Initiates the debugging backend of Iris
	 */
	public static function init()
	{
		Iris.warn = (x, ?pos) ->
		{
			final output:String = '[${pos.fileName}:${pos.lineNumber}]: $x';

			DebugTextPlugin.addText(Std.string(output), Logger.getHexColourFromSeverity(WARN));

			Iris.logLevel(ERROR, x, pos);
		}

		Iris.error = (x, ?pos) ->
		{
			final output:String = '[${pos.fileName}:${pos.lineNumber}]: $x';

			DebugTextPlugin.addText(Std.string(output), Logger.getHexColourFromSeverity(ERROR));

			Iris.logLevel(NONE, x, pos);
		}

		Iris.print = (x, ?pos) ->
		{
			final output:String = '[${pos.fileName}:${pos.lineNumber}]: $x';

			DebugTextPlugin.addText(Std.string(output), Logger.getHexColourFromSeverity(PRINT));

			Iris.logLevel(NONE, x, pos);
		}
	}
}