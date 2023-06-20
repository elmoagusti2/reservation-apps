import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reservation_apps/app/common/constants/colors.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/modules/profile/views/profile_view.dart';
import 'package:reservation_apps/app/modules/transactionPage/views/transaction_page_view.dart';
import 'package:reservation_apps/app/modules/widgets/parallax_animation.dart';
import 'package:reservation_apps/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeUser(),
    TransactionPageView(),
    ProfileView()
  ];

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => SafeArea(
            child: _widgetOptions.elementAt(controller.selectedIndex.value),
          )),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              curve: Curves.easeInQuart,
              // rippleColor: Colors.grey[300]!,
              // hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: ConstColors.white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ConstColors.customRed,
              color: ConstColors.customRed,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.payments,
                  text: 'Transaction',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: controller.selectedIndex.value,
              onTabChange: (index) {
                controller.selectedIndex.value = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (data) {
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.soccerField.length,
            itemBuilder: (BuildContext context, int index) {
              var lapangan = data.soccerField[index];
              return Hero(
                tag: lapangan.nama.toString(),
                child: InkWell(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: AnimatedItem(
                        imageUrl: '${lapangan.picturePath}',
                        title: lapangan.nama ?? '',
                        subtitle: '${lapangan.kategori}',
                        widget: Text(
                          "Rp ${lapangan.price?.weekday7sd13}",
                          style: const TextStyle(color: ConstColors.white),
                        ),
                        vertical: true),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_PAGE, arguments: lapangan);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
