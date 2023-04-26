import 'package:flutter/material.dart';
import 'package:inventku/views/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const/app_colors.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late SharedPreferences logindata;
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username').toString();
      email = logindata.getString('email').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InventKu'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                logindata.setBool('login', true);
                logindata.remove('username');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                size: 20,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang, $username!',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            heroScreen(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Menu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            menuScreen(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Katalog',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            listView()
          ],
        ),
      ),
    );
  }

  Widget heroScreen() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Card(
        shadowColor: AppColors.shadowColor,
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox(
          height: 90,
          width: 130,
          child: Column(
            children: [
              Image.asset(
                'assets/icons/chart.png',
                scale: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Total Barang',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '8',
                style: TextStyle(fontSize: 16),
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
      Card(
        shadowColor: AppColors.shadowColor,
        elevation: 6,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SizedBox(
          height: 90,
          width: 130,
          child: Column(
            children: [
              Image.asset(
                'assets/icons/jumlah.png',
                scale: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Total Stok',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '150',
                style: TextStyle(fontSize: 16),
                textWidthBasis: TextWidthBasis.longestLine,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ]);
  }

  Widget menuScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Card(
            shadowColor: AppColors.shadowColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                'assets/icons/add.png',
                scale: 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {},
          child: Card(
            shadowColor: AppColors.shadowColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                'assets/icons/history.png',
                scale: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {},
          child: Card(
            shadowColor: AppColors.shadowColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                'assets/icons/profile.png',
                scale: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listView() {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return PhysicalShape(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                color: Colors.white,
                shadowColor: AppColors.shadowColor,
                elevation: 3,
                child: ListTile(
                  leading: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.asset('assets/images/oreo.png'),
                  ),
                  title: const Text('Oreo Blackpink'),
                  subtitle: const Text('Stok: 50'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text('Harga'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Rp. 10.000'),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemCount: 4));
  }
}
