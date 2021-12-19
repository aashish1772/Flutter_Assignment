import 'package:flutter/material.dart';
import 'package:habeato_assignment/item_widget.dart';
import 'constants.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedItemCount = 0;

  List<Tab> tabs = categories.map((String category) {
    return Tab(
      child: Text(
        category,
      ),
    );
  }).toList();

  Map<String, int> categoryCount = {
    'Popular': 3,
    'Milk Based': 3,
    'Parathas & Stuffed Rolls': 3,
    'Cheelas': 3,
    'Porridges, Vermicelli & Poha': 3,
  };

  Map<String, Color> categoryColor = const {
    'Popular': Color(0xFFA2D2FF),
    'Milk Based': Color(0xFFFFC8DD),
    'Parathas & Stuffed Rolls': Color(0xFFFF9B85),
    'Cheelas': Color(0xFFFFBF81),
    'Porridges, Vermicelli & Poha': Color(0xFFBCF4DE),
  };

  Map<String, List<Map<String, String>>?> itemsMap = {
    "Popular": [
      {'name': 'Besan Veggie Cheela', 'isSelected': 'false'},
      {'name': 'Multigrain Veggie Paneer Sandwich', 'isSelected': 'false'},
      {'name': 'Rice Idli', 'isSelected': 'false'},
      {'name': 'Veggie Poha', 'isSelected': 'false'},
      {'name': 'Veggie Suji Upma', 'isSelected': 'false'},
    ],
    "Milk Based": [
      {'name': 'Banana Shake', 'isSelected': 'false'},
      {'name': 'Butter Milk (Unsalted)', 'isSelected': 'false'},
      {'name': 'Cold coffee made with skimmed milk', 'isSelected': 'false'},
      {'name': 'Cornflakes With Milk', 'isSelected': 'false'},
      {'name': 'Milk', 'isSelected': 'false'},
    ],
    "Porridges, Vermicelli & Poha": [
      {'name': 'Masala Veggie Rolled Oats', 'isSelected': 'false'},
      {'name': 'Masala Veggie Rolled Oats', 'isSelected': 'false'},
      {'name': 'Oats with Milk and Apple', 'isSelected': 'false'},
      {'name': 'Veggie Dalia Khichadi', 'isSelected': 'false'},
      {'name': 'Veggie Vermicelli', 'isSelected': 'false'},
    ],
    "Cheelas": [
      {'name': 'Suji Veggie Cheela', 'isSelected': 'false'},
      {'name': 'Oats Veggie Cheela', 'isSelected': 'false'},
      {'name': 'Oats and Green Moong Cheela', 'isSelected': 'false'},
      {'name': 'Moong Dal Veggie Cheela', 'isSelected': 'false'},
      {'name': 'Besan Cheela with Stuffed Paneer', 'isSelected': 'false'},
    ],
    "Parathas & Stuffed Rolls": [
      {'name': 'Plain Paratha', 'isSelected': 'false'},
      {'name': 'Paneer Stuffed Roti', 'isSelected': 'false'},
      {'name': 'Mix Veg Paratha', 'isSelected': 'false'},
      {'name': 'Dal Paratha', 'isSelected': 'false'},
      {'name': 'Dal Ki Roti', 'isSelected': 'false'},
    ]
  };

  void itemSelected(String category, int index) {
    if (itemsMap[category]![index]['isSelected'] == 'true') {
      setState(() {
        itemsMap[category]![index]['isSelected'] = 'false';
        _selectedItemCount -= 1;
      });
    } else if ((itemsMap[category]![index]['isSelected'] == 'false')) {
      setState(() {
        itemsMap[category]![index]['isSelected'] = 'true';
        _selectedItemCount += 1;
      });
    }
  }

  void updateCategoryCount(String category) {
    int count = categoryCount[category] ?? 0;
    int len = itemsMap[category]?.length ?? 0;
    count += 2;
    if (count <= len) {
      setState(() {
        categoryCount[category] = count;
      });
    }
  }

  Widget allView() {
    List<Widget> elements = [];
    int overallIndex = -1;
    for (int i = 1; i < categories.length; i++) {
      int len = categoryCount[categories[i]] ?? 0;
      for (int index = 0; index < len; index++) {
        overallIndex += 1;
        List<String> imageName = [
          'assets',
          categories[i],
          itemsMap[categories[i]]![index]['name']!,
        ];
        elements.add(
          AnimationConfiguration.staggeredGrid(
            position: overallIndex,
            duration: const Duration(seconds: 1),
            columnCount: 2,
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () => itemSelected(categories[i], index),
                child: ItemWidget(
                  selected:
                      itemsMap[categories[i]]![index]['isSelected'] == 'true',
                  imageName: imageName,
                ),
              ),
            ),
          ),
        );
      }
      overallIndex += 1;
      elements.add(
        AnimationConfiguration.staggeredGrid(
          position: overallIndex,
          duration: const Duration(milliseconds: 375),
          columnCount: 2,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () => updateCategoryCount(categories[i]),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: categoryColor[categories[i]],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'More ' + categories[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: elements,
      ),
    );
  }

  List<Widget> tabViewHelper() {
    List<Widget> views = [];
    for (int i = 1; i < categories.length; i++) {
      views.add(
        AnimationLimiter(
          child: GridView.count(
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: List.generate(itemsMap[categories[i]]!.length, (index) {
              List<String> imageName = [
                'assets',
                categories[i],
                itemsMap[categories[i]]![index]['name']!,
              ];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(seconds: 1),
                columnCount: 2,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () => itemSelected(categories[i], index),
                    child: ItemWidget(
                        selected: itemsMap[categories[i]]![index]
                                ['isSelected'] ==
                            'true',
                        imageName: imageName),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }
    return views;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _selectedItemCount >= 3
              ? FloatingActionButton.extended(
                  label: const Text(
                    'Next',
                    style: TextStyle(fontSize: 25),
                  ),
                  extendedPadding: const EdgeInsets.all(30.0),
                  backgroundColor: kTextColor,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                )
              : const IgnorePointer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: ColoredBox(
              color: kTabBarColor,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  isScrollable: true,
                  labelColor: kTextColor,
                  unselectedLabelColor: Colors.black,
                  controller: _tabController,
                  tabs: tabs,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: kTextColor,
                        size: 30,
                      )),
                  const Text(
                    'Breakfast',
                    style: TextStyle(fontSize: 28, color: kTextColor),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: kTextColor,
                        size: 30,
                      )),
                ],
              ),
              const Text(
                'Select 3 or more items',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          allView(),
          ...tabViewHelper(),
        ]),
      ),
    );
  }
}
