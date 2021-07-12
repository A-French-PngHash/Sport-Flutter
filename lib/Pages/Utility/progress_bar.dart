import 'package:flutter/material.dart';

/// A segmented progress bar with the ability to show different colors for each
/// segments.
class SegmentedProgressBar extends StatelessWidget {
  final int nbElement;
  final int currentSegment;

  final double progressBarHeight = 5;
  final double _paddingAroundInProgress = 1;

  /// Full width of the progress bar.
  double fullWidth;

  late final double individualWidth;

  /// Constructor
  ///
  /// - nbElements : Number of segments.
  /// - currentSegment : Which segment is the user currently at. Starts at 1.
  SegmentedProgressBar(this.nbElement, this.currentSegment, this.fullWidth) {
    fullWidth -= 2 * _paddingAroundInProgress;
    individualWidth = fullWidth / nbElement;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: this.progressBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: individualWidth * currentSegment,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _paddingAroundInProgress),
              child: Container(
                width: individualWidth,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: currentSegment == 1 ? null : BorderRadius.horizontal(left: Radius.circular(10)),
                ),
              ),
            ),
            Container(
              width: fullWidth - (individualWidth * (currentSegment + 1)),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
