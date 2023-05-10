import 'dart:convert';
// import 'dart:ffi';

// import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:audio_ebook_player/homepage/my_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:audio_ebook_player/homepage/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late List popbooks;
  late List bk;
  late ScrollController _ScrollController;
  late TabController _tabController;
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/popbooks.json")
        .then((s) {
      setState(() {
        popbooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString("assets/json/bk.json")
        .then((s) {
      setState(() {
        bk = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _ScrollController = ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    CupertinoIcons.circle_grid_3x3_fill,
                    size: 35,
                  ).objectTopLeft(),
                  Row(
                    children: [
                      Icon(Icons.search).iconSize(40),
                      SizedBox(width: 10),
                      Icon(Icons.notifications).iconSize(40)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Eurol Books",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 180,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: -100,
                    right: 0,
                    child: Container(
                      height: 180,
                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.6),
                          itemCount: popbooks == null ? 0 : popbooks.length,
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(popbooks[i]["img"]),
                                      fit: BoxFit.fill)),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: NestedScrollView(
              controller: _ScrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: AppColors.silverBackground,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(40.0),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20, left: 10),
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(0),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: const EdgeInsets.only(right: 10),
                          controller: _tabController,
                          isScrollable: true,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 5,
                                    offset: Offset(0, 0))
                              ]),
                          tabs: [
                            AppTabs(color: AppColors.menu1Color, text: "New"),
                            AppTabs(color: AppColors.menu2Color, text: "Hits"),
                            AppTabs(
                                color: AppColors.menu3Color, text: "Popular")
                          ],
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(controller: _tabController, children: [
                ListView.builder(
                  itemCount: bk == null ? 0 : bk.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.tabVaarViewColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(bk[i]["img"]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 24,
                                        color: AppColors.starColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        bk[i]["rating"],
                                        style: TextStyle(
                                            color: AppColors.menu1Color,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Text(
                                    bk[i]["title"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    bk[i]["text"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        color: AppColors.subTitleText),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.loveColor),
                                    child: Text(
                                      "Love",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Avenir",
                                          color: Colors.white),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: bk == null ? 0 : bk.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.tabVaarViewColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(bk[i]["img"]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 24,
                                        color: AppColors.starColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        bk[i]["rating"],
                                        style: TextStyle(
                                            color: AppColors.menu1Color,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Text(
                                    bk[i]["title"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    bk[i]["text"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        color: AppColors.subTitleText),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.loveColor),
                                    child: Text(
                                      "Love",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Avenir",
                                          color: Colors.white),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: bk == null ? 0 : bk.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.tabVaarViewColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 0),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(bk[i]["img"]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 24,
                                        color: AppColors.starColor,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        bk[i]["rating"],
                                        style: TextStyle(
                                            color: AppColors.menu1Color,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Text(
                                    bk[i]["title"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    bk[i]["text"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Avenir",
                                        color: AppColors.subTitleText),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.loveColor),
                                    child: Text(
                                      "Love",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Avenir",
                                          color: Colors.white),
                                    ),
                                    alignment: Alignment.center,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
            ))
          ],
        ),
      )),
    );
  }
}
