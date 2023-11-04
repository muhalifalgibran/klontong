import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:klontong/features/add_product/presentation/page/input_product_page.dart';
import 'package:klontong/features/add_product/presentation/providers/input_product_provider.dart';
import 'package:klontong/features/browse/presentation/page/browse_page.dart';
import 'package:klontong/features/home/presentation/pages/home_page.dart';
import 'package:klontong/features/home/presentation/providers/home_provider.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// Controller to handle bottom nav bar and also handles initial page
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);

  int _indexPage = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  /// widget list
  final List<Widget> bottomBarPages = const [
    HomePage(),
    InputProductPage(),
    BrowsePage(),
  ];

  int maxCount = 4;
  @override
  Widget build(BuildContext context) {
    // since our widget tree is not that really deep
    // so, it is okay to place the providers at the root of our widget tree
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<InputProductProvider>(
          create: (context) => InputProductProvider(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          // index: _indexPage,
          children: bottomBarPages,
        ),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
            ? AnimatedNotchBottomBar(
                /// Provide NotchBottomBarController
                notchBottomBarController: _controller,
                color: Colors.white,
                showLabel: false,
                notchColor: Colors.black54,

                /// restart app if you change removeMargins
                removeMargins: false,
                bottomBarWidth: 500,
                durationInMilliSeconds: 300,
                bottomBarItems: const [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.home_filled,
                      color: Colors.blueGrey,
                    ),
                    activeItem: Icon(
                      Icons.home_filled,
                      color: Colors.white,
                    ),
                    itemLabel: 'Page 1',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.post_add,
                      color: Colors.blueGrey,
                    ),
                    activeItem: Icon(
                      Icons.post_add,
                      color: Colors.white,
                    ),
                    itemLabel: 'Page 2',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Icons.search,
                      color: Colors.blueGrey,
                    ),
                    activeItem: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    itemLabel: 'Page 3',
                  ),
                ],
                onTap: (index) {
                  /// perform action on tab change and to update pages you can update pages without pages
                  _pageController.jumpToPage(index);
                  // setState(() {
                  //   _indexPage = index;
                  // });
                },
              )
            : const SizedBox(
                child: Center(
                  child: Text('Null'),
                ),
              ),
      ),
    );
  }
}
