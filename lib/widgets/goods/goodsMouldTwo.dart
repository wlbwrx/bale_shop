import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';
class GoodsMouldTwo extends StatefulWidget {
  GoodsMouldTwo({Key key, this.data}) : super(key: key);
  final List data;
  @override
  _GoodsMouldTwoState createState() => _GoodsMouldTwoState();
}

class _GoodsMouldTwoState extends State<GoodsMouldTwo> {
  List data;
  @override
  void initState() {
    data = widget.data;
  }

  Widget renderTag(text) {
    List<Widget> tag = [];
    List data = text.split(',');
    for (var i = 0; i < data.length; i++) {
      tag.add(
        Container(
          margin: EdgeInsets.only(bottom: 6, top: 6, right: 6),
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
        ),
      );
    }
    return Row(children: tag);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.white),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                'assets/icons/placeholder.png',
                fit: BoxFit.cover,
              ),
              imageUrl: "http:" + data[0].productSkuImg,
              errorWidget: (context, url, error) => Image.asset(
                'assets/icons/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 48,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${data[0].title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF222222),
                        ),
                      ),
                    )),
                data[0].flag != null && data[0].flag != ""
                    ? renderTag(data[0].flag)
                    : Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 6, top: 6),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
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
                      margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                      child: Text("\$",
                          style: TextStyle(
                              color: Color(0xFFED1B2E), fontSize: 12)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("${doubleText(data[0].minPrice)}",
                          style: TextStyle(
                              color: Color(0xFFED1B2E), fontSize: 22)),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${numString(data[0].id)}件已出",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
