package funkin.data.stage;

import funkin.api.modding.script.ModdingSprite;
import funkin.data.stage.StageData;
import haxe.Json;
import openfl.utils.Assets;

class StageLoader
{
	public static function dummy():StageMetadata
	{
		return {
			directory: "",
            name: "",
            cameraSpeed: 1,
            character: {
                player: {
                    zIndex: 0,
                    position: [770, 100],
                    cameraPos: [0, 0]
                }
            },

			editorMeta: {
				//OPP: "dad",
                //CNT: "gf",
				PLY: "bf"
			}
		};
	}
    
	public static var forceNextDirectory:String = null;
	public static function loadDirectory(SONG:SongMetadataMain) {
		var stage:String = '';
		if(SONG.playData.stage != null)
			stage = SONG.playData.stage;
        /*
		else if(Chart.loadedSongName != null)
			stage = vanillaSongStage(Paths.formatToSongPath(Chart.loadedSongName));
        */
		else
			stage = 'mainStage';

		var stageFile:StageMetadata = getStageFile(stage);
		forceNextDirectory = (stageFile != null) ? stageFile.directory : ''; //preventing crashes
	}
    
	public static function getStageFile(stage:String):StageMetadata
    {
		try
		{
			var path:String = Paths.getPath('data/stages/' + stage + '.json', null, true);
			// #if MODS_ALLOWED
			// if(FileSystem.exists(path))
			// 	return cast tjson.TJSON.parse(File.getContent(path));
			// #else
			if(Assets.exists(path))
				return cast tjson.TJSON.parse(Assets.getText(path));
			// #end
		}
		return dummy();
	}
    
	public static function addObjectsToState(objectList:Array<Dynamic>, gf:FlxSprite, dad:FlxSprite, boyfriend:FlxSprite, ?group:Dynamic = null, ?ignoreFilters:Bool = false)
	{
		var addedObjects:Map<String, FlxSprite> = [];
		for (num => data in objectList)
		{
			if (addedObjects.exists(data)) continue;

			switch(data.type)
			{
				case 'square', 'image', 'animatedSprite':
					// if(!ignoreFilters && !validateVisibility(data.filters)) continue;

					var spr:ModdingSprite = new ModdingSprite(data.x, data.y, data.isPixel);
					spr.ID = num;
					if(data.type != 'square')
					{
						if(data.type == 'sprite')
							spr.loadGraphic(Paths.image(data.image));
						else
							spr.frames = Paths.getAtlasFrames(data.image);
						/*
						if(data.type == 'animatedSprite' && data.animations != null)
						{
							var anims:Array<objects.Character.AnimArray> = cast data.animations;
							for (key => anim in anims)
							{
								if(anim.indices == null || anim.indices.length < 1)
									spr.animation.addByPrefix(anim.anim, anim.name, anim.fps, anim.loop);
								else
									spr.animation.addByIndices(anim.anim, anim.name, anim.indices, '', anim.fps, anim.loop);
	
								if(anim.offsets != null)
									spr.addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
	
								if(spr.animation.curAnim == null || data.firstAnimation == anim.anim)
									spr.playAnim(anim.anim, true);
							}
						}
                            */
						for (varName in ['antialiasing', 'flipX', 'flipY'])
						{
							var dat:Dynamic = Reflect.getProperty(data, varName);
							if(dat != null) Reflect.setProperty(spr, varName, dat);
						}
						if(!ClientPrefs.globalAntialiasing) spr.antialiasing = false;
					}
					else
					{
						spr.makeGraphic(1, 1, FlxColor.WHITE);
						spr.antialiasing = false;
					}

					if(data.scale != null && (data.scale[0] != 1.0 || data.scale[1] != 1.0))
					{
						spr.scale.set(data.scale[0], data.scale[1]);
						spr.updateHitbox();
					}
					spr.scrollFactor.set(data.scroll[0], data.scroll[1]);
					// spr.color = CoolUtil.colorFromString(data.color);
					
					for (varName in ['alpha', 'angle'])
					{
						var dat:Dynamic = Reflect.getProperty(data, varName);
						if(dat != null) Reflect.setProperty(spr, varName, dat);
					}

					if (group != null) group.add(spr);
					addedObjects.set(data.name, spr);

				default:
					var err = '[Stage .JSON file] Unknown sprite type detected: ${data.type}';
					trace(err);
					FlxG.log.error(err);
			}
		}
		return addedObjects;
	}

}