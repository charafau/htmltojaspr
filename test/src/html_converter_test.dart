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
        "div([h1([ text('This is a title'),]),p([ text('Hello'),b([ text('World!'),]),]),])",
      );
    });

    test('should convert div with classes', () async {
      final result = htmlConverter.covert('''
        <div class="content content-left">Hello <b>World!</div>''');

      expect(
        result,
        "div( classes: 'content content-left', [ text('Hello'),b([ text('World!'),]),])",
      );
    });

    test('should convert id', () async {
      final result = htmlConverter.covert('''
           <p id="title">
              A modern CSS framework based on Flexbox
            </p>''');

      expect(
        result,
        "p( id: 'title', [ text('A modern CSS framework based on Flexbox'),])",
      );
    });

    group('a tag', () {
      test('should convert link', () async {
        final result = htmlConverter.covert('''
        <a href="#" class="card-footer-item">Save</a>''');

        expect(
          result,
          "a( classes: 'card-footer-item',  href: '#', [ text('Save'),])",
        );
      });

      test('should convert link with type', () async {
        final result = htmlConverter.covert('''
        <a href="#" type="image/jpeg">Download</a>''');

        expect(
          result,
          "a( href: '#',  type: 'image/jpeg', [ text('Download'),])",
        );
      });

      test('should convert link with target blank', () async {
        final result = htmlConverter.covert('''
          <a href="https://www.example.com" target="_blank">Opens in a new tab/window</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.blank, [ text('Opens in a new tab/window'),])",
        );
      });

      test('should convert link with target self', () async {
        final result = htmlConverter.covert('''
          <a href="https://www.example.com" target="_self">Opens in the same tab/window (default)</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.self, [ text('Opens in the same tab/window (default)'),])",
        );
      });

      test('should convert link with target parent', () async {
        final result = htmlConverter.covert('''
          <a href="https://www.example.com" target="_parent">Opens in the parent frame (if applicable)</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.parent, [ text('Opens in the parent frame (if applicable)'),])",
        );
      });

      test('should convert link with target top', () async {
        final result = htmlConverter.covert('''
          <a href="https://www.example.com" target="_top">Opens in the full body of the window</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.top, [ text('Opens in the full body of the window'),])",
        );
      });
    });

    // test('should convert custom parameters', () async {
    //   final result = htmlConverter.covert('''
    //     <a href="#" aria-current="page">Breadcrumb</a>''');

    //   expect(
    //     result,
    //     "a( classes: 'card-footer-item',  href: '#', [ text('Save'),])",
    //   );
    // });
  });
}
