import 'package:htmltojaspr/src/html_converter.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlConverter', () {
    late HtmlConverter htmlConverter;

    setUp(() {
      htmlConverter = HtmlConverter();
    });

    test('should convert hello world div', () async {
      final result = htmlConverter.convert('''
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
      final result = htmlConverter.convert('''
        <div class="content content-left">Hello <b>World!</div>''');

      expect(
        result,
        "div( classes: 'content content-left', [ text('Hello'),b([ text('World!'),]),])",
      );
    });

    test('should convert id', () async {
      final result = htmlConverter.convert('''
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
        final result = htmlConverter.convert('''
        <a href="#" class="card-footer-item">Save</a>''');

        expect(
          result,
          "a( classes: 'card-footer-item',  href: '#', [ text('Save'),])",
        );
      });

      test('should convert link with type', () async {
        final result = htmlConverter.convert('''
        <a href="#" type="image/jpeg">Download</a>''');

        expect(
          result,
          "a( href: '#',  type: 'image/jpeg', [ text('Download'),])",
        );
      });

      test('should convert link with target blank', () async {
        final result = htmlConverter.convert('''
          <a href="https://www.example.com" target="_blank">Opens in a new tab/window</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.blank, [ text('Opens in a new tab/window'),])",
        );
      });

      test('should convert link with target self', () async {
        final result = htmlConverter.convert('''
          <a href="https://www.example.com" target="_self">Opens in the same tab/window (default)</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.self, [ text('Opens in the same tab/window (default)'),])",
        );
      });

      test('should convert link with target parent', () async {
        final result = htmlConverter.convert('''
          <a href="https://www.example.com" target="_parent">Opens in the parent frame (if applicable)</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.parent, [ text('Opens in the parent frame (if applicable)'),])",
        );
      });

      test('should convert link with target top', () async {
        final result = htmlConverter.convert('''
          <a href="https://www.example.com" target="_top">Opens in the full body of the window</a>
        ''');

        expect(
          result,
          "a( href: 'https://www.example.com',  target: Target.top, [ text('Opens in the full body of the window'),])",
        );
      });

      test(
        'should convert link with referrer policy no referrer noReferrer',
        () async {
          final result = htmlConverter.convert('''
          <a href="https://httpbin.org/get" referrerpolicy="no-referrer">No Referrer</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.noReferrer, [ text('No Referrer'),])",
          );
        },
      );

      test(
        'should convert link with referrer policy no referrer No Referrer (Downgrade)',
        () async {
          final result = htmlConverter.convert('''
<a href="https://httpbin.org/get" referrerpolicy="no-referrer-when-downgrade">No Referrer (Downgrade)</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.noReferrerWhenDowngrade, [ text('No Referrer (Downgrade)'),])",
          );
        },
      );

      test(
        'should convert link with referrer policy no referrer Same Origin',
        () async {
          final result = htmlConverter.convert('''
<a href="https://httpbin.org/get" referrerpolicy="same-origin">Same Origin</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.sameOrigin, [ text('Same Origin'),])",
          );
        },
      );
      test(
        'should convert link with referrer policy no referrer Origin Only',
        () async {
          final result = htmlConverter.convert('''
<a href="https://httpbin.org/get" referrerpolicy="origin">Origin Only</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.origin, [ text('Origin Only'),])",
          );
        },
      );
      test(
        'should convert link with referrer policy no referrer Strict Origin',
        () async {
          final result = htmlConverter.convert('''
<a href="https://httpbin.org/get" referrerpolicy="strict-origin">Strict Origin</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.strictOrigin, [ text('Strict Origin'),])",
          );
        },
      );
      // NOT SUPPORTED BY Jaspr
      //       test(
      //         'should convert link with referrer policy no referrer Cross Origin',
      //         () async {
      //           final result = htmlConverter.covert('''
      // <a href="https://httpbin.org/get" referrerpolicy="origin-when-cross-origin">Cross Origin</a>
      //         ''');

      //           expect(
      //             result,
      //             "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.noReferrer, [ text('Cross Origin'),])",
      //           );
      //         },
      //       );
      test(
        'should convert link with referrer policy no referrer Strict Cross Origin',
        () async {
          final result = htmlConverter.convert('''
<a href="https://httpbin.org/get" referrerpolicy="strict-origin-when-cross-origin">Strict Cross Origin</a>
        ''');

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.strictOriginWhenCrossOrigin, [ text('Strict Cross Origin'),])",
          );
        },
      );
      test(
        'should convert link with referrer policy no referrer Unsafe URL',
        () async {
          final result = htmlConverter.convert(
            '''
<a href="https://httpbin.org/get" referrerpolicy="unsafe-url">Unsafe URL</a>        ''',
          );

          expect(
            result,
            "a( href: 'https://httpbin.org/get',  referrerPolicy: ReferrerPolicy.unsafeUrl, [ text('Unsafe URL'),])",
          );
        },
      );
    });

    group('events', () {
      test('should convert onclick', () {
        final result = htmlConverter.convert('''
            <button onclick="handleClick()">Click Me!</button>
            ''');

        expect(
          result,
          "button( events: {  'onclick': (event) {}, }, [ text('Click Me!'),])",
        );
      });

      test('should convert tag with two events', () {
        final result = htmlConverter.convert('''
            <button onclick="handleClick()" onmousemove="alert()">Click Me!</button>
            ''');

        expect(
          result,
          "button( events: {  'onclick': (event) {}, 'onmousemove': (event) {}, }, [ text('Click Me!'),])",
        );
      });
    });

    test('should convert autofocus', () {
      final result = htmlConverter.convert('''
            <button autofocus>Click Me!</button>
            ''');

      expect(result, "button( autofocus: true, [ text('Click Me!'),])");
    });

    test('should convert disabled', () {
      final result = htmlConverter.convert('''
            <button disabled>Click Me!</button>
            ''');

      expect(result, "button( disabled: true, [ text('Click Me!'),])");
    });

    // test('should convert custom parameters', () async {
    //   final result = htmlConverter.covert('''
    //     <a href="#" aria-current="page">Breadcrumb</a>''');

    //   expect(
    //     result,
    //     "a( classes: 'card-footer-item',  href: '#', [ text('Save'),])",
    //   );
    // });

    group('select tag', () {
      test('should convert select', () {
        final result = htmlConverter.convert('''
            <select>
              <option>Select dropdown</option>
              <option>With options</option>
            </select>
            ''');

        expect(
          result,
          "select([option([ text('Select dropdown'),]),option([ text('With options'),]),])",
        );
      });

      test('should convert select multiple', () {
        final result = htmlConverter.convert('''
            <select multiple>
              <option>Select dropdown</option>
              <option>With options</option>
            </select>
            ''');

        expect(
          result,
          "select( multiple: true, [option([ text('Select dropdown'),]),option([ text('With options'),]),])",
        );
      });

      test('should convert select with name', () {
        final result = htmlConverter.convert('''
            <select name="myname">
              <option>Select dropdown</option>
              <option>With options</option>
            </select>
            ''');

        expect(
          result,
          "select( name: 'myname', [option([ text('Select dropdown'),]),option([ text('With options'),]),])",
        );
      });

      test('should convert select with selected option', () {
        final result = htmlConverter.convert('''
            <select name="myname">
              <option>Select dropdown</option>
              <option selected>With options</option>
            </select>
            ''');

        expect(
          result,
          "select( name: 'myname', [option([ text('Select dropdown'),]),option( selected: true, [ text('With options'),]),])",
        );
      });
    });

    group('textarea tag', () {
      test('should convert cols and rows', () {
        final result = htmlConverter.convert('''
           <textarea rows="5" cols="33">
            It was a dark and stormy night...
           </textarea>
            ''');

        expect(
          result,
          "textarea( rows: 5,  cols: 33, [ text('It was a dark and stormy night...'),])",
        );
      });

      test('should convert cols and rows', () {
        final result = htmlConverter.convert('''
            <textarea
              minlength="10"
              maxlength="40"
              required>
            </textarea>
            ''');

        expect(result, "textarea( minLength: 10,  required: true, [])");
      });
    });

    group('label tag', () {
      test('should convert cols and rows', () {
        final result = htmlConverter.convert('''
          <label for="fruit">Enter a fruit name that is at least 5 letters long</label>
            ''');

        expect(
          result,
          "label( htmlFor: 'fruit', [ text('Enter a fruit name that is at least 5 letters long'),])",
        );
      });
    });

    group('input tag', () {
      test('should convert input text', () {
        final result = htmlConverter.convert('''
      <input type="text" placeholder="Enter text">
    ''');
        expect(result, "input( type: InputType.text, [])");
      });

      test('should convert input password', () {
        final result = htmlConverter.convert('''
      <input type="password" placeholder="Enter password">
    ''');
        expect(result, "input( type: InputType.password, [])");
      });

      test('should convert input email', () {
        final result = htmlConverter.convert('''
      <input type="email" placeholder="example@example.com">
    ''');
        expect(result, "input( type: InputType.email, [])");
      });

      test('should convert input number', () {
        final result = htmlConverter.convert('''
      <input type="number" min="0" max="100" value="50">
    ''');
        expect(result, "input( type: InputType.number, [])");
      });

      test('should convert input url', () {
        final result = htmlConverter.convert('''
      <input type="url" placeholder="https://example.com">
    ''');
        expect(result, "input( type: InputType.url, [])");
      });

      test('should convert input tel', () {
        final result = htmlConverter.convert('''
      <input type="tel" placeholder="+1234567890">
    ''');
        expect(result, "input( type: InputType.tel, [])");
      });

      test('should convert input date', () {
        final result = htmlConverter.convert('''
      <input type="date">
    ''');
        expect(result, "input( type: InputType.date, [])");
      });

      test('should convert input time', () {
        final result = htmlConverter.convert('''
      <input type="time">
    ''');
        expect(result, "input( type: InputType.time, [])");
      });

      test('should convert input datetime-local', () {
        final result = htmlConverter.convert('''
      <input type="datetime-local">
    ''');
        expect(result, "input( type: InputType.dateTimeLocal, [])");
      });

      test('should convert input month', () {
        final result = htmlConverter.convert('''
      <input type="month">
    ''');
        expect(result, "input( type: InputType.month, [])");
      });

      test('should convert input week', () {
        final result = htmlConverter.convert('''
      <input type="week">
    ''');
        expect(result, "input( type: InputType.week, [])");
      });

      test('should convert input color', () {
        final result = htmlConverter.convert('''
      <input type="color" value="#ff0000">
    ''');
        expect(result, "input( type: InputType.color, [])");
      });

      test('should convert input range', () {
        final result = htmlConverter.convert('''
      <input type="range" min="0" max="100" value="50">
    ''');
        expect(result, "input( type: InputType.range, [])");
      });

      test('should convert input checkbox', () {
        final result = htmlConverter.convert('''
      <input type="checkbox">
    ''');
        expect(result, "input( type: InputType.checkbox, [])");
      });

      test('should convert input radio', () {
        final result = htmlConverter.convert('''
      <input type="radio" name="radioGroup">
    ''');
        expect(
          result,
          "input( name: 'radioGroup',  type: InputType.radio, [])",
        );
      });

      test('should convert input file', () {
        final result = htmlConverter.convert('''
      <input type="file" multiple>
    ''');
        expect(result, "input( multiple: true,  type: InputType.file, [])");
      });

      test('should convert input search', () {
        final result = htmlConverter.convert('''
      <input type="search" placeholder="Search...">
    ''');
        expect(result, "input( type: InputType.search, [])");
      });

      test('should convert input hidden', () {
        final result = htmlConverter.convert('''
      <input type="hidden" value="Hidden Value">
    ''');
        expect(result, "input( type: InputType.hidden, [])");
      });

      test('should convert input submit', () {
        final result = htmlConverter.convert('''
      <input type="submit" value="Submit">
    ''');
        expect(result, "input( type: InputType.submit, [])");
      });

      test('should convert input reset', () {
        final result = htmlConverter.convert('''
      <input type="reset" value="Reset">
    ''');
        expect(result, "input( type: InputType.reset, [])");
      });

      test('should convert input button', () {
        final result = htmlConverter.convert('''
      <input type="button" value="Click Me">
    ''');
        expect(result, "input( type: InputType.button, [])");
      });
    });
  });
}
