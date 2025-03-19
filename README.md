The `htmltojaspr` project is a tool designed to convert HTML code into Dart code compatible with the [Jaspr framework](https://jaspr.site/), enabling developers to seamlessly integrate HTML structures into their Jaspr applications.

## Features

- **HTML to Jaspr Conversion**: Transforms standard HTML elements into their corresponding Jaspr components.

## Getting Started

### Prerequisites

- Ensure you have [Dart SDK](https://dart.dev/get-dart) installed on your system.


## Usage

To convert an HTML string to a Jaspr component:


```dart
import 'package:htmltojaspr/htmltojaspr.dart';

void main() {
  String htmlContent = '''
  <div>
    <h1>Hello, World!</h1>
    <p>This is a sample HTML content.</p>
  </div>
  ''';

  final jasprComponent = HtmlConverter().covert(htmlContent);
  print(jasprComponent);
}
```


This will output Dart code that represents the provided HTML structure as Jaspr components.

## Additional Information

- **Contributing**: Contributions are welcome! Please submit issues and pull requests on the [GitHub repository](https://github.com/charafau/htmltojaspr).

- **License**: This project is licensed under the BSD-3-Clause License. See the [LICENSE](https://github.com/charafau/htmltojaspr/blob/main/LICENSE) file for details.

For more details and updates, visit the [GitHub repository](https://github.com/charafau/htmltojaspr). 