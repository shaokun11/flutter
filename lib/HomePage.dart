import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/provider/Counter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'SecondPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<Counter>(
        builder: (context, counter, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: counter.updateCount,
              child: Icon(Icons.add),
            ),
            body: Consumer<int>(
              builder: (context, size, _) => Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setWidth(136)),
                    child: Center(
                      child: Image.asset(
                        "images/icon_title.png",
                        height: ScreenUtil.getInstance().setWidth(50),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(98)),
                    child: Center(
                      child: Text("set account name",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(34))),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(100),
                              right: ScreenUtil.getInstance().setWidth(100)),
                          child: TextField(
                              onChanged: (text) => {print('change $text')},
                              decoration: InputDecoration(
                                hintText: "hello world",
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                              ))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(300)),
                    child: Center(
                      child: RaisedButton(
                        color: Colors.red,
                        padding: EdgeInsets.only(
                          left: ScreenUtil.instance.setWidth(100),
                          right: ScreenUtil.instance.setWidth(100),
                          top: ScreenUtil.instance.setHeight(25),
                          bottom: ScreenUtil.instance.setHeight(25),
                        ),
                        shape: StadiumBorder(),
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SecondPage()))
                        },
                        child: Text(
                          "start",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil.instance.setSp(50)),
                        ),
                      ),
                    ),
                  ),
                  Consumer2<Counter, int>(
                    builder: (context, counter, textSize, _) => Center(
                      child: Text(
                        'Value: ${counter.count}',
                        style: TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
