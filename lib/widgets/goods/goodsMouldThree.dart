import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
class GoodsMouldThree extends StatefulWidget {
  GoodsMouldThree({Key key, this.data}) : super(key: key);
  final List data;
  @override
  _GoodsMouldThreeState createState() => _GoodsMouldThreeState();
}

class _GoodsMouldThreeState extends State<GoodsMouldThree> {
   List data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  Widget renderTag(text) {
    List<Widget> tag = [];
    List data = text.split(',');
    for (var i = 0; i < data.length; i++) {
      tag.add(Container(
                      margin: EdgeInsets.only(bottom: 8, top: 8,right: 6),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCE9D5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        '${data[i]}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE56214),
                        ),
                      ),
                    ),);
    }
    return Row(
                  children: tag
                );
  }
   @override
  Widget build(BuildContext context) {
    return new Container(
      height: 140,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color:Color(0xF4F4F4)
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: CachedNetworkImage(
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset('assets/icons/placeholder.png',fit: BoxFit.cover,),
            imageUrl:"http:" + data[0].productImageUrl,
            errorWidget: (context, url, error) => Image.asset('assets/icons/placeholder.png',fit: BoxFit.cover,),
          ),
      
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
              color: Colors.white,
              child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: Text(
                    "${data[0].title}  ${data[0].description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
                data[0].flag!=null&&data[0].flag!=""?renderTag(data[0].flag):Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 8, top: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        '${data[0].flag}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFFE56214),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top:25),
                      child: Text(
                        '\$${data[0].minPrice}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top:25),
                        child: Text(
                          data[0]!=null?"${numString(data[0].id)}件已出":"",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                
             
              ],
            )
            )
          )
        ],
      ),
    );
  }
}





