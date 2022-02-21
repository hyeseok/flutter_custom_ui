import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_ui/src/values/circle_value.dart';
import 'package:flutter_custom_ui/src/values/const_value.dart';

import 'colors/tp_colors.dart';

class TemperatureHorizontalBar extends StatefulWidget {
  final int maxIndex;
  final int currentIndex;
  final Color? baseBgColor;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final bool showCountView;

  const TemperatureHorizontalBar(
    this.maxIndex,
    this.currentIndex,
      {Key? key,
    this.baseBgColor = TPColors.baseBgColor,
    this.gradientStartColor = TPColors.baseGradientBottomColor,
    this.gradientEndColor = TPColors.baseGradientTopColor,
    this.showCountView = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TemperatureHorizontalBar();
}

class _TemperatureHorizontalBar extends State<TemperatureHorizontalBar> {

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody({double height = ConstValue.baseHorizontalHeight * 2}) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: height,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      _buildBarBg(),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      top: 0,
                      left: 0,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          _buildCircle(),
                          _buildCircle(circleSize: CircleValue.size * 0.9, bgColor: widget.gradientStartColor),
                          _buildCircle(circleSize: CircleValue.size / 3, bgColor: widget.baseBgColor)
                        ],
                      )
                  ),
                  Positioned(
                      child: _buildBar(width: ConstValue.baseHorizontalWidth * (widget.currentIndex > widget.maxIndex ? 1 : (widget.currentIndex / widget.maxIndex * 100 / 100)))
                  ),
                  Positioned(
                      top: 0, left: 0, right: 0,
                      child: SizedBox(
                        width: ConstValue.baseHorizontalWidth + CircleValue.size,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildBarPointLine(),
                        ),
                      )
                  )
                ],
              ),
            ),
            _buildCount()
          ],
        )
      ],
    );
  }

  _buildCount() {
    return !widget.showCountView ? const SizedBox() : Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Text('${widget.currentIndex}/${widget.maxIndex}'),
    );
  }

  _buildBar({double width = ConstValue.baseHorizontalWidth, double height = ConstValue.baseHorizontalHeight / 1.8}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.gradientStartColor!,
          ),
          margin: const EdgeInsets.only(left: CircleValue.size),
          width: width / 2,
          height: height,
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            gradient: LinearGradient(colors: [widget.gradientStartColor!, widget.gradientEndColor!], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          width: width - (width / 2),
          height: height,
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }

  _buildBarPointLine() {
    List<Widget> list = [];

    for(int i=0; i<7; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(top: 17, right: 4, left: 5),
        width: 1.5,
        height: ConstValue.baseVerticalWidth / 2.2,
        color: widget.baseBgColor!.withOpacity(0.8),
        child: const SizedBox(),
      ));
    }

    return list;
  }

  _buildBarBg({double width = ConstValue.baseHorizontalWidth, double height = (ConstValue.baseHorizontalHeight * 0.95)}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
              border: Border.all(width: 6, color: widget.baseBgColor!)
          ),
          width: width + CircleValue.size - 5,
          height: height,
        ),
      ],
    );
  }

  _buildCircle({double circleSize = CircleValue.size, Color? bgColor}) => Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(CircleValue.radius)),
      color: bgColor ?? widget.baseBgColor,
      border: Border.all(width: bgColor == null ? 5 : 0, color: bgColor ?? widget.baseBgColor!)
    ),
    child: SizedBox(width: circleSize, height: circleSize,),
  );

}