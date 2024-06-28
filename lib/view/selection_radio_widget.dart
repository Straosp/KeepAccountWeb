import 'package:flutter/material.dart';

import 'selection_radio_controller.dart';

class SelectionRadio extends StatefulWidget {

  final int defaultIndex;
  final SelectionRadioController controller;

  const SelectionRadio({super.key,required this.defaultIndex,required this.controller});
  @override
  State<StatefulWidget> createState() => _SelectionRadio();
}

class _SelectionRadio extends State<SelectionRadio> {

  @override
  void initState() {
    super.initState();
    widget.controller.selectIndex = widget.defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (ctx,child){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: getButtonStyle(widget.controller.selectIndex == 0),
                  onPressed: (){
                    widget.controller.updateSelectIndex(0);
                  },
                  child: Text("年",style: TextStyle(color: getTextColor(widget.controller.selectIndex == 0)),)
              ),
              TextButton(
                style: getButtonStyle(widget.controller.selectIndex == 1),
                onPressed: (){
                  widget.controller.updateSelectIndex(1);
                },
                child: Text("月",style: TextStyle(color: getTextColor(widget.controller.selectIndex == 1)),)
              ),
              TextButton(
                style: getButtonStyle(widget.controller.selectIndex == 2),
                onPressed: (){
                  widget.controller.updateSelectIndex(2);
                },
                child: Text("日",style: TextStyle(color: getTextColor(widget.controller.selectIndex == 2)),)
              ),
            ],
          );
        });
  }

  ButtonStyle getButtonStyle(bool isSelect){
    return isSelect ?
    ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        side: MaterialStateProperty.all(BorderSide(width: 0.5,color: Theme.of(context).colorScheme.primary))
    ) :
    ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(width: 0.5,color: Theme.of(context).colorScheme.onSecondary))
    );
  }

  Color getTextColor(bool isSelect){
    return isSelect ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.secondary;
  }

}
