import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RowPlaceholder extends StatelessWidget {
  final int color;

  const RowPlaceholder({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
