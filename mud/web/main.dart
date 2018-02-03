import 'dart:html';

void main() {
  querySelector('#enter').onClick.listen(clickedOnEnter);
}

clickedOnEnter(e) {
  InputElement input = querySelector("#commands");
  input.style.borderColor = "#55FF55";
  querySelector("#output").appendHtml("<div>${input.value}</div>");
}
