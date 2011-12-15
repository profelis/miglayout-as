package deep
{
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class TestTextField extends TextField
{
	public function TestTextField(text:String, input:Boolean = false)
	{
		super();
				
		if (input)
		{
			type = TextFieldType.INPUT;
			border = true;
			height = 20;
			multiline = false;
		}
		else
		{
			autoSize = TextFieldAutoSize.LEFT;
			multiline = true;
			selectable = true;
		}
		
		this.text = text;
	}
}
}
