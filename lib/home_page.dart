import 'package:flutter/material.dart';
import 'dart:math';
import 'login_page.dart';
import 'meal_plan_generator_page.dart';


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
            colors: [Color(0xFFF3E5F5), Color(0xFFFFFFFF)],
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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late final PageController _pageController;
  double _page = 0.0;
  int _hoveredIndex = -1;

  final List<Map<String, dynamic>> _tiles = [
    {
      'icon': Icons.fastfood,
      'title': 'Meal Plan',
      'gradient': [Color(0xFF6B46C1), Color(0xFFB794F4), Colors.white],
      'text': 'Plan your meals for today — quick & nutritious.',
    },
    {
      'icon': Icons.chat_bubble,
      'title': 'Chat Bot',
      'gradient': [Color(0xFF7E57C2), Color(0xFFD1C4E9), Colors.white],
      'text': 'Chat with your AI assistant for meal tips.',

    },
    {
      'icon': Icons.history,
      'title': 'History',
      'gradient': [Color(0xFF9575CD), Color(0xFFEDE7F6), Colors.white],
      'text': 'Check your previous plans and insights.',
    },
    {
      'icon': Icons.local_grocery_store,
      'title': 'Grocery',
      'gradient': [Color(0xFF8E24AA), Color(0xFFE1BEE7), Colors.white],
      'text': 'Organize your grocery list efficiently.',
    },

  ];





  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    _pageController.addListener(() {
      setState(() {
        _page = _pageController.page ?? 0.0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double cardAreaHeight = MediaQuery.of(context).size.height * 0.5;

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

          // Daily Tip Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

          const SizedBox(height: 30),

          // Redesigned Floating Gradient Cards
          SizedBox(
            height: cardAreaHeight,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemCount: _tiles.length,
              itemBuilder: (context, index) {
                final tile = _tiles[index];
                final double delta = index - _page;
                final double translateY = (delta * 30).clamp(-40.0, 40.0);
                final double scale = (1 - delta.abs() * 0.05).clamp(0.9, 1.0) *
                    (_hoveredIndex == index ? 1.05 : 1.0);

                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = -1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    transform: Matrix4.identity()
                      ..translate(0.0, translateY)
                      ..scale(scale),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: List<Color>.from(tile['gradient']),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${tile['title']} Clicked')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: Offset(0, -delta * 6),
                              child: Icon(tile['icon'], color: Colors.purple.shade900, size: 48),
                            ),
                            const SizedBox(height: 14),
                            Transform.translate(
                              offset: Offset(0, -delta * 3),
                              child: Text(
                                tile['title'],
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Opacity(
                              opacity: (1 - delta.abs() * 0.6).clamp(0.0, 1.0),
                              child: Text(
                                tile['text'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black54, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
