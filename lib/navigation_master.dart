import 'package:Milestone/screens/log_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:Milestone/screens/dashboard_screen.dart';
import 'package:Milestone/screens/history_screen.dart';
import 'package:Milestone/screens/information_screen.dart';
import 'package:Milestone/screens/settings_screen.dart';

import 'theme.dart';

List<GlobalKey<NavigatorState>> globalNavigationKeys = [
	GlobalKey<NavigatorState>(),
	GlobalKey<NavigatorState>(),
	GlobalKey<NavigatorState>(),
	GlobalKey<NavigatorState>(),
];

class MasterNavigator extends StatefulWidget {
	const MasterNavigator({Key? key}) : super(key: key);

	@override
	MasterNavigatorState createState() => MasterNavigatorState();
}

class MasterNavigatorState extends State<MasterNavigator> {

	late Box generalData;
	int currentNavigatorIndex = 0;
	bool activeBottomNavigationBar = true;

	final List<int> mainNavigatorStack = [];

	dynamic toggleTheme(bool darkMode) {
		generalData.put('isDarkMode', darkMode);
		setTheme(darkMode);
		setState(() {});
	}

	dynamic changeAccent() {
		setTheme(generalData.get('isDarkMode'));
		setState(() {});
	}

	void pushMasterNavigator(int screenIndex) {
		if (mainNavigatorStack.contains(screenIndex)) {
	  mainNavigatorStack.remove(screenIndex);
	}
		mainNavigatorStack.add(screenIndex);
		currentNavigatorIndex = mainNavigatorStack.last;
	}

	bool popMasterNavigator() {
		if (mainNavigatorStack.length >= 2) {
	  mainNavigatorStack.removeLast();
	  setState(() {
		currentNavigatorIndex = mainNavigatorStack.last;
	  });
	  return false;
	}
		return true;
	}

	void setBottomNavigationBar(bool active) {
		setState(() {
			activeBottomNavigationBar = active;
		});
	}

	final List<Widget> navigatorList = [
		const HomeNavigator(),
	];

	@override
	void initState() {
		super.initState();
		generalData = Hive.box('GeneralData');
		navigatorList.add(InfoNavigator(setBottomNavigationBar: setBottomNavigationBar,),);
		navigatorList.add(const HistoryNavigator(),);
		navigatorList.add(SettingsNavigator(
			setBottomNavigationBar: setBottomNavigationBar,
			toggleTheme: toggleTheme,
			changeAccent: changeAccent)
		);
		pushMasterNavigator(0);
	}

	@override
	Widget build(BuildContext context) {

		return MaterialApp(
			home: WillPopScope(
				onWillPop: () async {
					final navigatorState = globalNavigationKeys[currentNavigatorIndex].currentState;
					if (navigatorState != null) {
						if (navigatorState.canPop()) {
							navigatorState.pop();
							return false;
						} else {
							return popMasterNavigator();
						}
					}
					return false;
				},
				child: Scaffold(
					backgroundColor: white,
					body: navigatorList[currentNavigatorIndex],
					bottomNavigationBar: activeBottomNavigationBar
					? BottomAppBar(
						color: white,
						elevation: 25,
						notchMargin: 6,
						shape: const CircularNotchedRectangle(),
						child: Row(
							mainAxisSize: MainAxisSize.max,
							mainAxisAlignment: MainAxisAlignment.spaceAround,
							children: <Widget>[
								IconButton(
									icon: Icon(Icons.home, color: gray,),
									onPressed: () {
										setState(() {
											pushMasterNavigator(0);
										});
									},
								),
								IconButton(
									icon: Icon(Icons.info, color: gray,),
									onPressed: () {
										setState(() {
											pushMasterNavigator(1);
										});
									},
								),
								const SizedBox(width: 80, height: 10,),
								IconButton(
									icon: Icon(Icons.history, color: gray,),
									onPressed: () {
										setState(() {
											pushMasterNavigator(2);
										});
									},
								),
								IconButton(
									icon: Icon(Icons.settings, color: gray,),
									onPressed: () {
										setState(() {
											pushMasterNavigator(3);
										});
									},
								),
							],
						),
					)
					: Container(height: 0,),
					floatingActionButton: activeBottomNavigationBar
					? const BottomActionButton()
					: Container(height: 0,),
					floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
				),
			),
		theme: ThemeData(
				useMaterial3: false,
			),
		);
	}
}



class HomeNavigator extends StatelessWidget {
	const HomeNavigator({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Navigator(
			key: globalNavigationKeys[0],
			initialRoute: '/',
			onGenerateRoute: (settings) {
				switch (settings.name) {
					case '/':
						return MaterialPageRoute(builder: (context) => const DashboardScreen());
					default:
						return MaterialPageRoute(builder: (context) => const UnknownPage());
				}
			},
		);
	}
}

class InfoNavigator extends StatelessWidget {

	final Function(bool) setBottomNavigationBar;

	const InfoNavigator({Key? key, required this.setBottomNavigationBar}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Navigator(
			key: globalNavigationKeys[1],
			initialRoute: '/',
			onGenerateRoute: (settings) {
				switch (settings.name) {
					case '/':
						return MaterialPageRoute(builder: (context) => InformationHubScreen(
							setBottomNavigationBar: setBottomNavigationBar,)
						);
					default:
						return MaterialPageRoute(builder: (context) => const UnknownPage());
				}
			},
		);
	}
}

class HistoryNavigator extends StatelessWidget {
	const HistoryNavigator({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Navigator(
			key: globalNavigationKeys[2],
			initialRoute: '/',
			onGenerateRoute: (settings) {
				switch (settings.name) {
					case '/':
						return MaterialPageRoute(builder: (context) => const HistoryScreen());
					default:
						return MaterialPageRoute(builder: (context) => const UnknownPage());
				}
			},
		);
	}
}

class SettingsNavigator extends StatelessWidget {

	final Function(bool) setBottomNavigationBar;
	final Function(bool) toggleTheme;
	final Function changeAccent;

	const SettingsNavigator({Key? key,
		required this.toggleTheme,
		required this.changeAccent,
		required this.setBottomNavigationBar
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Navigator(
			key: globalNavigationKeys[3],
			initialRoute: '/',
			onGenerateRoute: (settings) {
				switch (settings.name) {
					case '/':
						return MaterialPageRoute(builder: (context) => SettingsScreen(
							setBottomNavigationBar: setBottomNavigationBar,
							toggleTheme: toggleTheme,
							changeAccent: changeAccent),
						);
					default:
						return MaterialPageRoute(builder: (context) => const UnknownPage());
				}
			},
		);
	}
}

class UnknownPage extends StatelessWidget {
	const UnknownPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			alignment: Alignment.center,
			child: const Text("unknown page?!?"),
		);
	}
}

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
				shape: const CircleBorder(),
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
