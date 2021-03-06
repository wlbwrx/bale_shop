import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
        title: Text(
          '客戶隱私政策',
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
                      '這份隱私權的保障聲明，為因應社會環境及法令規定的變化與科技的進步，【香港芭樂科技有限公司】為保護客戶隱私，有權修改這份公告聲明，並盡速更新與告知客戶。'),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '【香港芭樂科技有限公司】非常尊重客戶的隱私權，對於客戶資料的獲取、處理及利用均遵守中華民國政府之【個人資料保護法】及相關法令規範，您可以參照以下隱私權政策，了解我們的具體措施。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料獲取方式',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '我們擁有客戶的個人資料，是由使用我們所提供的購物平臺的註冊會員或消費之客戶所提供，或是由我們在其他行銷活動中合法取得的。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料獲取種類',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('我們會依據阿噗購物平臺提供之服務，請客戶提供必要之作業資料：'),
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
                        child: Text(
                            '阿噗購物平臺之會員或客戶，我們會請您提供基本資料，包含您的姓名、聯絡電話、聯絡地址、電子郵件信箱及其他您提供的之資料；'),
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
                        child: Text(
                            '當您制定商品配送服務時，我們會請您提供配送資料，包含收件人之姓名、聯絡電話、聯絡地址及其他必要配送聯絡資料；'),
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
                        child: Text('當您有實際消費行為時，我們會留存您的賬務資料；'),
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
                        child: Text(
                            '我們基於提供市場分析、贈獎活動、會員及客戶權益通知等相關服務，將會為必要作業請您提供其他資料'),
                      )
                    ],
                  ),



                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料獲取目的',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('我們僅會在提供商品銷售、金融交易授權、物流配送、廣告行銷、市場分析、贈獎活動、會員權益通知及相關服務時，為作業之必要運用您的個人資料：'),
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
                        child: Text(
                            '物流寄送：我們會與提供客戶商品銷售、物流配送等履行訂單之服務，提供配送資料於合作廠商及物流商；'),
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
                        child: Text(
                            '金融交易授權：您所提供之賬務資料，將於金融交易過程中，提供金融機構以完成金融交易相關業務；'),
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
                        child: Text(
                            '廣告行銷：為提供您更多優質商品及活動資訊，本公司會在您同意之前提下，分享相關訊息，如您後續不願接收相關訊息，均可隨時通知我們；'),
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
                        child: Text(
                            '市場分析：依據您瀏覽廣告之內容、消費之記錄及所提供之資料，本公司會進行市場分析，包含透過第三方使用cookie或類似技術，以開發及提供日後更優質之客戶服務；'),
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
                        child: Text(
                            '其他業務副隨事項：依據以上所述服務目的，及其他您在使用阿噗購物平臺其他服務，有同意之前提下，於必要範圍內進行相關運用'),
                      )
                    ],
                  ),
                  
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料利用期間、地區',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                   Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('除法令令有規定外，原則上我們僅會給予您授權的範圍，於本公司營業存續期間及服務所能到達地區內，依照前述服務目的範圍為作業之必要運用客戶資料。'),
                  ),
                  
                   Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料揭露對象及方式',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '1：我們僅會在本公司及我們所委任處理營業相關事務之第三人（例如：金融機構、合作廠商、物流商等服務提供者），依照前述服務目的的範圍為作業之必要運用或揭露客戶個人資料。除非另有法令規範，或另行取得您的同意，否則我們不會向前述以外之第三人揭露您的個人資料。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                        '2：我們提供資料予其他第三人的情形，除經過客戶本人同意，尚可能有以下情形：'),
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
                        child: Text(
                            '於特定目的的範圍作業利用之必要；'),
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
                        child: Text(
                            '合於個人資料保護法第20條但書規定為特定目的外之利用；'),
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
                        child: Text(
                            '基於法律之規定或受司法機關與其他有權基於法定程序之要求；'),
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
                        child: Text(
                            '在緊急情況下為維護其他會員或第三人之合法權益；'),
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
                        child: Text(
                            '為維護會員服務系統的正常運作；'),
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
                        child: Text(
                            '會員透過本服務購物、兌換贈品、參加抽獎活動等因而產生的金/物流之必要資訊。'),
                      )
                    ],
                  ),




                   Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料儲存及保管',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                 
                    Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('關於您提供的個人資料，我們將就資訊系統及公司作業規則制定嚴格規範，任何人均須在我們明定的授權規範下才嗯幹處理及利用必要之資料。我們針對資料安全設備投註之保護措施如下：'),
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
                        child: Text(
                            '我們采用最佳的科技來保障您的個人資料安全。目前以 Secure Sockets Layer(SSL) 機制(128bit)進行資料傳輸加密，並以加裝防火墻防止不法入侵，避免您的個人資料遭到非法存取；'),
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
                        child: Text(
                            '合於個人資料保護法第20條但書規定為特定目的外之利用；'),
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
                        child: Text(
                            '此外，為了提供更適合您需要的服務，我們會使用Cookie的技術，接收並且記錄您瀏覽器上的伺服器數值，包括IP Address、Cookies，以進行提供與產品更新及網路服務優化有關的工作時使用。'),
                      )
                    ],
                  ),
                  
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '客戶資料權力行使',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                 
                    Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('依個人資料保護法第3條規定，除非有其他法令限制，您就您所提供之個人資料享有查詢或請求閱覽、請求制給復制本、請求補充或更正、請求停止搜集處理或利用、請求刪除的權利。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('如果您欲行使上述權利或是有其他咨詢事項，可以至阿噗購物商城平臺【顧客中心】中完成相關操作，或由客服中心聯系客服提出意見，我們將盡快回復您的問題。'),
                  ),
                  
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '資料正確性之權益影響',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('在此提醒您，客戶如未提供完整的個人資料，可能無法成為我們的會員，或是享受各項相應的會員優惠服務或最新資訊。'),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text('如客戶提供之資料錯誤，亦不受此聲明之保護。'),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        '關於此份隱私權聲明，我們得隨時因應社會環境及法令規定的變更與科技的進步進行修改，並將修改內容以電子郵件、電話、通信網路、網路公告或其他適當方式通知客戶。',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
