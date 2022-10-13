import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_indicators/progress_indicators.dart';


class OpenTokConfig {

  static String API_KEY = "47353541";
  static String SESSION_ID = "2_MX40NzM1MzU0MX5-MTYzNDg5NDA0OTc2M35iczlGSzdoV2M3cXkyN3p1Y1BhZ1VqT0Z-fg";
  static String TOKEN = "T1==cGFydG5lcl9pZD00NzM1MzU0MSZzaWc9YjkzOTJhN2Y5YmU3ZDliZWVkMDY2ZDMxMjI0NmY4NmNlMDk1NGUxZDpzZXNzaW9uX2lkPTJfTVg0ME56TTFNelUwTVg1LU1UWXpORGc1TkRBME9UYzJNMzVpY3psR1N6ZG9WMk0zY1hreU4zcDFZMUJoWjFWcVQwWi1mZyZjcmVhdGVfdGltZT0xNjM0ODk0MDUwJm5vbmNlPTAuMjA4MzgzODk0MzQzMjE0OCZyb2xlPW1vZGVyYXRvciZleHBpcmVfdGltZT0xNjM3NDg2MDUwJmluaXRpYWxfbGF5b3V0X2NsYXNzX2xpc3Q9";

  static void message(){

    //print('You are Calling Static Method');
  }

}


class VideoCallW extends StatefulWidget {

  //VideoCallW({Key? key}) : super(key: key);
  //final String title;
  static const routeName = '/vcScreen';
  @override
  _VideoCallWState createState() => _VideoCallWState();
}

class _VideoCallWState extends State<VideoCallW> {
  SdkState _sdkState = SdkState.LOGGED_OUT;
  bool _publishAudio = true;
  bool _publishVideo = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Call"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SizedBox(height: 64), _updateView()],
        ),
      ),
    );
  }

  static const platformMethodChannel = const MethodChannel('com.vonage');

  _VideoCallWState() {
    platformMethodChannel.setMethodCallHandler(methodCallHandler);
    //print("Started");
    _initSession();
  }

  Future<dynamic> methodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'updateState':
        {
          setState(() {
            var arguments = 'SdkState.${methodCall.arguments}';
            _sdkState = SdkState.values.firstWhere((v) {
              return v.toString() == arguments;
            });
          });
        }
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  Future<void> _initSession() async {
    await requestPermissions();

    String token = "ALICE_TOKEN";
    dynamic params = {
      'apiKey': OpenTokConfig.API_KEY,
      'sessionId': OpenTokConfig.SESSION_ID,
      'token': OpenTokConfig.TOKEN
    };

    try {
      await platformMethodChannel.invokeMethod('initSession', params);
    } on PlatformException catch (e) {
      //print(e);
    }
  }

  Future<void> _makeCall() async {
    try {
      await requestPermissions();

      await platformMethodChannel.invokeMethod('makeCall');
    } on PlatformException catch (e) {
      //print(e);
    }
  }

  Future<void> requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<void> _swapCamera() async {
    try {
      await platformMethodChannel.invokeMethod('swapCamera');
    } on PlatformException catch (e) {}
  }

  Future<void> _toggleAudio() async {
    _publishAudio = !_publishAudio;

    dynamic params = {'publishAudio': _publishAudio};

    try {
      await platformMethodChannel.invokeMethod('publishAudio', params);
    } on PlatformException catch (e) {}
  }

  Future<void> _toggleVideo() async {
    _publishVideo = !_publishVideo;
    _updateView();

    dynamic params = {'publishVideo': _publishVideo};

    try {
      await platformMethodChannel.invokeMethod('toggleVideo', params);
    } on PlatformException catch (e) {}
  }



  Widget _updateView() {
    bool toggleVideoPressed = false;

    if (_sdkState == SdkState.LOGGED_OUT) {
      return ElevatedButton(
          onPressed: () {
            _initSession();
          },
          child: Text("Init session"));
    } else if (_sdkState == SdkState.WAIT) {
      return Center(
        child: LinearProgressIndicator(),
      );
    } else if (_sdkState == SdkState.LOGGED_IN) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: PlatformViewLink(
              viewType: 'opentok-video-container', // custom platform-view-type
              surfaceFactory:
                  (BuildContext context, PlatformViewController controller) {
                return AndroidViewSurface(
                  controller: controller as AndroidViewController,
                  gestureRecognizers: const <
                      Factory<OneSequenceGestureRecognizer>>{},
                  hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                );
              },
              onCreatePlatformView: (PlatformViewCreationParams params) {
                return PlatformViewsService.initSurfaceAndroidView(
                  id: params.id,
                  viewType: 'opentok-video-container',
                  // custom platform-view-type,
                  layoutDirection: TextDirection.rtl,

                  creationParams: {},
                  creationParamsCodec: StandardMessageCodec(),
                )
                  ..addOnPlatformViewCreatedListener(
                      params.onPlatformViewCreated)
                  ..create();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Icon( Icons.phone),//Text("Toggle Audio"),
                onPressed: () {
                  _toggleAudio();
                  _toggleVideo();
                  _sdkState = SdkState.LOGGED_OUT;
                  _updateView();
                  setState(() {});
                  Navigator.pop(context);
                },

                style: ButtonStyle(
                  //backgroundColor:Colors.red,
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _swapCamera();
                },
                child: Icon(Icons.swap_horizontal_circle_sharp),//Text("Swap " "Camera"),
              ),
              // IconButton(
              //     icon: Icon(Icons.bluetooth),
              //     color: Colors.grey,
              //     highlightColor: Colors.red,
              //     hoverColor: Colors.green,
              //     focusColor: Colors.purple,
              //     splashColor: Colors.yellow,
              //     disabledColor: Colors.amber,
              //     iconSize: 48,
              //     onPressed: () {      _toggleAudio();    },
              //     ),
              ElevatedButton(
                child: Icon(Icons.mic),//Text("Toggle Audio"),
                onPressed: () {
                  _toggleAudio();
                },

                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (!_publishAudio) return Colors.grey;
                      return Colors.amberAccent; // Use the component's default.
                    },
                  ),
                ),
              ),
              ElevatedButton(
                child: Icon( _publishVideo ? Icons.videocam : Icons.videocam_off),//Text("Toggle Video"),
                onPressed: () {
                  _toggleVideo();
                  Icon( _publishVideo ? Icons.videocam : Icons.videocam_off);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (!_publishVideo) return Colors.grey;
                      return Colors.amberAccent; // Use the component's default.
                    },
                  ),
                ),
              ),
            ],


          ),
        ],
      );
    } else {
      return Center(child: Text("ERROR"));
    }
  }
}

enum SdkState { LOGGED_OUT, LOGGED_IN, WAIT, ON_CALL, ERROR }