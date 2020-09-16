import 'package:flutter/material.dart';

import 'dot_indicator.dart';

class OnboardingComponent extends StatefulWidget {
  @override
  State createState() => new OnboardingComponentState();
}

class OnboardingComponentState extends State<OnboardingComponent> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  bool shown = false;

  String _nextText = "next";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return shown
        ? Container()
        : Scaffold(
            body: new IconTheme(
              data: new IconThemeData(color: _kArrowColor),
              child: Stack(
                children: <Widget>[
                  new PageView.builder(
                    physics: new AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages[index % _pages.length];
                    },
                  ),
                  new Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      color: Colors.grey[800].withOpacity(0.5),
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: DotsIndicator(
                          controller: _controller,
                          itemCount: _pages.length,
                          onPageSelected: (int page) {
                            _controller.animateToPage(
                              page,
                              duration: _kDuration,
                              curve: _kCurve,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FlatButton(
                      onPressed: () => handleNextPage(),
                      child: Text(_nextText),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FlatButton(
                        onPressed: () {
                          setState(() {
                            shown = true;
                          });
                        },
                        child: Text("Skip")),
                  )
                ],
              ),
            ),
          );
  }

  void handleNextPage() {
    if (_controller.page == _pages.length - 1) {
      setState(() {
        _nextText = 'Begin';
      });
      return null;
    }
    if (_controller.page == _pages.length - 2) {
      setState(() {
        _nextText = 'Begin';
      });
    }
    _controller.nextPage(duration: _kDuration, curve: _kCurve);
  }

  List<Widget> get _pages => <Widget>[
        new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new FlutterLogo(textColor: Colors.blue),
        ),
        new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new FlutterLogo(
              style: FlutterLogoStyle.stacked, textColor: Colors.red),
        ),
        new ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: new FlutterLogo(
              style: FlutterLogoStyle.horizontal, textColor: Colors.green),
        ),
      ];
}