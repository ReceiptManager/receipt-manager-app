import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconTile extends StatelessWidget {
  final double width;
  final double height;
  final IconData iconData;
  final Function()? fun;

  const IconTile(
      {Key? key,
      required this.width,
      required this.height,
      required this.iconData,
      required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.white,
          ),
          onPressed: fun,
        ));
  }
}
