import 'package:flutter/material.dart';

class CustomSnackBar {
  final BuildContext context;
  final Key key;

  CustomSnackBar({this.key, this.context})
      : assert(context != null);

  void showErrorSnackBar(final msg) {
    showSnackBar(text: "Error: $msg", color: Colors.red[400]);
  }

  ScaffoldMessengerState get _state {
    return ScaffoldMessenger.of(context);
  }

  void showLoadingSnackBar() {
    hideAll();
    final snackBar = SnackBar(
      key: key,
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10.0),
          Text("Loading..."),
        ],
      ),
      backgroundColor: Colors.green[400],
      duration: Duration(minutes: 1),
    );
    _state.showSnackBar(snackBar);
  }

  void showSnackBar({
    @required String text,
    Duration duration = const Duration(hours: 1),
    Color color,
    bool action = true,
  }) {
    hideAll();
    final snackBar = SnackBar(
      key: key,
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color ?? Colors.green[400],
      duration: duration,
      action: action
          ? SnackBarAction(
              label: "Clear",
              textColor: Colors.black,
              onPressed: () =>     _state.removeCurrentSnackBar(),
            )
          : null,
    );
    _state.showSnackBar(snackBar);
  }

  void hideAll() {
    _state.removeCurrentSnackBar();
  }
}
