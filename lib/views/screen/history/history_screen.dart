import 'package:flutter/material.dart';
import 'package:inventku/utils/const/app_colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shadowColor: AppColors.shadowColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: AppColors.primaryColor,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  suffixIcon: const Icon(Icons.search),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Riwayat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 6,
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
                      title: const Text('Barang: Oreo Blackpink'),
                      subtitle: const Text('Jumlah: 50 | Harga: Rp. 10.000'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text('Fernand'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('12-12-2023'),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
