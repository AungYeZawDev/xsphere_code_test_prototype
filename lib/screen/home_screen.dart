import 'package:flutter/material.dart';
import 'package:xsphere_code_test_prototype/constants/custom_constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  CustomConstants custom = CustomConstants();
  List<String> categoryList = [
    'Full Time',
    'Part Time',
    'Only Yangon',
    'Whole Country'
  ];
  List<ForYouModel> forYouList = [
    ForYouModel(
        image: 'Flutter',
        title: 'Flutter Developer',
        posts: '3 Posts',
        category: 'category',
        time: '4 days ago'),
    ForYouModel(
        image: 'Laravel',
        title: 'Laravel Developer',
        posts: '3 Posts',
        category: 'category',
        time: '4 days ago'),
    ForYouModel(
        image: 'NodeJS',
        title: 'NodeJS Developer',
        posts: '3 Posts',
        category: 'category',
        time: '4 days ago'),
    ForYouModel(
        image: 'React',
        title: 'React Developer',
        posts: '3 Posts',
        category: 'category',
        time: '4 days ago'),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF512f7f),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 190.0,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 2.0,
            title: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16, right: 17),
              child: Text(
                custom.title,
                style: custom.textStyle(
                    color: Colors.white,
                    isDarkMode: false,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildCategory(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'For You',
                style: custom.textStyle(
                    color: Colors.white,
                    isDarkMode: false,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _buildForYou(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Recent',
                  style: custom.textStyle(
                      color: Colors.white,
                      isDarkMode: false,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
        )
      ]),
    );
  }

  Widget _buildCategory() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  MdiIcons.filter,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.36,
              height: 65,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: ((context, index) => SizedBox(
                        width: 130,
                        height: 80,
                        child: Card(
                          color: const Color(0xff5f3d8b),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              categoryList[index],
                              style: custom.textStyle(
                                  color: Colors.white,
                                  isDarkMode: false,
                                  fontSize: 12),
                            ),
                          )),
                        ),
                      ))),
            ),
          )
        ],
      );

  Widget _buildForYou() => Container(
      padding: const EdgeInsets.all(18.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forYouList.length,
          itemBuilder: ((context, index) => SizedBox(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 5,
              child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/${forYouList[index].image}.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(forYouList[index].title),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              forYouList[index].posts,
                              style: custom.textStyle(
                                  color: const Color(0xFF607d8b),
                                  isDarkMode: false,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                // color: const Color(0xFFdcd5e5),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Chip(
                                  label: Text(
                                    forYouList[index].category,
                                    style: custom.textStyle(
                                        color: const Color(0xFF512f7f),
                                        isDarkMode: false,
                                        fontSize: 12),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              forYouList[index].time,
                              style: custom.textStyle(
                                  color: Colors.blueGrey,
                                  isDarkMode: false,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))))));

  
}

class ForYouModel {
  final String image;
  final String title;
  final String posts;
  final String category;
  final String time;

  ForYouModel(
      {required this.image,
      required this.title,
      required this.posts,
      required this.category,
      required this.time});
}
