import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/widgets/padding/padding_widget.dart';

class StatsCard extends StatelessWidget {
  final String statsTitle;
  final String statsSubTitle;
  final Widget widget;

  StatsCard(this.statsTitle, this.statsSubTitle, this.widget);

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
        widget: AspectRatio(
            aspectRatio: 1.25,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color(0xFFEFEFF4),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          statsTitle,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          statsSubTitle,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: widget,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}

class WeeklyChartData {
  final date;

  final double total;

  WeeklyChartData(this.date, this.total);
}

class ReceiptMonthData {
  final int month;

  final double total;

  ReceiptMonthData(this.month, this.total);
}
