const List<String> windowEventAttributes = [
  "onafterprint",
  "onbeforeprint",
  "onbeforeunloa",
  "onerror",
  "onhashchange",
  "onload",
  "onmessage",
  "onoffline",
  "ononline",
  "onpagehide",
  "onpageshow",
  "onpopstate",
  "onresize	",
  "onstorage",
  "onunload	",
];

const List<String> formEventAttributes = [
  'onblur',
  'onchange',
  'oncontextmenu',
  'onfocus',
  'oninput',
  'oninvalid',
  'onreset',
  'onsearch',
  'onselect',
  'onsubmit',
];

const List<String> keyboardEventAttributes = [
  'onkeydown',
  'onkeypress',
  'onkeyup',
];

const List<String> mouseEventAttributes = [
  'onclick',
  'ondblclick',
  'onmousedown',
  'onmousemove',
  'onmouseout',
  'onmouseover',
  'onmouseup',
  'onmousewheel',
  'onwheel',
];

const List<String> dragEventAttributes = [
  'ondrag',
  'ondragend',
  'ondragenter',
  'ondragleave',
  'ondragover',
  'ondragstart',
  'ondrop',
  'onscroll',
];

const List<String> clipboardEventAttributes = ['oncopy', 'oncut', 'onpaste'];

const List<String> mediaEventAttributes = [
  'onabort',
  'oncanplay',
  'oncanplaythrough',
  'oncuechange',
  'ondurationchange',
  'onemptied',
  'onended',
  'onerror',
  'onloadeddata',
  'onloadedmetadata',
  'onloadstart',
  'onpause',
  'onplay',
  'onplaying',
  'onprogress',
  'onratechange',
  'onseeked',
  'onseeking',
  'onstalled',
  'onsuspend',
  'ontimeupdate',
  'onvolumechange',
  'onwaiting',
];

const List<String> mistEventAttributes = ['ontoggle'];

const List<String> allEventAttributes = [
  ...windowEventAttributes,
  ...formEventAttributes,
  ...keyboardEventAttributes,
  ...mouseEventAttributes,
  ...dragEventAttributes,
  ...clipboardEventAttributes,
  ...mediaEventAttributes,
  ...mistEventAttributes,
];
