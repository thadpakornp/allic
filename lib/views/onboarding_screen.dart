import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/views/login_screen.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List dataOnboard = [
      {
        "image":
            'assets/images/1906.i203.016.allergy_symptoms-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle1,
        "description": Languages.of(context)!.onBoardDescription1,
      },
      {
        "image": 'assets/images/17439389-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle2,
        "description": Languages.of(context)!.onBoardDescription2,
      },
      {
        "image": 'assets/images/handdrawn_vector_61-removebg-preview.png',
        "title": Languages.of(context)!.onBoardTitle3,
        "description": Languages.of(context)!.onBoardDescription3,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: dataOnboard.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardContent(
                      image: dataOnboard[index]['image'],
                      title: dataOnboard[index]['title'],
                      description: dataOnboard[index]['description'],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    dataOnboard.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        right: 4.0,
                      ),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  const Spacer(),
                  _pageIndex == 2
                      ? SizedBox(
                          height: 60,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const LoginScreen()),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 60,
                          width: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: isActive ? 12 : 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
          )
        ),
        const Spacer(),
      ],
    );
  }
}
