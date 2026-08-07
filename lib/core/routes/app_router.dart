import 'package:flutter/material.dart';
import 'package:gadgets_marketplace/features/details/screens/product_details_screen.dart';
import 'package:gadgets_marketplace/features/explore/screen/explore_screen.dart';
import 'package:gadgets_marketplace/features/home/screens/home_screen.dart';
import 'package:gadgets_marketplace/screens/main_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../constants/supabase_client.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',

    // Supabase Auth State ပြောင်းလဲမှုကို နားစွင့်ပြီး Route များကို အလိုအလျောက် Refresh လုပ်ပေးခြင်း
    refreshListenable: GoRouterRefreshStream(supabase.auth.onAuthStateChange),

    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/explore',
        name: 'explore',
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: '/details/:id',
        name: 'details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return ProductDetailsScreen(productId: id ?? "");
        },
      ),
    ],

    // Auth Guard - User Login ဝင်ထားခြင်း ရှိ/မရှိ ပေါ်မူတည်၍ Redirect လုပ်ပေးခြင်း
    redirect: (context, state) {
      final session = supabase.auth.currentSession;
      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      // Login မဝင်ရသေးပါက Login သို့မဟုတ် Register Screen မှာပဲ ထားမည်
      if (session == null) {
        return isLoggingIn ? null : '/login';
      }

      // Login ဝင်ထားပြီးပါက Auth Screens များသို့ သွားခွင့်မပေးဘဲ Home သို့ ပို့မည်
      if (isLoggingIn) {
        return '/main';
      }

      return null;
    },
  );
}

// Supabase Auth Stream ကို GoRouter ၏ refreshListenable ထဲတွင် သုံးနိုင်ရန် Helper Class
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    stream.listen((_) => notifyListeners());
  }
}
