package deep.migLayout
{
import deep.migLayout.flash.FlashContainerWrapper;
import deep.migLayout.flash.MigLayout;

import flash.display.Sprite;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class Container extends Sprite
{
    protected var _width:Number;

    protected var _height:Number;

    private var _wrapper:FlashContainerWrapper;

    public function Container(layout:MigLayout)
    {
        _wrapper = new FlashContainerWrapper(this)
    }

    protected function invalidateSize():void
    {

    }

    override public function get width():Number
    {
        return _width;
    }

    override public function set width(value:Number):void
    {
        _width = value;
        invalidateSize();
    }

    override public function get height():Number
    {
        return _height;
    }

    override public function set height(value:Number):void
    {
        _height = value;
        invalidateSize();
    }

    public function get wrapper():FlashContainerWrapper
    {
        return _wrapper;
    }
}
}
