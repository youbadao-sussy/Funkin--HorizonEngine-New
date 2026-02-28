#if !macro
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import funkin.Paths;
import funkin.backend.PlayerSettings;
import funkin.backend.save.ClientPrefs;
import funkin.data.Controls;
import funkin.object.Character;
import funkin.util.CameraUtil;
import funkin.util.WindowUtil;

using StringTools;
#if sys
import sys.*;
import sys.io.*;
#end
#if VIDEOS_ALLOWED
import hxvlc.flixel.*;
#end
#end