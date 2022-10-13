import 'package:flutter/material.dart';

class HeaderBanner extends StatelessWidget {
  final String title;

  const HeaderBanner({required this.title});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      right: -height * 0.25 / 2,
                      child: Icon(
                        Icons.circle,
                        size: height * 0.25,
                        color: Colors.white38,
                      ),
                    ),
                    Positioned(
                      right: -30,
                      top: -90,
                      child: Icon(
                        Icons.circle,
                        size: height * 0.25,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 28.0),
                  ),
                ),
                SizedBox(
                  height: 36.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
