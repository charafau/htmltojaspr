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

// The Referrer-Policy controls how much referrer information (sent with the Referer header) should be included with requests.
enum ReferrerPolicy {
  /// The Referer header will not be sent.
  noReferrer('no-referrer'),

  /// The Referer header will not be sent to origins without TLS (HTTPS).
  noReferrerWhenDowngrade('no-referrer-when-downgrade'),

  /// The sent referrer will be limited to the origin of the referring page: its scheme, host, and port.
  origin('origin'),

  /// The referrer sent to other origins will be limited to the scheme, the host, and the port. Navigations on the same origin will still include the path.
  originWhenCrossOrigin('origin-when-cross-origin'),

  /// A referrer will be sent for same origin, but cross-origin requests will contain no referrer information.
  sameOrigin('same-origin'),

  /// Only send the origin of the document as the referrer when the protocol security level stays the same (HTTPS→HTTPS), but don't send it to a less secure destination (HTTPS→HTTP).
  strictOrigin('strict-origin'),

  /// (default): Send a full URL when performing a same-origin request, only send the origin when the protocol security level stays the same (HTTPS→HTTPS), and send no header to a less secure destination (HTTPS→HTTP).
  strictOriginWhenCrossOrigin('strict-origin-when-cross-origin'),

  /// The referrer will include the origin and the path (but not the fragment, password, or username). This value is unsafe, because it leaks origins and paths from TLS-protected resources to insecure origins.
  unsafeUrl('unsafe-url');

  final String value;
  const ReferrerPolicy(this.value);
}
