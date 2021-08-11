import 'package:flutter/material.dart';

class ServiceTerms extends StatefulWidget {
  @override
  _ServiceTermsState createState() => _ServiceTermsState();
}

class _ServiceTermsState extends State<ServiceTerms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        title: Text(
          '客戶服務條款',
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
                  Text('親愛的客戶您好！'),
                  Text(
                      '歡迎您使用阿噗特賣購物，阿噗是由【香港芭樂科技有限公司】（以下稱本公司）經營的虛擬購物平臺，為盡可能保護您的權益及確認契約關系，所有申請阿噗服務（以下稱本服務）之使用者，都應該詳細閱讀下列服務條款：'),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶服務及權利義務',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Text('一：本公司主要提供您以下服務：',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('1.商品銷售及配送服務'),
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
                        child: Text('虛擬通路商品7天猶豫期（請註意猶豫期非試用期）；'),
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
                        child: Text('購物優惠回饋；'),
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
                        child: Text('貨到付款。'),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('2.我們的商品頁面會提供單一商品可選購數量上限供客戶參考，原則上我們僅在該數量上限內進行出貨。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('3.運費計價方式將明載於網頁中，如未有記載將由本公司負擔。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('4.客戶相關權益通知，包含但不限商品試用、抽獎活動、服務滿意度調查或其他未來新增之會員服務。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('5.本公司得依實際情形，增加、修改或終止上述相關服務。'),
                  ),
                  Text('二：當您於阿噗特賣完成註冊手續，即視為已知悉並完全同意本服務條款的所有約定服務項目。',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '另外，當您使用阿噗特賣特定服務時，可能會依據該特定服務之性質，而須遵守阿噗所另行公告之服務條款或相關規定，此另行公告之服務條款或相關規定亦並入屬於本服務條款之一部分。'),
                  ),
                  Text(
                      '三：若您未滿二十歲，應與您的法定代理人閱讀、了解同意本服務條款之所有內容及其後修改變更後，放得註冊使用或繼續使用。',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '當您使用或繼續使用阿噗特賣所提供之任一服務時，即表示您的法定代理人已閱讀、了解並同意接收本服務條款之所有內容及其後修改變更。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('四：客戶及阿噗均同意以電子文件作為意思表示之方法。',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '五：本公司針對任一違反法律規定、未遵循雙方約定、惡意濫用服務權益之客戶，保有終止該客戶賬戶服務之權利。',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '六：本公司有權於未來任何時間基於需要修改條款內容，並得將修改內容以電子郵件、電話或其他適當方式通知客戶。',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '七：本公司為提供服務之必要通知客戶訊息時，得以客戶所留存之任一聯系方式為之，客戶之聯系資料如有異動應隨時以登錄網站、電話通知等方式進行資料更新，維持資料之正確性、即時性及完整性。',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '若因您資料錯誤、過期或其他非可歸責本公司的原因，致本公司送達的訊息無法接收，仍視為本公司已完成該通知的送達。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶賬號、密碼與安全',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '1. 如客戶透過本公司各通路註冊為阿噗會員，註冊賬號及密碼，不能重復登錄。客戶註冊時必須填寫確實之個人資料，若發現有不實登錄時，本公司得暫停或總之您的客戶資格，若有違反中華民國相關法律，亦將依法追究。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '2. 客戶應該妥善保管密碼，不可以將密碼泄漏或提供給他人知道或使用。以同一個客戶賬號和密碼使用本服務所進行的所有行為，都將被認為是該客戶本人的行為，應由該客戶依法負責。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '3. 客戶如果發現或懷疑有第三人使用其客戶賬號或密碼，應該立即通知本公司，本公司於知悉後將立即暫停該賬號所生交易之處理及後續利用。但客戶於通知前依法應付之法律上責任並不因此通知而免除。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶交易',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '1. 商品交易頁面呈現之商品名稱、價格、內容、規格、型號及其他相關資訊，皆為您與本公司締結契約之一部分。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '2. 您同意依據本公司所提供之確認商品數量及價格機制進行下單。本公司對於下單內容，得於下單後兩個工作日內附正常理由拒絕，但客戶已付款者，視為契約成立。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '3.依據消費者保護法第19條第1、2、3項規定：【1. 通訊交易或訪問交易之消費者，得於收到商品或接受服務後七日內，以退回商品或書面同時方式解除契約，無須說明理由及負擔任何費用或對價。2. 但通訊交易有合理例外情事者，不在此限。3. 前項但書合理例外情事，由行政院定之。】因此契約成立並於您收受商品後，除非政府另有公告有限適用其他法令，原則上您享有前述消費者保護法第19條第1項解除契約之權利，如有退貨需求，請參閱【常見問題】中的退貨/退款程序說明。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '付款相關權益',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('本公司提供多種的付款方式供您選擇，詳細內容請參考【常見問題】之付款方式說明。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶隱私權保障',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('1. 關於您註冊或使用本服務時所提供之個人資料，本公司將依【隱私權聲明政策】為利用與保護。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '2. 客戶使用本服務時，其使用過程中所有的資料記錄，以本服務資料庫所記錄之資料為準，如有任何糾紛，以本服務資料庫所記錄之電子資料為認定標準，但客戶如能提出其他資料並證明為真實著則不在此限。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '智慧財產權',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '本公司網站上所有內容，包括但不限於著作、圖片、檔案、資訊、資料、網站架構、網站畫面的安排、網頁設計，均由本公司或其他權利人依法擁有其智慧財產權，包括但不限於商標權、專利權、著作權、營業秘密與專有技術等。任何人不得徑自使用、秀噶、重制、公開播放、改作、散布、發行、公開發表、進行還原工程、解編。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '若您欲飲用或轉載前述網站內容，必須依法取得本公司或其他權利人的事前書面同意。尊重智慧財產權是您應盡的義務，如有違反，您應對本公司負損害賠償責任（包括但不限於訴訟費用及律師費用等）。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '暫停服務',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '本公司以目前一般認為合理之方式及技術，維護本服務之正常運作。但於下述情況，本公司將暫停或中斷本服務之全部或一部分'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('1. 對本服務相關軟硬體設備搬遷、更換、升級、保護或維修；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('2. 使用者有任何違反政府法令或本使用條款情形；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('3. 天災或其他不��抗力之因素所導致之服務停止或中斷；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('4. 其他不可歸責於本公司之事由所致之服務停止或中斷；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '5. 非本公司所的控制之事由而致本服務資訊顯示不正確、或遭偽造、篡改、刪除致系統中斷或不能正常運作時。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '本條款之效力、解釋、問題咨詢',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('1. 本契約條款中，任何條款之全部或一部分無效時，不影響其他約定之效力；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('2. 本契約條款如有異議，將為有利於客戶之解釋；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('3. 客戶如對服務有相關問題，可透過在線客戶或客服信箱進行咨詢；'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '4. 客戶與本公司之權利義務關系，應依網路規範及中華民國法令解釋及規章、慣例為依據處理。本公司的任何聲明、條款如有未盡完善之處，將以最大誠意，依誠實信用、平等互惠原則，共商解決之道。'),
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
