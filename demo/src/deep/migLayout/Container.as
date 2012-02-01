package deep.migLayout
{
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.geom.Rectangle;

import net.miginfocom.layout.ComponentType;

import net.miginfocom.layout.ComponentWrapper;
import net.miginfocom.layout.ContainerWrapper;
import net.miginfocom.layout.ContainerWrappers;
import net.miginfocom.layout.LayoutUtil;
import net.miginfocom.layout.PlatformDefaults;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class Container extends Component implements ContainerWrapper
{
    protected var _layout:MigLayout;
    private var _components:Vector.<Component> = new Vector.<Component>();

    public function Container(layout:MigLayout = null)
    {
        scrollRect = new Rectangle(0, 0, 100, 100);
        super();
        this.layout = layout;
    }

    override public function validate():void
    {
        super.validate();

        if (_layout)
        {
            _layout.layoutContainer(this);
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    public function set layout(value:MigLayout):void
    {
        if (value == null) throw new Error("layout can't be null");
        if (_layout == value) return;
        _layout = value;
        invalidate();
    }

    public function add(component:Component):void
    {
        unregisterComponent(component);
        registerComponent(component);
        addChild(component);

        invalidate();
    }

    public function remove(component:Component):void
    {
        unregisterComponent(component);
        removeChild(component);

        invalidate();
    }

    private function registerComponent(component:Component, pos:int = -1):void
    {
        if (pos == -1) pos = _components.length;
        _components.splice(pos, 0, component);
        component.addEventListener(Event.CHANGE, onChildChange);
    }

    private function onChildChange(event:Event):void
    {
        invalidate();
    }

    private function unregisterComponent(component:Component):void
    {
        var pos:int = _components.indexOf(component);
        if (pos != -1) _components.splice(pos, 1);
        component.removeEventListener(Event.CHANGE, onChildChange);
    }

    override public function getMinimumWidth(hHint:int = -1):int
    {
        return _layout.preferredLayoutWidth(this, LayoutUtil.MIN);
    }

    override public function getMinimumHeight(wHint:int = -1):int
    {
        return _layout.preferredLayoutHeight(this, LayoutUtil.MIN);
    }

    override public function getPreferredWidth(hHint:int = -1):int
    {
        if (_layout) return _layout.preferredLayoutWidth(this, LayoutUtil.PREF);
        return super.getPreferredWidth(hHint);
    }

    override public function getPreferredHeight(wHint:int = -1):int
    {
        if (_layout) return _layout.preferredLayoutHeight(this, LayoutUtil.PREF);
        return super.getPreferredHeight(wHint);
    }

    public function get screenLocationX():Number
    {
        return localToGlobal(new Point()).x;
    }

    public function get screenLocationY():Number
    {
        return localToGlobal(new Point()).y;
    }

    public function get screenWidth():Number
    {
        return stage ? stage.stageWidth : width;
    }

    public function get screenHeight():Number
    {
        return stage ? stage.stageHeight : height;
    }

    public function get hasParent():Boolean
    {
        return parent != null;
    }

    public function getPixelUnitFactor(isHor:Boolean):Number
    {
        return 1;
    }

    public function get horizontalScreenDPI():Number
    {
        return PlatformDefaults.defaultDPI;
    }

    public function get verticalScreenDPI():Number
    {
        return PlatformDefaults.defaultDPI;
    }

    public function get components():Vector.<ComponentWrapper>
    {
        return Vector.<ComponentWrapper>(_components);
    }

    public function get componentCount():int
    {
        return _components.length;
    }

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
        ContainerWrappers.paintDebugCell(this, x, y, width, height, first);
    }

    static public function formatStage(stage:Stage):void
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
    }

    override public function getComponentType(disregardScrollPane:Boolean):int
    {
        return ComponentType.TYPE_CONTAINER;
    }

    override public function set width(value:Number):void
    {
        super.width = value;
        scrollRect = new Rectangle(0, 0, value, height);
    }

    override public function set height(value:Number):void
    {
        super.height = value;
        scrollRect = new Rectangle(0, 0, width, value);
    }
}
}
