import 'package:flutter/material.dart';
import '../theme.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            height: safeAreaHeight,
            color: accent,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                          color: accent,
                        ),
                      ), /// Background Color
              ],
            ),
          )
        ],
      ),
      // bottomNavigationBar: const BottomAppBarNav(),
      // floatingActionButton: const BottomActionButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
