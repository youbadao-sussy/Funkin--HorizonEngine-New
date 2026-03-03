package funkin.data.ui.notes;

import funkin.data.animation.AnimationData;

typedef NoteColorData =
{
    @:default(false) var enabled:Bool;
    @:optional var RGP:Array<Int>;
}

typedef NoteStyleAssets =
{
    @:optional var note:NoteStyleAssetMeta<NoteStyleData_Note>;
    @:optional var noteStrumline:NoteStyleAssetMeta<NoteStyleData_NoteStrumline>;
    @:optional var holdNote:NoteStyleAssetMeta<NoteStyleData_HoldNote>;
}

typedef NoteStyleAssetMeta<T> =
{
    var assetPath:String;
    @:optional var scale:Float;
    @:optional var offsets:Null<Array<Float>>;
    @:optional var isPixel:Bool;
    @:optional var alpha:Float;
    @:optional var animated:Bool;
    @:optional var data:Null<T>;
}

typedef NoteStyleData_Note =
{
    var left:UnnamedAnimationData;
    var down:UnnamedAnimationData;
    var up:UnnamedAnimationData;
    var right:UnnamedAnimationData;
}

typedef NoteStyleData_Countdown =
{
  var audioPath:String;
}

typedef NoteStyleData_HoldNote =
{
}

typedef NoteStyleData_Judgement =
{
}

typedef NoteStyleData_ComboNum =
{
}

/**
 * Data on animations for each direction of the strumline.
 */
typedef NoteStyleData_NoteStrumline =
{
  var leftStatic:UnnamedAnimationData;
  var leftPress:UnnamedAnimationData;
  var leftConfirm:UnnamedAnimationData;
  var leftConfirmHold:UnnamedAnimationData;
  var downStatic:UnnamedAnimationData;
  var downPress:UnnamedAnimationData;
  var downConfirm:UnnamedAnimationData;
  var downConfirmHold:UnnamedAnimationData;
  var upStatic:UnnamedAnimationData;
  var upPress:UnnamedAnimationData;
  var upConfirm:UnnamedAnimationData;
  var upConfirmHold:UnnamedAnimationData;
  var rightStatic:UnnamedAnimationData;
  var rightPress:UnnamedAnimationData;
  var rightConfirm:UnnamedAnimationData;
  var rightConfirmHold:UnnamedAnimationData;
}

typedef NoteStyleData_NoteSplash =
{
  /**
   * If false, note splashes are entirely hidden on this note style.
   * @default Note splashes are enabled.
   */
  @:optional
  @:default(true)
  var enabled:Bool;

  @:optional
  @:default(24)
  var framerateDefault:Int;

  @:optional
  @:default(2)
  var framerateVariance:Int;

  @:optional
  @:default("normal")
  var blendMode:String;

  @:optional
  var leftSplashes:Array<String>;

  @:optional
  var downSplashes:Array<String>;

  @:optional
  var upSplashes:Array<String>;

  @:optional
  var rightSplashes:Array<String>;
};

typedef NoteStyleData_HoldNoteCover =
{
  /**
   * If false, hold note covers are entirely hidden on this note style.
   * @default Hold note covers are enabled.
   */
  @:optional
  @:default(true)
  var enabled:Bool;

  @:optional
  var left:NoteStyleData_HoldNoteCoverDirectionData;

  @:optional
  var down:NoteStyleData_HoldNoteCoverDirectionData;

  @:optional
  var up:NoteStyleData_HoldNoteCoverDirectionData;

  @:optional
  var right:NoteStyleData_HoldNoteCoverDirectionData;
};

typedef NoteStyleData_HoldNoteCoverDirectionData =
{
  /**
   * Optionally specify an asset path to use for this specific animation.
   * @:default The assetPath of the main holdNoteCover asset
   */
  @:optional
  var assetPath:String;

  @:optional
  var start:String;
  @:optional
  var hold:String;
  @:optional
  var end:String;
}