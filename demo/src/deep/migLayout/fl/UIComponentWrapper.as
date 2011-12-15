package deep.migLayout.fl
{
import deep.migLayout.flash.ComponentBuilder;
import deep.migLayout.flash.FlashComponentWrapper;

import fl.core.UIComponent;

import flash.display.DisplayObject;

import net.miginfocom.layout.CC;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class UIComponentWrapper extends FlashComponentWrapper
{
	private var _control:UIComponent;

	public function UIComponentWrapper(c:UIComponent, constraints:CC)
	{
		_control = c;
		super(c, constraints);
	}

	override public function getMinimumHeight(wHint:int = -1):int
	{
		return _control.height;
	}

	override public function getMinimumWidth(hHint:int = -1):int
	{
		return _control.width;
	}

	override public function getPreferredWidth(hHint:int = -1):int
	{
		return _control.width;
	}

	override public function getPreferredHeight(wHint:int = -1):int
	{
		return _control.height;
	}

	static public function register():void
	{
		ComponentBuilder.registerComponentWrapper(UIComponent, UIComponentWrapper);
	}
}
}
