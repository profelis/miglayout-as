package deep
{
import deep.migLayout.flash.FlashContainerWrapper;
import deep.migLayout.flash.FlashMigLayout;

import fl.controls.Button;
import fl.controls.TextInput;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

public class FlashMain extends Sprite
{
    private var containerWrapper:FlashContainerWrapper;

    public function FlashMain()
    {
        construct();
    }

    private function construct():void
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        var layout:FlashMigLayout = new FlashMigLayout("debug, wrap 4, ins 20", "[align right][grow][][grow]");
        containerWrapper = new FlashContainerWrapper(this, layout);

        var lblFirstName:TestTextField = new TestTextField("Fist name");
        containerWrapper.addChild(lblFirstName);

        var textField:TestTextField = new TestTextField("", true);
        containerWrapper.addChild(textField, "grow");

        var lblNewLabel_1:TestTextField = new TestTextField("Surname");
        containerWrapper.addChild(lblNewLabel_1);

        var textField_1:TextInput = new TextInput();
        containerWrapper.addChild(textField_1, "grow");

        var lblNewLabel:TestTextField = new TestTextField("Adress");
        containerWrapper.addChild(lblNewLabel);

        var textField_2:TestTextField = new TestTextField("", true);
        containerWrapper.addChild(textField_2, "sx 3, grow");

        var ok:Button = new Button();
        ok.label = "Send form";
        containerWrapper.addChild(ok, "sx 4, align right, gaptop 10");


        containerWrapper.invalidate();
        stage.addEventListener(Event.RESIZE, resizeHandler);
    }


    private function resizeHandler(event:Event):void
    {
        containerWrapper.invalidate();
    }

}
}