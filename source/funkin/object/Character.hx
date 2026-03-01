package funkin.object;

import funkin.data.animation.AnimationData;
import funkin.data.character.CharacterData.CharacterMetadata;
import funkin.data.character.CharacterData.CharacterParser;
import funkin.data.character.CharacterData.CharacterRenderType;
import funkin.data.character.CharacterData.DeathData;
import funkin.data.character.CharacterData.IconData;

class Character extends Bopper
{
	public static final DEFAULT_CHARACTER:String = 'bf';

	/**
	 * how much the camera moves with the characters sings animations
	 */
	public var camDisplacement:Float = 20;
    
	public var curCharacter:String = DEFAULT_CHARACTER;

	/**
	 * is the player character
	 */
	public var isPlayer:Bool = false;

    public var charName:String = '';
	
	public var holdTimer:Float = 0;
	
	public var animTimer:Float = 0;
	public var specialAnim:Bool = false;
	public var stunned:Bool = false;

	public var singDuration:Float = 8;
	
	public var animSuffix:String = '';
	public var animSuffixExclusions = ['idle', 'danceLeft', 'danceRight', 'miss'];
    
	public var danceIdle:Bool = false;
    
	public var forceDance:Bool = false;
	
	public var skipDance:Bool = false;

	public var healthIcon:IconData;
    
	public var imageFile:String = '';
    public var imageType:String = '';
	public var jsonScale:Float = 1;
	
	public var noAntialiasing:Bool = false;
	public var originalFlipX:Bool = false;
    
	public var debugMode:Bool = false;
	
	public var animations:Array<AnimationData> = [];

    public var positionOffset:Array<Float> = [0, 0];
    public var cameraOffset:Array<Float> = [0, 0];

    public var idleLength:Int = 2;

	public var vSliceSustains = false;
	public var doubleGhost = false;
    
	public function new(x:Float = 0, y:Float = 0, character:String = 'bf', playable:Bool = false)
	{
		super(x, y);
		
		this.curCharacter = character;
		this.isPlayer = playable;
		
		initCharacter(CharacterParser.charInfo(curCharacter));
	}

    public function initCharacter(json:CharacterMetadata)
    {
		animOffsets.clear();
        scale.set(1, 1);
		updateHitbox();

        this.charName = json.name;

		this.jsonScale = json.scale;
        this.positionOffset = json.offsets;
        this.cameraOffset = json.cameraOffsets;

        this.singDuration = json.singDuration;
        this.vSliceSustains = json.sustainStopAnim;
        this.doubleGhost = json.ghostEffect;
        this.noAntialiasing = json.isPixel;

		this.flipX = json.flipX;
        this.originalFlipX = (json.flipX == true);
        this.imageType = json.renderType;
        this.imageFile = json.assetPath;

		this.antialiasing = !noAntialiasing && ClientPrefs.globalAntialiasing;

        this.idleLength = json.idleBeat ?? 2;

		loadAtlas(imageFile);

        if (jsonScale != 1) {
            scale.set(jsonScale, jsonScale);
		    updateHitbox();
        }
        
		this.animations = json.animations;
		if (animations != null && animations.length > 0)
		{
			for (anim in animations) // anim内の関数がanimationsに入っている場合?ってこと?
			{
				final animName:String = '' + anim.animName;
				final animPrefix:String = '' + anim.prefix;
				final animFps:Int = anim.frameRate;
				final animLoop:Bool = !!anim.looped; // Bruh
				final animIndices:Array<Int> = anim.indices ?? [];
				
				final flipX = anim.flipX ?? false;
				final flipY = anim.flipY ?? false;
				
				if (animIndices.length > 0)
				{
					if (anim.frameRate == null)
						addAnimByIndices(animName, animPrefix, animIndices, 24, animLoop, flipX, flipY);
					else
						addAnimByIndices(animName, animPrefix, animIndices, animFps, animLoop, flipX, flipY);
				}
				else
				{
					if (anim.frameRate == null)
						addAnimByPrefix(animName, animPrefix, 24, animLoop, flipX, flipY);
					else
						addAnimByPrefix(animName, animPrefix, animFps, animLoop, flipX, flipY);
				}
				
				if (anim.offsets != null && anim.offsets.length > 1)
				{
					addOffset(anim.animName, anim.offsets[0], anim.offsets[1]);
				}
			}
		}
		else
		{
			addAnimByPrefix('idle', 'BF idle dance', 24, false);
		}

        // this.healthIcon = json.healthIcon

	
        dance(forceDance);
    }
	
	override function update(elapsed:Float)
	{
		if (debugMode || isAnimNull())
		{
			super.update(elapsed);
			return;
		}
		
		if (animTimer > 0)
		{
			animTimer -= elapsed;
			if (animTimer <= 0)
			{
				animTimer = 0;
				dance(forceDance);
			}
		}
		
		if (specialAnim && isAnimFinished())
		{
			specialAnim = false;
			dance(forceDance);
		}
		else if (getAnimName().endsWith('miss') && isAnimFinished())
		{
			dance(forceDance);
			finishAnim();
		}
		
		if (isPlayer && getAnimName().startsWith('sing'))
		{
			holdTimer += elapsed;
		}
		else if (isPlayer)
			holdTimer = 0;
		
		//if (!isPlayer && holdTimer >= Conductor.stepCrotchet * 0.0011 * singDuration)
		if (!isPlayer && holdTimer >= ((60 / 150) * 1000) / 4 * 0.0011 * singDuration)
		{
			dance(forceDance);
			holdTimer = 0;
		}
		
		if (isAnimFinished() && hasAnim(getAnimName() + '-loop')) playAnim(getAnimName() + '-loop');
		
		/*
		if (ghostsEnabled)
		{
			for (ghost in doubleGhosts)
				ghost.update(elapsed);
		}
			*/
		
		super.update(elapsed);
	}
    
	override function dance(forced:Bool = false)
	{
		if (debugMode || specialAnim) return;
		super.dance(forced);
	}
	
	override function playAnim(animToPlay:String, isForced:Bool = false, isReversed:Bool = false, frame:Int = 0)
	{
		specialAnim = false;
		animToPlay += animSuffix;
		
		super.playAnim(animToPlay, isForced, isReversed, frame);
		
		if (!debugMode
			&& ((isPlayer && flipX == originalFlipX) || (!isPlayer && flipX != originalFlipX))) // rewrite this condition later maybe
		{
			var appliedOffset = offset.x;
			
			final frameWidth = animateAtlas?.frameWidth ?? frameWidth;
			
			final scaleFactor = scalableOffsets ? scale.x : 1.0;
			
			offset.x = ((frameWidth * scaleFactor) - this.width) - appliedOffset;
		}
		
		if (flipY) // maybe a corrected offsets var
		{
			var appliedOffset = offset.y;
			
			final frameHeight = animateAtlas?.frameHeight ?? frameHeight;
			
			final scaleFactor = scalableOffsets ? scale.y : 1.0;
			
			offset.y = ((frameHeight * scaleFactor) - this.height) - appliedOffset;
		}
		
		offset.degrees += angle;
	}

	override function onBeatHit(beat:Int)
	{
		if (stunned || getAnimName().startsWith('sing')) return;
		super.onBeatHit(beat);
	}
}