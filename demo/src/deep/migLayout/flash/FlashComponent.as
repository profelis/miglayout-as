package deep.migLayout.flash
{
import deep.migLayout.Component;

import flash.display.DisplayObject;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class FlashComponent extends Component
{
    private var _child:DisplayObject;
    
    public function FlashComponent(child:DisplayObject)
    {
        _child = child;
        super();
        _width = child.width;
        _height = child.height;
        addChild(child);
        invalidate();
    }

    override public function set width(value:Number):void
    {
        super.width = value;
        _child.width = value;
    }

    override public function set height(value:Number):void
    {
        super.height = value;
        _child.height = value;
    }

    override public function setBounds(x:Number, y:Number, w:int, h:int):void
    {
        super.setBounds(x, y, w, h);
        _child.width = w;
        _child.height = h;
    }
}
}
