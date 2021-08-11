import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCount extends StatefulWidget {
  CartCount({Key key, this.val, this.max, this.callback})
    :super(key: key);
  final callback;
  int val;
  int max;
  @override
  _CartCountState createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  int indexNum;
  @override
  
  void initState() {
    indexNum = widget.val;
    super.initState();
  }
  
  
  void firedA(_num) {
    widget.callback(_num);
  }
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(
            border: Border.all(width: 0.5, color: Color(0xFF777777)),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
      child: Row(
        children: <Widget>[_reduceBtn(), _countArea(), _addBtn()],
      ),
    );
  }

 

  //减少按钮
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {
        if (indexNum > 1) {
          int _num = indexNum-1;
          firedA(_num);
          setState(() {
            indexNum--;
          });
        }
      },
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 0.5, color: Color(0xFF777777)))),
        child: Text('-', style: TextStyle(
          color: indexNum==1?Colors.black12:Colors.black,
          fontSize: 24
        ),),
      ),
    );
  }

  //加号按钮
  Widget _addBtn() {
    return InkWell(
      onTap: () {
          int _num = indexNum+1;
          firedA(_num);
          setState(() {
            indexNum++;
          });
      },
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 0.5, color: Color(0xFF777777)))),
        child: Text('+',style: TextStyle(
          fontSize: 20
        ),),
      ),
    );
  }

  //中间数量显示区域

  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(54),
      height: ScreenUtil().setHeight(32),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${indexNum}',style: TextStyle(
           fontSize: 17
        ),),
    );
  }
}
