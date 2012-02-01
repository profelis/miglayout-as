package deep.migLayout.flash
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Point;

import net.miginfocom.layout.CC;
import net.miginfocom.layout.ComponentType;
import net.miginfocom.layout.ComponentWrapper;
import net.miginfocom.layout.ConstraintParser;
import net.miginfocom.layout.ContainerWrapper;
import net.miginfocom.layout.ContainerWrappers;
import net.miginfocom.layout.PlatformDefaults;

[Deprecated]
public final class FlashContainerWrapper extends FlashComponentWrapper implements ContainerWrapper
{
    internal var w:int;
    internal var h:int;

    private const _components:Vector.<ComponentWrapper> = new Vector.<ComponentWrapper>();

    private var _cont:DisplayObjectContainer;

    override public function getPreferredWidth(hHint:int = -1):int
    {
        return w;
    }

    override public function getPreferredHeight(wHint:int = -1):int
    {
        return h;
    }

    function FlashContainerWrapper(c:DisplayObjectContainer, layout:FlashMigLayout)
    {
        _cont = c;
        super(c, null);
        _layout = layout;
    }

    override public function getComponentType(disregardScrollPane:Boolean):int
    {
        return ComponentType.TYPE_CONTAINER;
    }

    public function get components():Vector.<ComponentWrapper>
    {
        return _components;
    }

    public function get componentCount():int
    {
        return _components.length;
    }

    private var _layout:FlashMigLayout;
    private var _invalid:Boolean;

    public function getLayout():Object
    {
        return _layout;
    }

    public function get leftToRight():Boolean
    {
        return true;
    }

    public function paintDebugCell(x:Number, y:Number, width:Number, height:Number, first:Boolean):void
    {
        ContainerWrappers.paintDebugCell(DisplayObjectContainer(c), x, y, width, height, first);
    }

    override public function get layoutHashCode():int
    {
        return 0;
    }

    public function addChild(component:DisplayObject, constraints:Object = null):void
    {
        if (getComponentWrapper(component)) return;
        constraints ||= "";
        var componentConstraints:CC = constraints is String ? ConstraintParser.parseComponentConstraint(String(constraints)) : CC(constraints);
        var wrapperRef:Class = ComponentBuilder.getComponentWrapper(component);
        if (wrapperRef)
        {
            _components[_components.length] = new wrapperRef(component, componentConstraints);
            _cont.addChild(component);
        }

        invalidate();
    }

    public function removeChild(component:DisplayObject):Boolean
    {
        var wrapper:FlashComponentWrapper = getComponentWrapper(component);
        if (wrapper)
        {
            _cont.removeChild(component);
            _components.splice(_components.indexOf(wrapper), 1);
            invalidate();
            return true;
        }
        return false;
    }

    public function getComponentWrapper(component:DisplayObject):FlashComponentWrapper
    {
        for each (var w:FlashComponentWrapper in _components)
        {
            if (w.component == component) return w;
        }
        return null;
    }

    public function layoutContainer():void
    {
        _layout.layoutContainer(this);
    }

    public function get screenLocationX():Number
    {
        return c.localToGlobal(new Point()).x;
    }

    public function get screenLocationY():Number
    {
        return c.localToGlobal(new Point()).y;
    }

    public function get screenWidth():Number
    {
        return c.stage.stageWidth;
    }

    public function get screenHeight():Number
    {
        return c.stage.stageHeight;
    }

    public function get hasParent():Boolean
    {
        return c.parent != null;
    }

    public function getPixelUnitFactor(isHor:Boolean):Number
    {
        return 1;
    }

    public function invalidate():void
    {
        if (!_invalid)
        {
            _invalid = true;
            c.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    private function onEnterFrame(event:Event):void
    {
        _invalid = false;
        c.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        layoutContainer();
    }

    public function get horizontalScreenDPI():Number
    {
        return PlatformDefaults.defaultDPI;
    }

    public function get verticalScreenDPI():Number
    {
        return PlatformDefaults.defaultDPI;
    }
}
}