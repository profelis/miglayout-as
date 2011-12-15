package deep.migLayout.flash
{
import deep.migLayout.flash.display.BitmapWrapper;
import deep.migLayout.flash.text.TextFieldWrapper;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.text.TextField;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedSuperclassName;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
final public class ComponentBuilder
{
	private static var _wrapperRefs:Dictionary = new Dictionary();

	{
		registerComponentWrapper(DisplayObject, FlashComponentWrapper);
		registerComponentWrapper(TextField, TextFieldWrapper);
		registerComponentWrapper(Bitmap, BitmapWrapper);
	}

	static public function registerComponentWrapper(component:Class, wrapperRef:Class):void
	{
		_wrapperRefs[component] = wrapperRef;
	}

	static public function unRegisterComponent(component:Class):Boolean
	{
		if (component in _wrapperRefs)
		{
			delete _wrapperRefs[component];
			return true;
		}
		return false;
	}

	static public function unRegisterWrapper(wrapperRef:Class):Boolean
	{
		var res:Boolean = false;
		for (var compRef:Object in _wrapperRefs)
		{
			if (_wrapperRefs[compRef] == wrapperRef)
			{
				delete _wrapperRefs[compRef];
				res = true;
			}
		}
		return res;
	}

	static public function getComponentWrapper(component:Object):Class
	{
		var ref:Class = component.constructor;
		do
		{
			if (ref in _wrapperRefs) return _wrapperRefs[ref];
			try
			{
				ref = getDefinitionByName(getQualifiedSuperclassName(ref)) as Class;
			}
			catch (e:Error)
			{
				return null;
			}
		} while (ref != null);

		return null;
	}
}
}
