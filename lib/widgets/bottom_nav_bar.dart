import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme.dart';


class BottomActionButton extends StatefulWidget {
  const BottomActionButton({Key? key}) : super(key: key);

  @override
  State<BottomActionButton> createState() => _BottomActionButtonState();

}

class _BottomActionButtonState extends State<BottomActionButton> {

  @override
  Widget build(BuildContext context) {

    /// General Screen Settings
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
    final bottomNavHeight = (screenHeight - safeAreaHeight) * 0.075;
    final height = screenHeight - safeAreaHeight - bottomNavHeight;

    return SizedBox(
      height: height * 0.1,
      width: height * 0.1,
      child: FloatingActionButton(
        backgroundColor: accent,
        elevation: 0,
        heroTag: 'add_button',
        highlightElevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              pageBuilder: (_, __, ___) => const LogTypeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const double begin = 0;
                const double end = 1;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return FadeTransition(
                  opacity: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Icon(
                Icons.add_rounded,
                color: specialWhite,
                size: constraints.maxHeight * 0.5,
              );
            },
          ),
        ),
      ),
    );
  }
}

// backup
// class BottomAppBarNav extends StatelessWidget {
//   const BottomAppBarNav({Key? key}) : super(key: key);
//
//   get bottomBarController => null;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final screenHeight = MediaQuery.of(context).size.height;
//     final safeAreaHeight = MediaQuery.of(context).padding.top +
//         MediaQuery.of(context).padding.bottom;
//     final height = screenHeight - safeAreaHeight;
//     final width = MediaQuery.of(context).size.width;
//
//     return BottomAppBar(
//       color: white,
//       shape: const CircularNotchedRectangle(),
//       elevation: 25,
//       notchMargin: 6,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(icon: Icon
//             (Icons.home_rounded, color: gray,),
//             iconSize: height * 0.04,
//             onPressed: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) {
//               //     return const DashboardScreen();
//               //   }),
//               // );
//             },
//           ),                    /// Home
//           IconButton(icon: Icon
//             (Icons.auto_stories_rounded, color: gray,),
//             iconSize: height * 0.04,
//             onPressed: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) {
//               //     return const InformationHubScreen();
//               //   }),
//               // );
//             },
//           ),                    /// Stats
//           SizedBox(
//             width: width * 0.25,
//             height: height * 0.075,
//           ),
//           IconButton(icon: Icon(Icons.history_rounded, color: gray,),
//             iconSize: height * 0.04,
//             onPressed: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) {
//               //     return const HistoryScreen();
//               //   }),
//               // );
//             },
//           ),                    /// History
//           IconButton(
//             icon: Icon(Icons.settings_rounded, color: gray,),
//             iconSize: height * 0.04,
//             onPressed: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) {
//               //     return const SettingsScreen();
//               //   }),
//               // );
//             },
//           ),                    /// Settings
//         ],
//       ),
//     );
//   }
// }
//
// class BottomActionButton extends StatefulWidget {
//   const BottomActionButton({Key? key}) : super(key: key);
//
//   @override
//   State<BottomActionButton> createState() => _BottomActionButtonState();
//
// }
//
// class _BottomActionButtonState extends State<BottomActionButton> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     /// General Screen Settings
//     final screenHeight = MediaQuery.of(context).size.height;
//     final safeAreaHeight = MediaQuery.of(context).padding.top +
//         MediaQuery.of(context).padding.bottom;
//     final bottomNavHeight = (screenHeight - safeAreaHeight) * 0.075;
//     final height = screenHeight - safeAreaHeight - bottomNavHeight;
//
//     return SizedBox(
//       height: height * 0.1,
//       width: height * 0.1,
//       child: FloatingActionButton(
//         backgroundColor: accent,
//         elevation: 0,
//         heroTag: 'add_button',
//         highlightElevation: 0,
//         onPressed: () {
//           Navigator.push(
//             context,
//             PageRouteBuilder(
//               opaque: false,
//               barrierDismissible: true,
//               pageBuilder: (_, __, ___) => const LogTypeScreen(),
//               transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                 const double begin = 0;
//                 const double end = 1;
//                 const curve = Curves.easeInOut;
//
//                 var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//                 return FadeTransition(
//                   opacity: animation.drive(tween),
//                   child: child,
//                 );
//               },
//             ),
//           );
//         },
//         child: Center(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return Icon(
//                 Icons.add_rounded,
//                 color: specialWhite,
//                 size: constraints.maxHeight * 0.5,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
