import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget 
{
  final String end_time;
 
  Countdown({
    @required this.end_time,
  });

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer _timer;
  int seconds;
  int day = 0;
  
  @override
  Widget build(BuildContext context) {
    return constructTime(seconds);
  }

  Widget constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    List<Widget> time = [];
    // if(day>0){
    //   time.add(
    //   Text(
    //     '${day}天',
    //     style: TextStyle(
    //       fontSize: 12,
    //       color: Color(0xFFFFFFFF),
    //     ),
    //   ),
    //   );
    // }
    time.add(
      Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
                        color: Color(0xFFF56211),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
        child: Text(
          formatTime(hour),
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
    time.add(
      Text(
        ':',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFAF23806),
          fontWeight: FontWeight.w500
        ),
      ),
    );
    time.add(
      Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 2, right: 2),
        decoration: BoxDecoration(
                         color: Color(0xFFF56211),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
        child: Text(
          formatTime(minute),
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
    time.add(
      Text(
        ':',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFAF23806),
          fontWeight: FontWeight.w500
        ),
      ),
    );
    time.add(
      Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 2, right: 0),
         decoration: BoxDecoration(
                         color: Color(0xFFF56211),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(2),
                          topLeft: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
        child: Text(
          formatTime(second),
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );

    return Row(
                          children: time
    );
  }
  //数字格式化，将 0~9 的时间转换为 00~09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void initState() {
    super.initState();

    DateTime time01 = DateTime.now();
    DateTime time02 = DateTime.parse(widget.end_time);
    int time;
    if(time02.millisecondsSinceEpoch>time01.millisecondsSinceEpoch){
      time = (time02.millisecondsSinceEpoch - time01.millisecondsSinceEpoch) ~/ 1000;
    }else{
      time = (time01.millisecondsSinceEpoch - time02.millisecondsSinceEpoch) ~/ 1000;
    }
    if (time > 86400) {
      day = time ~/ 86400;
      seconds = time - 86400 * day;
    } else {
      seconds = time;
    }
    if (seconds > 0) {
      startTimer();
    }
  }

  void startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        seconds--;
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }
}
