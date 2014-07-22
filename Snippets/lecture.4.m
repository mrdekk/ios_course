Грузим картинку

_imageView.image = [ UIImage imageWithData: [ NSData dataWithContentsOfURL: [ NSURL URLWithString: @"http://itw66.ru/files/logo.png" ] ] ];

Загружаем HTML в UIWebView

[ _browser loadHTMLString: @"<html><body><h1>Hello, World</h1></body></html>" baseURL: [ NSURL URLWithString: @"http://yandex.ru" ] ];

Функция прятания клавиатуры

-( IBAction ) hideKeyboard: ( id )sender
{
    if ( [ self becomeFirstResponder ] )
        [ self resignFirstResponder ];
}

Настраивать на "Did End On Exit"
