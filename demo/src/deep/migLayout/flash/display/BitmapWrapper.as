package deep.migLayout.flash.display
{

import deep.migLayout.flash.FlashComponentWrapper;

import flash.display.Bitmap;

import net.miginfocom.layout.CC;
import net.miginfocom.layout.ComponentType;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class BitmapWrapper extends FlashComponentWrapper
{
    private var _bitmap:Bitmap;

    public function BitmapWrapper(c:Bitmap, constraints:CC)
    {
        _bitmap = c;
        super(c, constraints);
    }

    override public function getPreferredWidth(hHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.width;

        return super.getPreferredWidth(hHint);
    }

    override public function getPreferredHeight(wHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.height;

        return super.getPreferredHeight(wHint);
    }

    override public function getMinimumWidth(hHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.width;

        return super.getMinimumWidth(hHint);
    }

    override public function getMinimumHeight(wHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.height;

        return super.getMinimumHeight(wHint);
    }

    override public function getMaximumWidth(hHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.width;

        return _bitmap.width / _bitmap.scaleX;
    }

    override public function getMaximumHeight(wHint:int = -1):int
    {
        if (_bitmap.bitmapData) return _bitmap.bitmapData.height;

        return _bitmap.height / _bitmap.scaleY;
    }

    override public function getComponentType(disregardScrollPane:Boolean):int
    {
        return ComponentType.TYPE_IMAGE;
    }
}
}
