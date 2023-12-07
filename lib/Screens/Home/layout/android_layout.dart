import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class HomePageAndroidLayout extends StatefulWidget {
  final Widget widgetContent;
  const HomePageAndroidLayout({Key? key, required this.widgetContent})
      : super(key: key);

  @override
  _HomePageAndroidLayoutState createState() => _HomePageAndroidLayoutState();
}

class _HomePageAndroidLayoutState extends State<HomePageAndroidLayout> {
  bool showNotifications = false;
  Widget? currentPage;

  showNotificationPanel() {
    setState(() {
      showNotifications = !showNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: CustomTopAppBar(
          toggleNotificationPanel: showNotificationPanel,
        ),
        body: HomePageContent(
          showNotificationPanel: showNotifications,
          showCurrentPage: widget.widgetContent,
        ),
        bottomNavigationBar: const HomeBottomNavigationBar(),
      ),
    );
  }
}

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? toggleNotificationPanel;
  const CustomTopAppBar({super.key, this.toggleNotificationPanel});

  Container _makeIconContainer(IconData icon, onPressed) {
    double size = 36;
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black38,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(size / 4),
        color: Colors.white,
      ),
      child: GestureDetector(
        child: InkWell(
          onTap: onPressed,
          child: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _makeIconContainer(Icons.nightlight_round_outlined, () {}),
          _makeIconContainer(Icons.light_mode_outlined, () {}),
          _makeIconContainer(Icons.message_outlined, () {}),
          _makeIconContainer(
            Icons.notifications_none_outlined,
            toggleNotificationPanel,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}

class HomePageContent extends StatelessWidget {
  final bool? showNotificationPanel;
  final Widget? showCurrentPage;
  const HomePageContent({
    Key? key,
    this.showNotificationPanel,
    required this.showCurrentPage,
  }) : super(key: key);

  Widget _notificationPanel() {
    return showNotificationPanel == true
        ? Positioned(
            top: 0,
            right: 10,
            child: PhysicalModel(
              elevation: 8.0,
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 180,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        // showCurrentPage,
        if (showCurrentPage != null) showCurrentPage as Widget,

        _notificationPanel()
      ],
    );
  }
}

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _HomeBottomNavigationBarState createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _selectedIndex = 0;

  void Function(int) _onItemTapped(BuildContext context) {
    return (int index) {
      if (index == 2) {
        AddAgentBuilder(context);
        return;
      }
      if (index != _selectedIndex) {
        setState(() => _selectedIndex = index);

        const Map<int, PageRouteInfo<void>> listOfWidget = {
          0: DashboardRoute(),
          1: AgentsRoute(),
          3: DevicesRoute(),
          4: ProfileRoute(),
        };

        if (listOfWidget[_selectedIndex] != null) {
          AutoRouter.of(context).push(
            listOfWidget[_selectedIndex] ?? const DashboardRoute(),
          );
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue.shade50,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedIndex,
            iconSize: 25,
            onTap: _onItemTapped(context),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color.fromRGBO(1, 65, 189, 1),
            unselectedItemColor: Colors.blue.shade300,
            mouseCursor: SystemMouseCursors.click,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.devices),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
