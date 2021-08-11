import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bale_shop/utils/tool.dart';

class GoodsMouldOne extends StatefulWidget {
  GoodsMouldOne({Key key, this.data}) : super(key: key);
  final List data;
  @override
  _GoodsMouldOneState createState() => _GoodsMouldOneState();
}

class _GoodsMouldOneState extends State<GoodsMouldOne> {
  List data;
  int isId = 0;
  @override
  void initState() {
    data = widget.data;

    try {
      isId = data[0].id;
    } catch (e) {
      isId = data[0].productId;
    }
  }

  Widget renderTag(text) {
    List<Widget> tag = [];
    List data = text.split(',');
    for (var i = 0; i < data.length; i++) {
      tag.add(
        Container(
          margin: EdgeInsets.only(bottom: 8, top: 8, right: 6),
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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              color: Colors.white,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  'assets/icons/placeholder.png',
                  fit: BoxFit.cover,
                ),
                imageUrl: "http:" + data[0].productImageUrl,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/icons/placeholder.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 48,
                    child: Container(
                      margin: EdgeInsets.only(top: 8),
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
                            margin: EdgeInsets.only(bottom: 8, top: 8),
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
                      child: Text("出清價\$",
                          style: TextStyle(
                              color: Color(0xFFED1B2E), fontSize: 12)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("${doubleText(data[0].minPrice)}",
                          style: TextStyle(
                              color: Color(0xFFED1B2E), fontSize: 22)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 7, 0, 0),
                      child: Text(
                        "\$${doubleText(data[0].originalPrice)}",
                        style: TextStyle(
                            color: Color(0xFF777777),
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 88,
                      height: 26,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 3, top: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFED1B2E),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      child: Text(
                        '限時出清',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${numString(isId)}件已出",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
