import 'package:flutter/material.dart';

class Problem extends StatefulWidget {
  @override
  _ProblemState createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        title: Text(
          '常見問題',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Image.asset(
                  'assets/icons/icon-back-light.png',
                  width: 20,
                  height: 20,
                  color: Colors.black,
                ),
              )),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '1. 阿噗特賣的商品都是正品嗎？',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '阿噗甄選秉承一貫的嚴謹態度，對商品的產地、工藝、原材料都嚴格把關，力求幫消費者甄選到最優質的商品，您可以放心選購。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '2. 阿噗特賣的訂單如何配送？',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '阿噗甄選會根據顧客所在地和商品的尺寸重量優選物流配送商，確保優質用戶體驗。目前暫不支持自選快遞，具體物流信息可在下單成功後在【顧客中心】中查看。也可以保留訂單號，詢問在線客服，實時追蹤商品物流信息。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '3. 我的包裹多長時間能送到？',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('我們會在訂單支付成功後10-15個工作天送達，具體送達時間視快遞配送時間而定。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '4. 實物與圖片有色差嗎？',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '阿噗特賣中的商品照片均以實物拍攝，顏色經設計師校對，由於對不同的電腦顯示器、光線、亮度都有差異，造成輕微色差難以避免。介意者慎拍。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '5. 下單後可以修改訂單信息嗎？',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('確認結賬前，用戶可以在訂單詳情頁中修改收貨信息，修改結果以實際頁面修改提示為準。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('確認結賬後，若要更改收貨信息，請在下單後24小時內，聯系網路客服並提供正確的收貨信息。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('註：只要24小時內聯系客服，並提供正確的收貨信息，即代表受理成功。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('超過24小時，因商品已經進入倉庫備貨打包系統，所以無法更改收貨信息。敬請諒解。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '6. 退換貨須知',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('自收到商品之日起7日內，顧客可在線申請退換貨。超過7日，不受理退換貨申請。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('註：以上時限為猶豫期，而非試穿/試用期，所以您退回的商品必須是全新的狀態、而且完整包裝。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('美妝產品為私人消耗性產品，一經拆封或使用，將不可退換貨。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('註：只要在7日內聯系網路客服，並提供退換貨所需資料，即代表受理申請成功。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('退貨請提供以下資料：'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('1、訂單姓名電話和包裹單照片；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('2、提供收到的產品展開實拍圖；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('3、您的戶名、開戶行代碼、分行名稱、賬號的文字版和銀行賬簿照片。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        '7. 違規訂單處理規則',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '為了維護廣大阿噗特賣會員的合法權益，一旦發現存在如下惡意刷單、刷券的行為（包括但不限於於以下行為）：'),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('通過機器手段惡意批量刷取優惠券，並在阿噗特賣進行下單購買的訂單；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child:
                            Text('利用軟件、技術手段或其他方式，為套取商品、優惠券、優惠活動、運費或其他利益的下單行為；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('多次進行刷單行為。'),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('用戶承諾其自願接受阿噗特賣對違規訂單進行以下一項或多項操作：'),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('取消訂單；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('不發貨；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('對已出庫、發貨的訂單進行攔截、追回；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('暫停或阻止後續在阿噗特賣購物；'),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black),
                        child: Text('·'),
                      ),
                      Expanded(
                        child: Text('其他阿噗認為有必要的管控措施。'),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('註：對於本規則規定的違規訂單，如訂單被取消、不發貨等，阿噗不提供任何賠付、補償。',style: TextStyle(
                      fontWeight: FontWeight.w400
                    ),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
