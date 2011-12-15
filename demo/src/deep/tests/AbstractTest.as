package deep.tests
{
import flash.display.Sprite;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class AbstractTest extends Sprite
{
	protected var _width:Number;
	protected var _height:Number;

	public function AbstractTest()
	{
	}


	protected function invalidateSize():void
	{

	}


	override public function get width():Number
	{
		return _width;
	}

	override public function get height():Number
	{
		return _height;
	}

	override public function set width(value:Number):void
	{
		_width = value;
		invalidateSize();
	}

	override public function set height(value:Number):void
	{
		_height = value;
		invalidateSize();
	}
}
}
