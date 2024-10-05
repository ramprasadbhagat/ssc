
part of '../customer_home_page.dart';


class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final List<String> imagePaths = [
    ImagePath.banner1,
    ImagePath.banner2,
    ImagePath.banner3,
    ImagePath.banner4,
    ImagePath.banner5,
  ];

  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_pageController.page == imagePaths.length - 1) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: 0.28.mh,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            allowImplicitScrolling: true,
            physics: PageScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.0),
        SmoothPageIndicator(
          controller: _pageController,
          count: imagePaths.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8.0,
            dotWidth: 8.0,
            activeDotColor: Colors.blue,
            dotColor: Colors.grey,
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }
}
