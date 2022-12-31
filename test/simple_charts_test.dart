import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_charts/simple_charts.dart';
import 'package:simple_charts/src/date/date_cell.dart';

import 'data/data.dart';

void main() {
  group('Date chart', () {
    testWidgets('Check data is displayed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
            home: DateChart(
          data: dataDays,
          displayXAxis: true,
          displayYAxis: true,
        )),
      );

      // check Y axis values

      const minValue = 0;
      final maxValue = dataDays.values.max;
      final medValue = maxValue ~/ 2;

      expect(find.text('$minValue'), findsOneWidget);
      expect(find.text('$maxValue'), findsOneWidget);
      expect(find.text('$medValue'), findsOneWidget);

      // check X axis values

      final minDate = dataDays.keys.first;
      final maxDate = dataDays.keys.last;
      final midDate = minDate
          .add(Duration(seconds: maxDate.difference(minDate).inSeconds ~/ 2));
      expect(find.text(getDateString(minDate)), findsOneWidget);
      expect(find.text(getDateString(maxDate)), findsOneWidget);
      expect(find.text(getDateString(midDate)), findsOneWidget);
    });

    testWidgets('Check data is not displayed', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
            home: DateChart(
          data: dataDays,
          displayXAxis: false,
          displayYAxis: false,
        )),
      );

      // check Y axis values

      const minValue = 0;
      final maxValue = dataDays.values.max;
      final medValue = maxValue ~/ 2;

      expect(find.text('$minValue'), findsNothing);
      expect(find.text('$maxValue'), findsNothing);
      expect(find.text('$medValue'), findsNothing);

      // check X axis values

      final minDate = dataDays.keys.first;
      final maxDate = dataDays.keys.last;
      final midDate = minDate
          .add(Duration(seconds: maxDate.difference(minDate).inSeconds ~/ 2));
      expect(find.text(getDateString(minDate)), findsNothing);
      expect(find.text(getDateString(maxDate)), findsNothing);
      expect(find.text(getDateString(midDate)), findsNothing);
    });

    testWidgets('Check the display of cells > days', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DateChart(data: dataDays)),
      );

      final totalDisplayedDays = dataDays.length;
      expect(find.byType(DateCell), findsNWidgets(totalDisplayedDays));
    });

    testWidgets('Check the display of cells > months', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DateChart(data: dataMonths)),
      );

      // get distinct list of months
      final months = <DateTime>[];
      for (var element in dataMonths.keys) {
        final d = DateTime(element.year, element.month);
        if (!months.contains(d)) {
          months.add(d);
        }
      }
      expect(find.byType(DateCell), findsNWidgets(months.length));
    });

    testWidgets('Check the display of cells > years', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: DateChart(data: dataYears)),
      );

      expect(find.byType(DateCell), findsNWidgets(dataYears.keys.length));
    });
  });

  group('Percentage chart', () {
    testWidgets('Test data display', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: PercentageChart(data: data2)),
      );

      // display of data entries names
      expect(find.text(data2.keys.toList()[0]), findsWidgets);
      expect(find.text(data2.keys.toList()[1]), findsWidgets);
      expect(find.text(data2.keys.toList()[2]), findsWidgets);
      expect(find.text(data2.keys.toList()[3]), findsWidgets);

      // display of percentage of each entry
      expect(find.text('0%'), findsWidgets);
      expect(find.text('16%'), findsWidgets);
      expect(find.text('33%'), findsWidgets);
      expect(find.text('50%'), findsWidgets);
    });
  });
}

String getDateString(DateTime date) {
  return '${date.day}/${date.month}';
}
