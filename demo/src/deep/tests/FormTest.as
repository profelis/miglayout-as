package deep.tests
{
import deep.migLayout.MigLayout;
import deep.migLayout.flash.FlashComponent;

import fl.controls.Button;

import flash.events.MouseEvent;

/**
 * @author Dima Granetchi <system.grand@gmail.com>, <deep@e-citrus.ru>
 */
public class FormTest extends AbstractTest
{
    public function FormTest()
    {
        super(new MigLayout("wrap", "[][grow][][grow]"));
        
        add(new Label("Name:"));
        add(new TextInput("", "grow"));

        add(new Label("Phone:"));
        add(new TextInput("", "grow"));

        add(new Label("Adress:"));
        add(new TextInput("", "grow, sx 3"));

    }
}
}

import deep.migLayout.flash.text.TextFieldComponent;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;


class Label extends TextFieldComponent
{

    public function Label(text:String = "", constraints:Object = null)
    {
        var _tf:TextField = new TextField();
        _tf.height = 20;
        _tf.width = 0;
        _tf.selectable = false;
        _tf.autoSize = TextFieldAutoSize.LEFT;
        _tf.wordWrap = false;
        _tf.text = text;
        super(_tf, constraints);

    }
    
    public function get text():String
    {
        return _tf.text;
    }

    public function set text(value:String):void
    {
        _tf.text = value;
    }
}

class TextInput extends Label
{

    public function TextInput(text:String = "", constraints:Object = null)
    {
        super(text, constraints);
        _tf.selectable = true;
        _tf.type = TextFieldType.INPUT;
        _tf.border = true;
        _tf.autoSize = TextFieldAutoSize.NONE;
    }
}