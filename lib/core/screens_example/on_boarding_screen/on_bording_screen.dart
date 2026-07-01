import 'package:flutter/material.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/core/widgets/default_screen_padding.dart';
import 'package:maintly_app/core/widgets/sizer.dart';
import 'package:maintly_app/utils/assets/assets.dart';
import 'package:maintly_app/utils/styles/styles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> _pages = const [
    _OnboardingItem(
      image: AssetsData.onBoarding_1,
      title: 'Welcome to Maintly',
      description:
          'View all of your assigned work orders from anywhere and stay synchronized with your maintenance team.',
    ),
    _OnboardingItem(
      image: AssetsData.onBoarding_2,
      title: 'Complete Work Efficiently',
      description:
          'Record labor, spare parts, notes and photos while updating work order progress in real time.',
    ),
    _OnboardingItem(
      image: AssetsData.onBoarding_3,
      title: 'Everything in One Place',
      description:
          'Access assets, locations and maintenance history on-site to complete every job with confidence.',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: Navigate to Sign In screen.
    }
  }

  void _skip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultScreenPadding(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _currentPage == _pages.length - 1 ? null : _skip,
                  child: txt('Skip', c: context.primaryColor),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (value) {
                    setState(() => _currentPage = value);
                  },
                  itemBuilder: (_, index) => _OnboardingPage(item: _pages[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (index) {
                  final active = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: active ? 28 : 8,
                    decoration: BoxDecoration(
                      color: active ? context.primaryColor : Colors.grey.withOpacity(.35),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
              const Sizer(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: txt(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    c: Colors.white,
                  ),
                ),
              ),
              const Sizer(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.item});

  final _OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 280, child: Image.asset(item.image, fit: BoxFit.contain)),
        const Sizer(height: 40),
        txt(item.title, e: St.bold25, textAlign: TextAlign.center),
        const Sizer(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: txt(
            item.description,
            e: St.reg16,
            c: Colors.grey,
            textAlign: TextAlign.center,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _OnboardingItem {
  final String image;
  final String title;
  final String description;

  const _OnboardingItem({required this.image, required this.title, required this.description});
}
