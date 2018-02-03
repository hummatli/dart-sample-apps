import 'dart:html';

void main() {
  querySelector('#output').text = 'Your Dart app is running. My Changes1';
  querySelector('#enter').onClick.listen(clickedOnEnter);
}

clickedOnEnter(e) {
  InputElement input = querySelector("#commands");
  querySelector("#output").appendHtml(input.value);
}
