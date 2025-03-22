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

/// The type for an &lt;input&gt; element.
enum InputType {
  /// A push button with no default behavior displaying the value of the value attribute, empty by default.
  button('button'),

  /// A check box allowing single values to be selected/deselected.
  checkbox('checkbox'),

  /// A control for specifying a color; opening a color picker when active in supporting browsers.
  color('color'),

  /// A control for entering a date (year, month, and day, with no time). Opens a date picker or numeric wheels for year, month, day when active in supporting browsers.
  date('date'),

  /// A control for entering a date and time, with no time zone. Opens a date picker or numeric wheels for date- and time-components when active in supporting browsers.
  dateTimeLocal('datetime-local'),

  /// A field for editing an email address. Looks like a text input, but has validation parameters and relevant keyboard in supporting browsers and devices with dynamic keyboards.
  email('email'),

  /// A control that lets the user select a file. Use the accept attribute to define the types of files that the control can select.
  file('file'),

  /// A control that is not displayed but whose value is submitted to the server.
  hidden('hidden'),

  /// A graphical submit button. Displays an image defined by the src attribute. The alt attribute displays if the image src is missing.
  image('image'),

  /// A control for entering a month and year, with no time zone.
  month('month'),

  /// A control for entering a number. Displays a spinner and adds default validation when supported. Displays a numeric keypad in some devices with dynamic keypads.
  number('number'),

  /// A single-line text field whose value is obscured. Will alert user if site is not secure.
  password('password'),

  /// A radio button, allowing a single value to be selected out of multiple choices with the same name value.
  radio('radio'),

  /// A control for entering a number whose exact value is not important. Displays as a range widget defaulting to the middle value. Used in conjunction min and max to define the range of acceptable values.
  range('range'),

  /// A button that resets the contents of the form to default values. Not recommended.
  reset('reset'),

  /// A single-line text field for entering search strings. Line-breaks are automatically removed from the input value. May include a delete icon in supporting browsers that can be used to clear the field. Displays a search icon instead of enter key on some devices with dynamic keypads.
  search('search'),

  /// A button that submits the form.
  submit('submit'),

  /// A control for entering a telephone number. Displays a telephone keypad in some devices with dynamic keypads.
  tel('tel'),

  /// The default value. A single-line text field. Line-breaks are automatically removed from the input value.
  text('text'),

  /// A control for entering a time value with no time zone.
  time('time'),

  /// A field for entering a URL. Looks like a text input, but has validation parameters and relevant keyboard in supporting browsers and devices with dynamic keyboards.
  url('url'),

  /// A control for entering a date consisting of a week-year number and a week number with no time zone.
  week('week');

  final String value;
  const InputType(this.value);
}
