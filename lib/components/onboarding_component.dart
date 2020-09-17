import 'package:flutter/material.dart';
import 'package:pokemon_api_zip/components/styles/text_styles.dart';
import 'package:pokemon_api_zip/providers/onboardingStatusProvider.dart';

import 'dot_indicator.dart';

class OnboardingComponent extends StatefulWidget {
  final OnboardingStatus data;

  const OnboardingComponent({Key key, @required this.data}) : super(key: key);
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
    widget.data.isOnboarded((value) {
      if (value != null && value == true) {
        setState(() {
          shown = true;
        });
      }
    });
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
                        onPressed: () => handleNextPage(widget.data),
                        child: _whiteText(_nextText)),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FlatButton(
                        onPressed: () => setShown(widget.data),
                        child: _whiteText("Skip")),
                  )
                ],
              ),
            ),
          );
  }

  void setShown(OnboardingStatus data) {
    setState(() => shown = true);
    data.onboard();
  }

  void handleNextPage(OnboardingStatus data) {
    if (_nextText == "Begin") {
      setShown(data);
    }
    if (_controller.page == _pages.length - 1) {
      return null;
    }
    if (_controller.page == _pages.length - 2) {
      setState(() {
        _nextText = 'Begin';
      });
    }
    _controller.nextPage(duration: _kDuration, curve: _kCurve);
  }

  Text _whiteText(String value) =>
      Text(value, style: PokeStyles(context: context).whiteText);

  List<Widget> get _pages => <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/pokedeex.png"),
                Text("Thank you for downloading")
              ],
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/pokedeex.png"),
                Text(
                    "Look at all the pokemon, from 1st Gen up to Sword & Shield")
              ],
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/pokedeex.png"),
                Text(
                    "This will need a one time sign in, you name can only have letters, numbers, underscores and hyphens")
              ],
            ),
          ),
        )
      ];
}
