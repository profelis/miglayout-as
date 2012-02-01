package deep.migLayout
{
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

import net.miginfocom.layout.CC;
import net.miginfocom.layout.ComponentType;

import net.miginfocom.layout.ComponentWrapper;
import net.miginfocom.layout.LayoutUtil;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class Component extends Sprite implements ComponentWrapper
{
    protected var _width:Number;

    protected var _height:Number;

    protected var _invalid:Boolean;

    private var _constraints:CC;

    public function Component(constraints:CC = null)
    {
        this.constraints = constraints;
    }

    public function invalidate():void
    {
        if (!_invalid)
        {
            addEventListener(Event.ENTER_FRAME, onInvalidate);
            dispatchEvent(new Event(Event.CHANGE));
            _invalid = true;
        }
    }

    protected function onInvalidate(event:Event):void
    {
        removeEventListener(Event.ENTER_FRAME, onInvalidate);
        _invalid = false;
        validate();
    }

    public function validate():void
    {
        trace(getTimer(), "validate", this, x, y, width, height);
    }

    override public function get width():Number
    {
        return _width;
    }

    override public function set width(value:Number):void
    {
        if (_width == value) return;
        _width = value;
        invalidate();
    }

    override public function get height():Number
    {
        return _height;
    }

    override public function set height(value:Number):void
    {
        if (_height == value) return;
        _height = value;
        invalidate();
    }

    public function get actualWidth():int
    {
        return width;
    }

    public function get actualHeight():int
    {
        return height;
    }

    public function getMinimumWidth(hHint:int = -1):int
    {
        return width;
    }

    public function getMinimumHeight(wHint:int = -1):int
    {
        return height;
    }

    public function getPreferredWidth(hHint:int = -1):int
    {
        return width;
    }

    public function getPreferredHeight(wHint:int = -1):int
    {
        return height;
    }

    public function getMaximumWidth(hHint:int = -1):int
    {
        return 32767;
    }

    public function getMaximumHeight(wHint:int = -1):int
    {
        return 32767;
    }

    public function setBounds(x:Number, y:Number, w:int, h:int):void
    {
        this.x = x;
        this.y = y;
        width = w;
        height = h;
    }

    public function getBaseline(width:int, height:int):int
    {
        return -1;
    }

    public function get hasBaseline():Boolean
    {
        return false;
    }

    public function get linkId():String
    {
        return name;
    }

    public function get layoutHashCode():int
    {
        return LayoutUtil.calculateHash(this);
    }

    public function get visualPadding():Vector.<int>
    {
        return null;
    }

    public function paintDebugOutline():void
    {
    }

    public function getComponentType(disregardScrollPane:Boolean):int
    {
        return ComponentType.TYPE_UNKNOWN;
    }

    public function get constraints():CC
    {
        return _constraints;
    }

    public function set constraints(value:CC):void
    {
        if (value == null) value = new CC();
        if (_constraints != value)
        {
            _constraints = value;
            invalidate();
        }
    }
}
}
