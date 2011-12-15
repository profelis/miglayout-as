package deep.migLayout.flash.text
{
import deep.migLayout.flash.FlashComponentWrapper;

import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

import net.miginfocom.layout.CC;
import net.miginfocom.layout.ComponentType;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class TextFieldWrapper extends FlashComponentWrapper
{
	protected var _textField:TextField;
	private var _startSize:Point;

	public function TextFieldWrapper(c:TextField, constraints:CC)
	{
		_startSize = new Point(c.width, c.height);
		_textField = c;
		super(c, constraints);
	}

	override public function getPreferredWidth(hHint:int = -1):int
	{
		if (_textField.type == TextFieldType.INPUT)
			return _startSize.x;

		return _textField.textWidth;
	}

	override public function getPreferredHeight(wHint:int = -1):int
	{
		if (_textField.type == TextFieldType.INPUT)
			return _startSize.y;

		return _textField.textHeight;
	}

	override public function getMinimumWidth(hHint:int = -1):int
	{
		if (_textField.type == TextFieldType.INPUT)
			return 0;

		if (_textField.autoSize != TextFieldAutoSize.NONE)
			return (_textField.wordWrap) ? 0 : _textField.width;

		return _textField.textWidth;
	}

	override public function getMinimumHeight(wHint:int = -1):int
	{
		if (_textField.type == TextFieldType.INPUT)
			return _textField.textHeight + 5;

		if (_textField.autoSize != TextFieldAutoSize.NONE)
			return _textField.height;

		return _textField.textHeight;
	}

	override public function getComponentType(disregardScrollPane:Boolean):int
	{
		if (_textField.type == TextFieldType.INPUT)
		{
			return _textField.multiline ? ComponentType.TYPE_TEXT_AREA : ComponentType.TYPE_TEXT_FIELD;
		}
		return ComponentType.TYPE_LABEL;
	}
}
}
