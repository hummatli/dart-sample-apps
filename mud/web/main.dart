// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';
import 'package:http/browser_client.dart';
import 'package:SomeApp/client/world.dart';
import 'lib/mud.dart';

int x = 0, y = 0;

final String _serverUrl = 'localhost:8083/';
final BrowserClient _client = new BrowserClient();
World _api;

void main() {
  var protocol = window.location.protocol;
  _api = new World(_client, rootUrl: '$protocol//$_serverUrl');
  querySelector("#enter").onClick.listen(clickedOnEnter);

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

  var interaction = myEnvironment.stumbleUpon();
  outputHTML= "<div>${interaction}</div>";
  querySelector('#output').appendHtml(outputHTML);

  input.style.borderColor = "#55FF55";
}

void updateCoordinates(int rel_x, int rel_y) {
  x += rel_x;
  y += rel_y;

  _api.getWorldInfo("${x}", "${y}").then((value) {
    querySelector("#coordinates").innerHtml = "Place : $x , $y (${value.name})";
  });
  // querySelector("#coordinates").innerHtml = "Place : $x , $y ()";
}
