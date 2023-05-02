import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventku/utils/const/app_colors.dart';
import 'package:inventku/views/screen/item/item_view_model.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbManager>(context, listen: false);
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
                onChanged: (value) {
                  provider.searchData(value);
                },
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
            Consumer<DbManager>(
              builder: (context, value, child) {
                final listHistory = value.items;
                return Expanded(
                  child: ListView.separated(
                    itemCount: listHistory.length,
                    itemBuilder: (context, index) {
                      final list = listHistory[index];
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
                          title: Text('Barang: ${list.nama}'),
                          subtitle: Text(
                              'Jumlah: ${list.stok} | Harga: ${NumberFormat.simpleCurrency(name: 'IDR').format(list.harga)}'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(list.createdBy),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(list.tanggal),
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
