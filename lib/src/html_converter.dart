import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:htmltojaspr/src/html_events.dart';
import 'package:htmltojaspr/src/types.dart';

class HtmlConverter {
  String convert(String htmlSource) {
    final document = parseFragment(htmlSource);

    // print('outer html:');
    // print(document.outerHtml);

    // visitor output
    // print('html visitor:');
    // _Visitor().visit(document);

    // print('jaspr visitor:');

    // final jasprConverterPrettify = JaspConverterVisitor(prettify: true)
    //   ..visit(document);
    // print(jasprConverterPrettify.jasprTreePrettified);

    final jasprConverter = JaspConverterVisitor()..visit(document);

    return jasprConverter.jasprTree;
  }
}

class JaspConverterVisitor extends TreeVisitor {
  String _indent = '';

  String _jasprTree = '';

  // final List<String> _typedAttributes = [
  //   'id',
  //   'class',
  //   'href',
  //   'type',
  //   'target',
  //   'referrerpolicy',
  // ];

  String get jasprTree =>
      _jasprTree.isNotEmpty
          ? _jasprTree.substring(0, _jasprTree.length - 1)
          : _jasprTree;

  String get jasprTreePrettified =>
      _jasprTree.replaceAll(')],', ')],\n').replaceAll('([', '([\n');

  final bool _prettify;

  JaspConverterVisitor({bool prettify = false}) : _prettify = prettify;

  @override
  void visitText(Text node) {
    if (node.data.trim().isNotEmpty) {
      final val = "$_indent text('${node.data.trim()}'),";

      _jasprTree += val;
    }
  }

  @override
  void visitElement(Element node) {
    // if (isVoidElement(node.localName)) {
    // final val = ('$_indent<${node.localName}/>');
    // _jasprTree += val;
    // } else {
    var val = '$_indent${node.localName}(';

    if (node.attributes.containsKey('id')) {
      val += " id: '${node.attributes['id']}', ";
    }

    if (node.attributes.containsKey('class')) {
      val += " classes: '${node.attributes['class']}', ";
    }

    if (node.localName == 'a') {
      if (node.attributes.containsKey('href')) {
        val += " href: '${node.attributes['href']}', ";
      }

      if (node.attributes.containsKey('type')) {
        val += " type: '${node.attributes['type']}', ";
      }
    }

    node.attributes.forEach((attribute, value) {
      if (attribute == 'target') {
        val +=
            " target: ${Target.values.firstWhere((t) => t.value == value).toString()}, ";
      }

      if (attribute == 'referrerpolicy') {
        val +=
            " referrerPolicy: ${ReferrerPolicy.values.firstWhere((t) => t.value == value).toString()}, ";
      }

      if (attribute == 'autofocus') {
        val += " autofocus: true, ";
      }

      if (attribute == 'multiple') {
        val += " multiple: true, ";
      }

      if (attribute == 'disabled') {
        val += " disabled: true, ";
      }

      if (attribute == 'name') {
        val += " name: '$value', ";
      }

      if (attribute == 'selected') {
        val += " selected: true, ";
      }

      if (attribute == 'rows') {
        val += " rows: ${int.tryParse(value)}, ";
      }

      if (attribute == 'cols') {
        val += " cols: ${int.tryParse(value)}, ";
      }

      if (attribute == 'minlength') {
        val += " minLength: ${int.tryParse(value)}, ";
      }

      if (attribute == 'required') {
        val += " required: true, ";
      }

      if (attribute == 'for') {
        val += " htmlFor: '$value', ";
      }
    });

    // add type for button class

    // add support for inputs
    if (node.localName == 'input') {
      final attribute = node.attributes['type'];

      if (attribute != null) {
        val +=
            " type: ${InputType.values.firstWhere((t) => t.value == attribute).toString()}, ";
      }
    }

    val = _convertEvents(node, val);

    // get all events from node

    // if (node.attributes.containsKey('target')) {}

    // if (node.attributes.containsKey('referrerpolicy')) {}

    // _typedAttributes;

    // next support <input> type

    // custom attributes:
    // placeholder
    //

    // canvas must be supported separately

    val += '[';

    if (_prettify) {
      _indent += '  ';
    }

    _jasprTree += val;
    visitChildren(node);
    if (_prettify) {
      _indent = _indent.substring(0, _indent.length - 2);
    }
    val = '$_indent]),';

    _jasprTree += val;
    // }
  }

  String _convertEvents(Element node, String val) {
    final allKeys = node.attributes.keys.map((key) => key.toString()).toList();

    final allEventsFromNode =
        allEventAttributes
            .where((element) => allKeys.contains(element))
            .toList();

    if (allEventsFromNode.isNotEmpty) {
      val += " events: { ";
      for (var event in allEventsFromNode) {
        val += " '$event': (event) {},";
      }
      val += " }, ";
    }
    return val;
  }

  @override
  void visitChildren(Node node) {
    for (var child in node.nodes) {
      visit(child);
    }
  }
}
