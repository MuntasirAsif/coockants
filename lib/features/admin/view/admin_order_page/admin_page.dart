import 'package:cookants/features/admin/view/all_product/all_product.dart';
import 'package:flutter/material.dart';

import 'Widgets/admin_order_page body.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with SingleTickerProviderStateMixin {
  late double deviceWidth;
  late double deviceHeight;
  late TabController _tabController;

  int selectedIndex = 0; // To track which content is displayed

  List<Widget> drawer = [
    AdminOrderPageBody(),
    AllProduct(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController for desktop view
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      drawer: deviceWidth <= 750
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: Text('Admin'),
                accountEmail: Text('admin@domain.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.admin_panel_settings, color: Colors.blue),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Orders'),
              onTap: () {
                setState(() {
                  selectedIndex = 0; // Update the selected index
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Products'),
              onTap: () {
                setState(() {
                  selectedIndex = 1; // Update the selected index
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      )
          : null, // Only show drawer on mobile view
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 750) {
            // Desktop View: Use TabBar
            return desktopView();
          } else {
            // Mobile View: Use Drawer
            return mobileView();
          }
        },
      ),
    );
  }

  Widget desktopView() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Orders'),
              Tab(text: 'Products'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AdminOrderPageBody(), // Tab 1 content (Orders)
                AllProduct(), // Tab 2 content (Products)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mobileView() {
    return Scaffold(
      body: drawer[selectedIndex], // Main content for mobile view (Orders or Products)
    );
  }
}
