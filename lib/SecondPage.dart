import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  List tabs = ["red", "green", "yellow"];
  TabController _tabController;
  int currentIndex = 0;
  List tabColors = [Colors.red, Colors.green, Color.fromARGB(227, 207, 87, 1)];

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(initialIndex: 0, length: tabs.length, vsync: this);
    _tabController.addListener(() => {
          this.setState(() => {currentIndex = _tabController.index})
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tabColors[currentIndex],
        title: Text("shaokun2"),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs
              .map((title) => Tab(
                    text: title,
                  ))
              .toList(),
        ),
      ),

      body: TabBarView(controller: _tabController, children: [
        Container(
          child: Text("$currentIndex"),
          decoration: BoxDecoration(color: tabColors[0]),
        ),
        Container(
          child: Text("$currentIndex"),
          decoration: BoxDecoration(color: tabColors[1]),
        ),
        Container(
          child: Text("$currentIndex"),
          decoration: BoxDecoration(color: tabColors[2]),
        )
      ]),
    );
  }
}
