#if !macro
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import funkin.Paths;
import funkin.backend.CustomFader;
import funkin.backend.PlayerSettings;
import funkin.backend.game.Rating;
import funkin.backend.save.ClientPrefs;
import funkin.backend.states.MusicBeatState;
import funkin.backend.states.MusicBeatSubstate;
import funkin.data.Controls;
import funkin.data.song.Chart;
import funkin.data.song.SongData;
import funkin.data.song.SongMetadata;
import funkin.data.stage.StageLoader;
import funkin.object.Character;
import funkin.play.PlayState;
import funkin.util.CameraUtil;
import funkin.util.Constants;
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