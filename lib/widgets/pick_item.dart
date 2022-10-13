import 'package:flutter/material.dart';

class BinPickItem extends StatefulWidget {
  final int index;

  const BinPickItem({required this.index});

  @override
  _BinPickItemState createState() => _BinPickItemState();
}

class _BinPickItemState extends State<BinPickItem> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven ? Colors.red[50] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Checkbox(
                      value: isChecked,
                      onChanged: (_) {
                        //print('sds');
                        setState(() {
                          isChecked = !isChecked;
                        });
                      }),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Bin Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: Text(
                    '54',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: Text(
                    '12',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isChecked,
              child: Row(
                children: [
                  Spacer(),
                  Text('Quantity need :'),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 60.0,
                      height: 40.0,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
