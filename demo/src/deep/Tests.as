package deep
{
import deep.migLayout.Component;
import deep.migLayout.Container;
import deep.migLayout.MigLayout;
import deep.migLayout.flash.FlashComponent;
import deep.tests.BigSizeTest;
import deep.tests.FormTest;
import deep.tests.HorizontalTest;

import fl.controls.Button;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class Tests extends Container
{
    private var tests:Vector.<TestData> = new Vector.<TestData>();
    private var testView:Component;
    private var menu:Container;

    public function Tests()
    {
        super(new MigLayout("debug", "[][grow, fill]", "[top, 100%]"));

        Container.formatStage(stage);

        registerTest("Horizontal", HorizontalTest);
        registerTest("BigSize", BigSizeTest);
        registerTest("FormTest", FormTest);

        init();
    }

    private function init():void
    {
        menu = new Container(new MigLayout("debug, wrap, ins 0", "[left]", ""));

        for each (var test:TestData in tests)
        {
            var b:Button = new Button();
            menu.add(new FlashComponent(b));
            b.label = test.name;
            b.name = test.name;
            b.addEventListener(MouseEvent.CLICK, onTestButtonClick);
        }

        add(menu);

        stage.addEventListener(Event.RESIZE, onStageResize);
        onStageResize(null);
    }

    private function onStageResize(event:Event):void
    {
        width = stage.stageWidth;
        height = stage.stageHeight;
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
            remove(testView);
            testView = null;
        }

        if (test)
        {
            add(testView = test.container);
        }
    }

    public function registerTest(name:String, ref:Class):void
    {
        tests.push(new TestData(name, ref));
    }
}
}

import deep.migLayout.Container;

class TestData
{
    public var name:String;

    public var ref:Class;

    public function TestData(name:String, ref:Class)
    {
        this.name = name;
        this.ref = ref;
    }

    public function get container():Container
    {
        return new ref();
    }
}