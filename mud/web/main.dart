// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';
import 'dart:convert';
import 'package:http/browser_client.dart';
import 'package:SomeApp/client/world.dart';
import 'lib/mud.dart';

final String _serverUrl = 'localhost:8083/';
final BrowserClient _client = new BrowserClient();
World _api;

Person person = new Person(0, 0, 200, 5);

// reading in a file
InputElement _fileInput;
FileReader _reader;

void main() {
  var protocol = window.location.protocol;
  _api = new World(_client, rootUrl: '$protocol//$_serverUrl');
  querySelector("#enter").onClick.listen(clickedOnEnter);

  // reading in a file
  _fileInput = querySelector("#files");
  _fileInput.onChange.listen((e) => _onFilesSelected());

  updateCoordinates(0,0);
}

Environment myEnvironment = new Environment("Wood");

void clickedOnEnter(e) {
  InputElement input = querySelector("#commands");

  String output = "";

  switch (input.value) {
  case 'left':
    updateCoordinates(-1, 0);
    output = "You are going left now.";
    break;
  case 'right':
    updateCoordinates(1, 0);
    output = "You are going right, are you sure?";
    break;
  case 'up':
    updateCoordinates(0, -1);
    output = "You are going up, are you sure?";
    break;
  case 'down':
    updateCoordinates(0, 1);
    output = "You are going down, are you sure?";
    break;
  default:
    output = "Use left, right, up, down please ...";
  }

  var outputHTML = "<div>${output}</div>";

  querySelector('#output').appendHtml(outputHTML);

  var interaction = myEnvironment.stumbleUpon(person);
  outputHTML= "<div>${interaction}</div>";
  querySelector('#output').appendHtml(outputHTML);

  input.style.borderColor = "#55FF55";

  // save the persons stats
  person.save();
  querySelector("#download").attributes['href'] = makeTextFile(JSON.encode(person.toJson()));
}

void updateCoordinates(int rel_x, int rel_y) {
  person.x += rel_x;
  person.y += rel_y;

  _api.getWorldInfo("${person.x}", "${person.y}").then((value) {
    querySelector("#coordinates").innerHtml = "Place : ${person.x} , ${person.y} (${value.name})";
  });
}

var textFile;
String makeTextFile(text) {
    var data = new Blob([text]);

    if (textFile != null) {
        Url.revokeObjectUrl(textFile);
    }
    textFile = Url.createObjectUrl(data);

    return textFile;
}

void _onFilesSelected() {
  var file = _fileInput.files[0];
  _reader = new FileReader();

  // If we use onloadend, we need to check the readyState.
  _reader.onLoadEnd.listen((evt) {
      if (evt.target.readyState == FileReader.DONE) { // DONE == 2
          // print(evt.target.result);
          person.load(evt.target.result);
          updateCoordinates(0,0);
      }
  });

  _reader.readAsText(file);
}
