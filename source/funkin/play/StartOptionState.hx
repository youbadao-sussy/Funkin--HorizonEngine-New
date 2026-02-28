package funkin.play;

import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

class StartOptionState {
	public static var leftState:Bool = false;
	var curSel = 0;
	var warnText:FlxText;
	var descText:FlxText;
	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;
	var enabled:Array<Dynamic> = [true, false, true, 'en-US', false];
	var goBackNum = 3; // make this the last num in the array
	var optionShit =
	[['Flashing Lights', 'Enables flashing lights.'],
	['Low Quality', 'Less background elements, increased performance.'],
	['Discord Presence', 'Shows the real name of the song you\'re playing in Discord.'],
	['Language', 'Select your language.'],
	['Start Game', 'Saves settings and starts the game.']];
	var menuItems:FlxTypedGroup<FlxText>;
}