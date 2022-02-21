import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_ui/src/values/circle_value.dart';
import 'package:flutter_custom_ui/src/values/const_value.dart';

import 'colors/tp_colors.dart';

class TemperatureVerticalBar extends StatefulWidget {
  final int maxIndex;
  final int currentIndex;
  final Color? baseBgColor;
  final Color? gradientBottomColor;
  final Color? gradientTopColor;
  final bool showCountView;

  const TemperatureVerticalBar(
    this.maxIndex,
    this.currentIndex,
  {Key? key,
    this.baseBgColor = TPColors.baseBgColor,
    this.gradientBottomColor = TPColors.baseGradientBottomColor,
    this.gradientTopColor = TPColors.baseGradientTopColor,
    this.showCountView = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TemperatureVerticalBar();
}

class _TemperatureVerticalBar extends State<TemperatureVerticalBar> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody({double width = ConstValue.baseVerticalWidth * 2}) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: width,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      _buildBarBg(),
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          _buildCircle(),
                          _buildCircle(circleSize: CircleValue.size * 0.9, bgColor: widget.gradientBottomColor),
                          _buildCircle(circleSize: CircleValue.size / 3, bgColor: widget.baseBgColor)
                        ],
                      )
                  ),
                  Positioned(
                      child: _buildBar(height: ConstValue.baseVerticalHeight * (widget.currentIndex > widget.maxIndex ? 1 : (widget.currentIndex / widget.maxIndex * 100 / 100)))
                  ),
                  Positioned(
                      left: 0, top: 0, bottom: 0,
                      child: SizedBox(
                        height: ConstValue.baseVerticalHeight + CircleValue.size,
                        child: Column(
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
        padding: const EdgeInsets.only(bottom: 10),
        child: Text('${widget.currentIndex}/${widget.maxIndex}'),
    );
  }

  _buildBar({double width = ConstValue.baseVerticalWidth / 1.8, double height = ConstValue.baseVerticalHeight}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            gradient: LinearGradient(colors: [widget.gradientBottomColor!, widget.gradientTopColor!], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
          width: width,
          height: height - (height / 2),
        ),
        AnimatedContainer(
          decoration: BoxDecoration(
            color: widget.gradientBottomColor!,
          ),
          margin: const EdgeInsets.only(bottom: CircleValue.size),
          width: width,
          height: height / 2,
          duration: const Duration(seconds: 1),
        ),
      ],
    );
  }

  _buildBarPointLine() {
    List<Widget> list = [];

    for(int i=0; i<7; i++) {
      list.add(Container(
        margin: const EdgeInsets.only(top: 3, bottom: 4, left: 17),
        width: ConstValue.baseVerticalWidth / 2.2,
        height: 1.5,
        color: widget.baseBgColor!.withOpacity(0.8),
        child: const SizedBox(),
      ));
    }

    return list;
  }

  _buildBarBg({double width = (ConstValue.baseVerticalWidth * 0.95), double height = ConstValue.baseVerticalHeight}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(CircleValue.radius), topRight: Radius.circular(CircleValue.radius)),
            border: Border.all(width: 6, color: widget.baseBgColor!)
          ),
          width: width,
          height: height + CircleValue.size - 2,
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