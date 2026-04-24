import 'package:flutter/material.dart';
import 'package:lottery_app/providers/login_provider.dart';
import 'package:lottery_app/providers/wallet_provider.dart';
import 'package:lottery_app/providers/auth_provider.dart';
import 'package:lottery_app/screens/admin/Tickets/tickets_screen.dart';
import 'package:lottery_app/screens/admin/Wallet/wallet_screen.dart';
import 'package:lottery_app/screens/admin/auth/adminLogin_screen.dart';
import 'package:lottery_app/screens/admin/categories/categories_screen.dart';
import 'package:lottery_app/screens/admin/dashboard/dashboard_screen.dart';
import 'package:lottery_app/screens/admin/draws/create_draws.dart';
import 'package:lottery_app/screens/admin/draws/draws_screen.dart';
import 'package:lottery_app/screens/admin/levelsrewards/levelsrewards_screen.dart';
import 'package:lottery_app/screens/admin/payments/payments_screen.dart';
import 'package:lottery_app/screens/admin/users/add_users.dart';
import 'package:lottery_app/screens/admin/users/users_screen.dart';
import 'package:lottery_app/screens/auth/login_screen.dart';
import 'package:lottery_app/screens/auth/signup_screen.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/games/games_screen.dart';
import 'package:lottery_app/screens/home/home_screen.dart';
import 'package:lottery_app/screens/how_to_play/how_to_play_screen.dart';
import 'package:lottery_app/screens/levels/levels_screen.dart';
import 'package:lottery_app/screens/results/results_screen.dart';
import 'package:lottery_app/screens/wallet/wallet_screen.dart';
import 'package:lottery_app/services/api_services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ApiServices.loadCookie();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WalletProvider(),),
        ChangeNotifierProvider(create: (context)=> AuthProvider(),),
        // Add other providers here as your app grows
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottery Network',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,

        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/all-games': (context) => const GamesScreen(),
          '/results': (context) => const ResultScreen(),
          '/levels': (context) => const LevelsScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/how-to-play': (context) => const HowToPlayScreen(),
          '/login':(context)=> const LoginScreen(),
          '/signup':(context)=> const SignupScreen(),
          '/adminLogin':(context)=>const AdminLoginScreen(),

          '/dashboard':(context)=> const DashboardScreen(),
          '/users':(context)=> const UsersScreen(),
          '/levelsRewards':(context)=> const LevelsRewardsScreen(),
          '/payments':(context)=> const PaymentsScreen(),
          '/draws':(context)=>const DrawsScreen(),
          '/createDraws':(context)=>const CreateDraws(),
          '/categories':(context)=>const CategoriesScreen(),
          '/tickets':(context)=>const TicketsScreen(),
          '/adminWallet':(context)=>const WalletScreenn(),
          '/addUsers':(context)=>const AddUsers()
        }
    );
  }
}
