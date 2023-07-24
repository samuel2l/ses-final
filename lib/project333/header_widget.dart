import 'package:flutter/material.dart';
import 'constants.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final double _fontSize;
  final String text;
  const HeaderWidget(
    this._height,
    this._fontSize,
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState(
        _height,
        text,
        _fontSize,
      );
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final double _height;
  final double _fontSize;
  String text;

  _HeaderWidgetState(
    this._height,
    this.text,
    this._fontSize,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(
        children: [
          ClipPath(
            clipper: ShapeClipper([
              Offset(width / 5, _height),
              Offset(width / 2, _height - 60),
              Offset(width / 5 * 4, _height + 20),
              Offset(width, _height - 18)
            ]),
            child: Container(
              decoration: BoxDecoration(
                color: UgYellow,
              ),
            ),
          ),
          ClipPath(
            clipper: ShapeClipper([
              Offset(width / 3, _height + 20),
              Offset(width / 10 * 8, _height - 60),
              Offset(width / 5 * 4, _height - 60),
              Offset(width, _height - 20)
            ]),
            child: Container(
              height: 238,
              decoration: BoxDecoration(color: UgBlue),
            ),
          ),
          Column(
            children: [
              Container(
                height: 200,
                width: 400,

                child: Image.asset('assets/images/newses-removebg-preview.png'),
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/SES_LOGO-removebg-preview.png',),
                //     fit:BoxFit.cover
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _fontSize,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
