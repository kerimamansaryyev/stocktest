import 'package:flutter/cupertino.dart';
import 'package:stocktest/src/localization/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(context.translation.homeTitle),
      ),
      child: const SizedBox(),
    );
  }
}
