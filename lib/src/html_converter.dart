import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';

class HtmlConverter {
  String covert(String htmlSource) {
    final document = parseFragment(htmlSource);

    print('outer html:');
    print(document.outerHtml);

    // visitor output
    print('html visitor:');
    _Visitor().visit(document);

    print('jaspr visitor:');

    final jasprConverterPrettify = JaspConverterVisitor(prettify: true)
      ..visit(document);
    print(jasprConverterPrettify.jasprTreePrettified);

    final jasprConverter = JaspConverterVisitor()..visit(document);

    return jasprConverter._jasprTree;
  }
}

class _Visitor extends TreeVisitor {
  String indent = '';

  @override
  void visitText(Text node) {
    if (node.data.trim().isNotEmpty) {
      print('$indent${node.data.trim()}');
    }
  }

  @override
  void visitElement(Element node) {
    if (isVoidElement(node.localName)) {
      print('$indent<${node.localName}/>');
    } else {
      print('$indent<${node.localName}>');
      indent += '  ';
      visitChildren(node);
      indent = indent.substring(0, indent.length - 2);
      print('$indent</${node.localName}>');
    }
  }

  @override
  void visitChildren(Node node) {
    for (var child in node.nodes) {
      visit(child);
    }
  }
}

class JaspConverterVisitor extends TreeVisitor {
  String _indent = '';

  String _jasprTree = '';

  String get jasprTree => _jasprTree;

  String get jasprTreePrettified =>
      _jasprTree.replaceAll(')],', ')],\n').replaceAll('([', '([\n');

  final bool _prettify;

  JaspConverterVisitor({bool prettify = false}) : _prettify = prettify;

  @override
  void visitText(Text node) {
    if (node.data.trim().isNotEmpty) {
      final val = ('$_indent text([${node.data.trim()})],');

      _jasprTree += val;
    }
  }

  @override
  void visitElement(Element node) {
    if (isVoidElement(node.localName)) {
      final val = ('$_indent<${node.localName}/>');
      _jasprTree += val;
    } else {
      var val = ('$_indent${node.localName}([');

      if (node.attributes.containsKey('class')) {
        val += " classes: '${node.attributes['class']}',";
      }

      if (_prettify) {
        _indent += '  ';
      }

      _jasprTree += val;
      visitChildren(node);
      if (_prettify) {
        _indent = _indent.substring(0, _indent.length - 2);
      }
      val = ('$_indent)],');

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
