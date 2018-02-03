import 'dart:html';

void main() {
  querySelector('#enter').onClick.listen(clickedOnEnter);
}

clickedOnEnter(e) {
  InputElement input = querySelector("#commands");
  input.style.borderColor = "#55FF55";
  String output = "";

  switch (input.value) {
  case 'left':
    //updateCoordinates(-1, 0);
    output = "You are going left now.";
    break;
  case 'right':
    //updateCoordinates(1, 0);
    output = "You are going right, are you sure?";
    break;
  case 'up':
    //updateCoordinates(0, -1);
    output = "You are going up, are you sure?";
    break;
  case 'down':
    //updateCoordinates(0, 1);
    output = "You are going down, are you sure?";
    break;
  default:
    output = "Use left, right, up, down please ...";
  }

  var outputHTML = "<div>${output}</div>";
  querySelector("#output").appendHtml(outputHTML);
}
