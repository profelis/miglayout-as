package deep
{
import deep.migLayout.flash.FlashContainerWrapper;
import deep.migLayout.flash.MigLayout;
import deep.tests.HorizontalTest;

import fl.controls.Button;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class Tests extends Sprite
{
    private var tests:Vector.<TestData> = new Vector.<TestData>();
    private var testView:DisplayObject;
    private var menu:Sprite;

    public function Tests()
    {
        super();

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        registerTest("Horizontal", HorizontalTest);

        init();
    }

    private function init():void
    {
        menu = new Sprite();
        addChild(menu);
        var menuLayout:MigLayout = new MigLayout("wrap, ins 0", "[left]", "");
        var menuContainer:FlashContainerWrapper = new FlashContainerWrapper(menu, menuLayout);

        for each (var test:TestData in tests)
        {
            var b:Button = new Button();
            menuContainer.add(b);
            b.label = test.name;
            b.name = test.name;
            b.addEventListener(MouseEvent.CLICK, onTestButtonClick);
        }
        menuContainer.layoutContainer();

        stage.addEventListener(Event.RESIZE, onResize);
    }

    private function onResize(event:Event):void
    {
        if (testView)
        {
            testView.width = stage.stageWidth - testView.x;
        }
    }

    private function onTestButtonClick(event:MouseEvent):void
    {
        var b:DisplayObject = event.currentTarget as DisplayObject;

        for each (var test:TestData in tests)
            if (test.name == b.name) break;

        currentTest = test;
    }

    private function set currentTest(test:TestData):void
    {
        if (testView)
        {
            removeChild(testView);
            testView = null;
        }

        if (test)
        {
            addChild(testView = test.displayObject);
            testView.x = menu.width + 5;
            onResize(null);
        }
    }

    public function registerTest(name:String, ref:Class):void
    {
        tests.push(new TestData(name, ref));
    }
}
}

import flash.display.DisplayObject;

class TestData
{
    public var name:String;

    public var ref:Class;

    public function TestData(name:String, ref:Class)
    {
        this.name = name;
        this.ref = ref;
    }

    public function get displayObject():DisplayObject
    {
        return new ref();
    }
}