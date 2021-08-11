

doubleText(d0) {
    // 四舍五入
    if(d0!=null){
        int a = d0.round(); // 13
      //向上取整
      int b = d0.ceil(); // 14
      //向下取整
      int c = d0.floor(); // 13
      if (a == b && a == c) {
        return a;
      }else{
        return d0;
      }
    }
    return "";
   
}

  
  numString(a) {
    var today = DateTime.now();
    var date1 = today.millisecondsSinceEpoch ~/ 10000000 % 100000;
    var num = 0;
    // random.nextInt(1000);
    num = date1 - a;
    var num1 = 0;
    if (num > 10000) {
      num = num ~/ 10;
    }
    if (num > 5000 && num <= 5000) {
      num = num ~/ 5;
    }
    if (num > 2000 && num <= 5000) {
      num = num ~/ 3;
    }

    if(a > 10000){
      num1 = a % 100;
    }else if(a>1000&& a <=10000){
      num1 = a % 10;
    }else{
      num1 = a % 1000;
    }
    return num + num1;
  }



sizeHeight(data) {
  double num = 1;
  if(data< 667){
      num = 0.52;
  }

  if(data>= 667 && data <736){
     num = 0.52;
  }

  if(data>= 736 && data <812){
      num = 0.54;
  }

  if(data>= 812 && data <844){
      num = 0.52;
  }

  if(data>= 844 && data <896){
       num = 0.53;
  }

  if(data>= 896){
    num = 0.54;
  }
  return num;
}


sizeHeight2(data) {
  double num = 1;

  if(data< 667){
      num = 0.58;
  }

  if(data>= 667 && data <736){
     num = 0.58;
  }

  if(data>= 736 && data <812){
      num = 0.61;
  }

  if(data>= 812 && data <844){
      num = 0.59;
  }

  if(data>= 844 && data <896){
       num = 0.6;
  }

  if(data>= 896){
    num = 0.61;
  }
  
  return num;
}



sizeHeight3(data) {
  double num = 145;
  
  if(data< 667){
      num = 160;
  }

  if(data>= 667 && data <736){
      num = 160;
  }

  if(data>= 736 && data <812){
      num = 165;
  }

  if(data>= 812 && data <844){
       num = 165;
  }

  if(data>= 844 && data <896){
       num = 165;
  }

  if(data>= 896){
     num = 175;
  }
  
 
  return num;
}


getVersionAndroid(){
  return "2.1.3";
}

getVersionIos(){
  return "2.0.6";
}














