package deep.migLayout
{
import net.miginfocom.layout.AbstractMigLayout;
import net.miginfocom.layout.Grid;
import net.miginfocom.layout.LayoutCallback;
import net.miginfocom.layout.LayoutUtil;
import net.miginfocom.layout.PlatformDefaults;

public class MigLayout extends AbstractMigLayout
{
    private var lastHash:int = -1;
    private var _callbacks:Vector.<LayoutCallback>;

    private var lastInvalidW:int;
    private var lastInvalidH:int;

    public function MigLayout(layoutConstraints:String = null, colConstraints:String = null, rowConstraints:String = null)
    {
        _callbacks = new Vector.<LayoutCallback>();
        super(layoutConstraints, colConstraints, rowConstraints);
    }

    public function layoutContainer(container:Container):void
    {


        var w:Number = container.width;
        var h:Number = container.height;

        if (checkCache(container))
        {
            if (grid.layout(0, 0, w, h, lc != null && lc.debugMillis > 0, true))
            {
                grid = null;
                checkCache(container);
                grid.layout(0, 0, w, h, lc != null && lc.debugMillis > 0, false);
            }
        }
    }

    /** Check if something has changed and if so recreate it to the cached objects.
     * @param container The container that is the target for this layout manager.
     */
    private function checkCache(container:Container):Boolean
    {
        if (container == null)
        {
            return false;
        }

        if ((flags & INVALID) != 0)
        {
            grid = null;
        }

        // Check if the grid is valid
        var mc:int = PlatformDefaults.modCount;
        if (lastModCount != mc)
        {
            grid = null;
            lastModCount = mc;
        }

        var hash:int = 0;
        for each (var componentWrapper:Component in container.components)
        {
            hash ^= componentWrapper.layoutHashCode;
            hash += 285134905;
        }

        if (hash != lastHash)
        {
            grid = null;
            lastHash = hash;
        }

        if (lastInvalidW != container.actualWidth || lastInvalidH != container.actualHeight)
        {
            if (grid != null)
            {
                grid.invalidateContainerSize();
            }

            lastInvalidW = container.actualWidth;
            lastInvalidH = container.actualHeight;
        }

        if (grid == null)
        {
            grid = new Grid(container, lc, rowSpecs, colSpecs, _callbacks);
        }

        return true;
    }

    public function preferredLayoutWidth(container:Container, sizeType:int):Number
    {
        checkCache(container);

        return LayoutUtil.getSizeSafe(grid != null ? grid.width : null, sizeType);
    }

    public function preferredLayoutHeight(container:Container, sizeType:int):Number
    {
        checkCache(container);

        return LayoutUtil.getSizeSafe(grid != null ? grid.height : null, sizeType);
    }

    public function addLayoutCallback(lc:LayoutCallback):void
    {
        _callbacks.push(lc);
    }

}
}










