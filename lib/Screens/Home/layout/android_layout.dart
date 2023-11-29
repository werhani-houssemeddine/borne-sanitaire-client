import 'package:borne_sanitaire_client/Screens/Home/Widget/add_agent.dart';
import 'package:borne_sanitaire_client/Screens/Home/Widget/profile.dart';
import 'package:borne_sanitaire_client/Screens/Home/Screen/agents.dart';
import 'package:borne_sanitaire_client/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class HomePageAndroidLayout extends StatefulWidget {
  Widget widgetContent;
  HomePageAndroidLayout({Key? key, required this.widgetContent})
      : super(key: key);

  @override
  _HomePageAndroidLayoutState createState() => _HomePageAndroidLayoutState();
}

class _HomePageAndroidLayoutState extends State<HomePageAndroidLayout> {
  int _selectedIndex = 0;
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
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.purpleAccent.shade700,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Agents',
              ),
              BottomNavigationBarItem(
                icon: Container(),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.devices),
                label: 'Devices',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: MediaQuery.of(context).size.width / 2 - 30.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () {
                AddAgentBuilder(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      if (_selectedIndex == 4) displayProfileBottomSheet(context);

      const Map<int, PageRouteInfo<void>> listOfWidget = {
        0: DashboardRoute(),
        1: AgentsRoute(),
        3: DevicesRoute(),
      };

      if (listOfWidget[_selectedIndex] != null) {
        AutoRouter.of(context).push(
          listOfWidget[_selectedIndex] ?? const DashboardRoute(),
        );
      }
    }
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

/*
class _HomePageAndroidLayoutState extends State<HomePageAndroidLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scaffold(
        bottomNavigationBar: const BottomAppBar(),
        body: Container(
          child: const SearchScreen(),
        ),
      ),
    );
  }
}
*/