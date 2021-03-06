package deep.tests
{
import deep.TestTextField;
import deep.migLayout.MigLayout;
import deep.migLayout.fl.UIComponentWrapper;
import deep.migLayout.flash.FlashComponent;

import fl.controls.Button;

import flash.display.DisplayObject;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class HorizontalTest extends AbstractTest
{
    {
        UIComponentWrapper.register();
    }

    public function HorizontalTest()
    {
        super(new MigLayout("debug, wrap", "[left]15[center]15[right]15[fill]15[]", "rel[]rel"));

        var labels:Vector.<String> = new <String>["left", "center", "right", "fill", "[]"];
        var buttons:Vector.<String> = new <String>["First name", "Phone number", "Avatar", "Email", "Address"];

        for each (var label:String in labels)
        {
            add(new FlashComponent(createLabel(label)));
        }

        for (var i:int = 0; i < labels.length; i++)
        {
            for each (var name:String in buttons)
            {
                add(new FlashComponent(createButton(buttons[i])));
            }
        }
    }

    private function createLabel(label:String):DisplayObject
    {
        return new TestTextField(label);
    }

    private function createButton(label:String):DisplayObject
    {
        var b:Button = new Button();
        b.label = label;
        b.setSize(label.length * 12, b.height);
        return b;
    }
}
}
