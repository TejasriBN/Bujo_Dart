import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,

        // style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.da),

        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          isDense: true,
          enabled: false,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          counterText: "",
          labelText: "Upload Proof",
          fillColor: Colors.grey,
          suffix:
              ElevatedButton(onPressed: () {}, child: Text('Upload document')),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey)),
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            Icons.upload_rounded,
          ),
        ));
  }
}
