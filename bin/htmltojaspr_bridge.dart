import 'dart:js_interop';

import 'package:htmltojaspr/htmltojaspr.dart';

@JS()
external set convertToJaspr(JSFunction fn);

void main(List<String> arguments) async {
  convertToJaspr = _createJasprElement.toJS;
}

void _createJasprElement(JSString data, JSFunction fn) {
  final htmlConverter = HtmlConverter();

  var result = htmlConverter.convert(data.toString());

  fn.callAsFunction(null, result.toJS);
}
