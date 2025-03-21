import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:htmltojaspr/src/types.dart';

class HtmlConverter {
  String covert(String htmlSource) {
    final document = parseFragment(htmlSource);

    print('outer html:');
    print(document.outerHtml);

    // visitor output
    // print('html visitor:');
    // _Visitor().visit(document);

    print('jaspr visitor:');

    final jasprConverterPrettify = JaspConverterVisitor(prettify: true)
      ..visit(document);
    print(jasprConverterPrettify.jasprTreePrettified);

    final jasprConverter = JaspConverterVisitor()..visit(document);

    return jasprConverter.jasprTree;
  }
}

class JaspConverterVisitor extends TreeVisitor {
  String _indent = '';

  String _jasprTree = '';

  final List<String> _typedAttributes = [
    'id',
    'class',
    'href',
    'type',
    'target',
    'referrerpolicy',
  ];

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
    if (isVoidElement(node.localName)) {
      final val = ('$_indent<${node.localName}/>');
      _jasprTree += val;
    } else {
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

      if (node.attributes.containsKey('target')) {
        val +=
            " target: ${Target.values.firstWhere((t) => t.value == node.attributes['target']).toString()}, ";
      }

      if (node.attributes.containsKey('referrerpolicy')) {
        val +=
            " referrerPolicy: ${ReferrerPolicy.values.firstWhere((t) => t.value == node.attributes['referrerpolicy']).toString()}, ";
      }
      _typedAttributes;

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
    }
  }

  @override
  void visitChildren(Node node) {
    for (var child in node.nodes) {
      visit(child);
    }
  }
}
