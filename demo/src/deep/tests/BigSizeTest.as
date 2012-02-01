package deep.tests
{
import deep.migLayout.MigLayout;
import deep.migLayout.flash.FlashComponent;

import fl.controls.Button;

import flash.events.MouseEvent;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class BigSizeTest extends AbstractTest
{
    public function BigSizeTest()
    {
        super(new MigLayout("debug, w 20, h 20"));
        width = 20;
        height = 20;

        var button:Button = new Button();
        button.label = "layout 20x20, button 200x100";
        button.setSize(200, 100);
        var flashComponent:FlashComponent = new FlashComponent(button);
        add(flashComponent);

        button.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void
        {
            flashComponent.width += 10;
        });

        var button2:Button;
        button2 = new Button();
        button2.setSize(100, 200);
        button2.label = "100x200";
        var flashComponent2:FlashComponent = new FlashComponent(button2);
        add(flashComponent2);
        button2.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void
        {
            flashComponent2.height += 10;
        });
    }
}
}
