import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventku/utils/const/animation.dart';
import 'package:inventku/views/screen/item/item_view_model.dart';
import 'package:inventku/views/screen/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/const/app_colors.dart';
import '../detail_item/detail_item_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  // remove data user yang sedang login
  void removeData() async {
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    logindata.setBool('login', true);
    logindata.remove('username');
    logindata.remove('email');
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
              showProfile(context);
            },
            icon: const Icon(
              Icons.person_pin,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            welcomeScreen(),
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
              'Barang Favorite',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<DbManager>(
              builder: (context, value, child) {
                return body(value);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget body(DbManager value) {
    final isLoading = value.state == DbManagerState.loading;
    final isError = value.state == DbManagerState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (isError) {
      return const Center(child: Text('Gagal mengambil data'));
    }
    return listView();
  }

  FutureBuilder<SharedPreferences> welcomeScreen() {
    return FutureBuilder<SharedPreferences>(
      future: _prefs,
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          username = snapshot.data!.getString('username').toString();
          email = snapshot.data!.getString('email').toString();
          return Text(
            'Selamat Datang, $username!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        } else {
          return const Text(
            'Selamat Datang, User!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        }
      },
    );
  }

  Future<dynamic> showProfile(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 270,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(children: <Widget>[
              const CircleAvatar(
                backgroundImage: AssetImage('assets/icons/profile2.png'),
                backgroundColor: Colors.white,
                minRadius: 30,
                maxRadius: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                username,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    removeData();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'))
            ]),
          ),
        );
      },
    );
  }

  Widget heroScreen() {
    return Consumer<DbManager>(
      builder: (context, value, child) {
        final list = value.items;
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
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
                  Text(
                    (list.length).toString(),
                    style: const TextStyle(fontSize: 16),
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
      },
    );
  }

  Widget menuScreen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, createRouteItemScreen());
          },
          child: Card(
            shadowColor: AppColors.shadowColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                'assets/icons/add2.png',
                scale: 8,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context, createRouteHistoryScreen());
          },
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
          onTap: () {
            showProfile(context);
          },
          child: Card(
            shadowColor: AppColors.shadowColor,
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
              height: 90,
              width: 90,
              child: Image.asset(
                'assets/icons/profile2.png',
                scale: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listView() {
    return Expanded(child: Consumer<DbManager>(
      builder: (context, value, child) {
        if (value.favItems.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada barang favorite',
            ),
          );
        } else {
          final listFavItems = value.favItems;
          return ListView.separated(
            itemCount: listFavItems.length,
            itemBuilder: (context, index) {
              final list = listFavItems[index];
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
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DetailItemScreen(item: list),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final tween = Tween(begin: 0.0, end: 1.0);
                            return FadeTransition(
                              opacity: animation.drive(tween),
                              child: child,
                            );
                          },
                        ));
                  },
                  leading: SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.memory(list.gambar!),
                  ),
                  title: Text(list.nama),
                  subtitle: Text('Stok: ${list.stok}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Harga'),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        NumberFormat.simpleCurrency(name: 'IDR')
                            .format(list.harga),
                      ),
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
          );
        }
      },
    ));
  }
}
