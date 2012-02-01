package deep.migLayout.flash.text
{
import deep.migLayout.flash.FlashComponent;

import flash.text.TextField;
import flash.text.TextFieldType;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class TextFieldComponent extends FlashComponent
{
    protected var _tf:TextField;

    public function TextFieldComponent(child:TextField, constraints:Object = null)
    {
        _tf = child;
        super(child, constraints);
    }

    override public function getMinimumWidth(hHint:int = -1):int
    {
        return _tf.type == TextFieldType.INPUT ? 0 : _tf.textWidth;
    }

    override public function getMinimumHeight(wHint:int = -1):int
    {
        return _tf.getLineMetrics(0).height;
    }
}
}
