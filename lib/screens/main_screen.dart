import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/features/explore/screen/explore_screen.dart';
import 'package:gadgets_marketplace/features/home/cubit/bottom_nav_cubit.dart';
import 'package:gadgets_marketplace/features/home/screens/home_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // လက်ရှိ ရွေးချယ်ထားတဲ့ Tab Index
  // int _selectedIndex = 0;

  // ပြသချင်တဲ့ Screens စာရင်း (ဒီမှာ သင့်ရဲ့ Screen Class တွေ အစားထိုးပေးပါ)
  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const Center(child: Text('Chat Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Cart Screen', style: TextStyle(fontSize: 24))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 24))),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex =
  //         index; // Tab ပြောင်းလိုက်တိုင်း Index ကို Update လုပ်ပေးပါ
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // IndexedStack ကို သုံးရင် Tab တွေ ပြောင်းတဲ့အခါ Screen State တွေ မပျက်ဘဲ သိမ်းထားပေးပါတယ်
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return IndexedStack(index: state, children: _screens);
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return NavigationBar(
            onDestinationSelected: (value) {
              context.read<BottomNavCubit>().updateNavIndex(value);
            },
            indicatorColor: AppColors.background,
            backgroundColor: AppColors.background,
            height: 60,
            labelTextStyle: WidgetStatePropertyAll(AppTextStyles.caption),
            selectedIndex: state,
            // onDestinationSelected: _onItemTapped,
            elevation: 8,

            destinations: const [
              NavigationDestination(
                icon: Icon(LucideIcons.home, color: AppColors.border2),
                selectedIcon: Icon(LucideIcons.home, color: AppColors.primary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.search, color: AppColors.border2),
                selectedIcon: Icon(
                  LucideIcons.search,
                  color: AppColors.primary,
                ),
                label: 'Explore',
              ),

              NavigationDestination(
                icon: Icon(
                  LucideIcons.messageCircle,
                  color: AppColors.border2,
                  fill: 1.0,
                  size: 26,
                ),
                selectedIcon: Icon(
                  LucideIcons.messageCircle,
                  color: AppColors.primary,
                  fill: 1,
                  size: 26,
                ),
                label: 'Chat',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.shoppingCart, color: AppColors.border2),
                selectedIcon: Icon(
                  LucideIcons.shoppingCart,
                  color: AppColors.primary,
                ),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.userRound, color: AppColors.border2),
                selectedIcon: Icon(
                  LucideIcons.userRound,
                  color: AppColors.primary,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
