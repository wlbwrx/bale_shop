import 'package:bale_shop/widgets/cart/toast.dart';


class ToastModel {
  static dynamic ctx;
  static void show(text) {
    // 错误时显示弹窗
    Toast.toast(ctx,msg: text, position: ToastPostion.center);
  }
}