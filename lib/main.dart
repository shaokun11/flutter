import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/AccountPage.dart';
import 'package:flutter_app1/HomePage.dart';
import 'package:flutter_app1/provider/Words.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'provider/Counter.dart';

void main() {
  final counter = Counter();
  final words = new Words();
  final textSize = 48;
  runApp(MultiProvider(
      providers: [
        Provider<int>.value(value: textSize),
        ChangeNotifierProvider.value(value: counter),
        ChangeNotifierProvider.value(value: words),
      ],
      child: MaterialApp(
        color: Colors.red,
        theme: ThemeData(
          accentColor: Colors.green,
          primaryColor: Colors.green,
        ),
        home: MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List _pageList = [HomePage(), AccountPage()];

  _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() => {_currentIndex = index});
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: ScreenUtil.instance.setSp(60),
        currentIndex: _currentIndex,
        onTap: (index) => {this._pageChange(index)},
        items: [
          BottomNavigationBarItem(
            title: Text("home"),
            icon: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
          ),
          BottomNavigationBarItem(
            title: Text("account"),
            icon: Icon(
              Icons.account_box,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        primary: true,
        toolbarOpacity: .6,
        title: Text('SHAOKUN'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: PageView.builder(
        onPageChanged: (index) => {_pageChange(index)},
        itemCount: _pageList.length,
        itemBuilder: (context, index) => _pageList[_currentIndex],
      ),
    );
  }
}
