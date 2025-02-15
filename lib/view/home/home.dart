
import 'package:admin_plantbazar/view/add_products/screen/added_products.dart';
import 'package:admin_plantbazar/view/auth/auth.dart';
import 'package:admin_plantbazar/view/earnings/earnings.dart';
import 'package:admin_plantbazar/view/home/widget/home_card.dart';
import 'package:admin_plantbazar/view/orders/screens/orders.dart';
import 'package:admin_plantbazar/view/paymentmethord/payment_methords.dart';
import 'package:admin_plantbazar/view/settings/screens/settings.dart';
import 'package:admin_plantbazar/view/total_stocks.dart/total_stocks.dart';
import 'package:admin_plantbazar/view/users/users_screen.dart';
import 'package:admin_plantbazar/widget/common_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> _screens = [
    const ScreenAddedProducts(),
    ScreenEarnings(),
    const ScreenStocks(),
    const OrdersScreen(),
    const PaymentMethordsScreen(),
    const UsersScreen(),
  ];
  final List<IconData> _screenIcons = [
    Icons.shopping_cart_outlined,
    Icons.money,
    Icons.shop,
    Icons.card_giftcard,
    Icons.attach_money,
    Icons.person
  ];
  final List<String> _screenName = [
    'Add product',
    'Earnings',
    'Stocks',
    'Orders',
    'Payment Methords',
    'User Screen'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Choose What you want',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenSettings(),
                  ),
                );
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                firebase.signOut();
              },
              icon: const Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                kHeight40,
                const SizedBox(
                  height: 40,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                    const cardWidth = 200.0;
                    const cardHeight = 200.0;

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: cardWidth / cardHeight,
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        return AdminCard(
                          icon: _screenIcons[index],
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          name: _screenName[index],
                          navigator: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => _screens[index],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const LinearGradient gcolor = LinearGradient(colors: [
  Color.fromARGB(255, 109, 219, 236),
  Color.fromARGB(255, 162, 245, 175),
], begin: Alignment.topLeft);
