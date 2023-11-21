import 'package:flutter/material.dart';

class HomePageAndroidLayout extends StatefulWidget {
  const HomePageAndroidLayout({Key? key}) : super(key: key);

  @override
  _HomePageAndroidLayoutState createState() => _HomePageAndroidLayoutState();
}

class _HomePageAndroidLayoutState extends State<HomePageAndroidLayout> {
  int _selectedIndex = 0;
  bool showNotifications = false;

  showNotificationPanel() {
    setState(() {
      showNotifications = !showNotifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => print('Clicked YAL Brooo'),
      child: Scaffold(
        appBar: TopAppBar(
          toggleNotificationPanel: showNotificationPanel,
        ),
        body: HomePageContent(showNotificationPanel: showNotifications),
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
                _addNewAgentOrDevice(context);
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
    setState(() {
      _selectedIndex = index;
    });
  }
}

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function? toggleNotificationPanel;
  const TopAppBar({super.key, this.toggleNotificationPanel});

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
  const HomePageContent({Key? key, this.showNotificationPanel})
      : super(key: key);

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
        : SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        _notificationPanel()
      ],
    );
  }
}

Future _addNewAgentOrDevice(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black87.withOpacity(0.5),
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 350),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add new Agent'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add new Device'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
