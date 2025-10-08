import 'package:flutter/material.dart';
import 'login_page.dart';
import 'generate_meal_plan_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Center(child: Text('🍱 Meal Planner', style: TextStyle(fontSize: 22))),
    const Center(child: Text('🤖 Chat Bot', style: TextStyle(fontSize: 22))),
    const Center(child: Text('📜 History', style: TextStyle(fontSize: 22))),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Left drawer (menu)
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.purple, size: 40),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Hey, Kanisha!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.purple),
              title: const Text('Grocery Preview'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.purple),
              title: const Text('Favourites'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.purple),
              title: const Text('Settings'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text(
          'My Planner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.purple),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.purple),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile Clicked')),
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE7F6), Color(0xFFF3E5F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _pages[_selectedIndex],
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Meal'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
    );
  }
}

// 🩷 Home Page Content Section
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Welcome Back 👋',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 8),
          const Text(
            'Let’s plan your day smartly!',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // Fancy cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard(Icons.fastfood, 'Meal Plan', Colors.purpleAccent),
              _buildCard(Icons.chat_bubble, 'Chat Bot', Colors.deepPurpleAccent),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCard(Icons.history, 'History', Colors.purple),
              _buildCard(Icons.local_grocery_store, 'Grocery', Colors.deepPurple),
            ],
          ),
          const SizedBox(height: 30),

          // Tips section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('🌸 Daily Tip',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontSize: 18)),
                SizedBox(height: 8),
                Text('Drink plenty of water and stay consistent with your plan! 💪',
                    style: TextStyle(fontSize: 15, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable card widget
  static Widget _buildCard(IconData icon, String title, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    color: color, fontWeight: FontWeight.w600, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}