/// The name/keyword for a browsing context (a tab, window, or &lt;iframe&gt;).
enum Target {
  /// The current browsing context. (Default)
  self('_self'),

  /// Usually a new tab, but users can configure browsers to open a new window instead.
  blank('_blank'),

  /// The parent browsing context of the current one. If no parent, behaves as [Target.self].
  parent('_parent'),

  /// The topmost browsing context (the "highest" context that's an ancestor of the current one). If no ancestors, behaves as [Target.self].
  top('_top');

  final String value;
  const Target(this.value);
}
