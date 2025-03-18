import 'package:htmltojaspr/src/html_converter.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlConverter', () {
    late HtmlConverter htmlConverter;

    setUp(() {
      htmlConverter = HtmlConverter();
    });

    test('should convert hello world div', () async {
      final result = htmlConverter.covert('''
        <div>
        <h1>This is a title</h1>
        <p>Hello <b>World!</b></p>
        </div>''');

      expect(
        result,
        'div([h1([ text([This is a title)],)],p([ text([Hello)],b([ text([World!)],)],)],)],',
      );
    });

    test('should convert div with classes', () async {
      final result = htmlConverter.covert('''
        <div class="content content-left">Hello <b>World!</div>''');

      expect(
        result,
        "div([ classes: 'content content-left', text([Hello)],b([ text([World!)],)],)],",
      );
    });
  });
}
