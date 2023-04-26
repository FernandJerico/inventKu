import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventku/model/item_model.dart';
import 'package:inventku/utils/const/app_colors.dart';
import 'package:inventku/views/screen/item/item_view_model.dart';
import 'package:provider/provider.dart';

class DetailItemScreen extends StatelessWidget {
  final ItemModel item;
  const DetailItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // String nama = '';
    // int harga = 0;
    // int stok = 0;
    final provider = Provider.of<DbManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Barang'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 250,
              width: 300,
              child: Image.memory(item.gambar!),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 244, 244),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.nama,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Stok Barang:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(item.stok).toString()} pcs',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Harga Barang:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(name: 'IDR')
                              .format(item.harga),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dibuat Oleh:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.createdBy,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tanggal Dibuat:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.tanggal,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.dangerButton,
                                shape: const StadiumBorder()),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Center(
                                        child: Text("Apakah Anda Yakin?")),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.dangerButton,
                                            shape: const StadiumBorder()),
                                        onPressed: () {
                                          provider.deleteItem(item.id!);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Barang Berhasil Dihapus!'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        },
                                        child: const Text('Ya'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Tidak',
                                          style: TextStyle(
                                              color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Hapus')),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              TextEditingController namaBarang =
                                  TextEditingController(text: item.nama);
                              TextEditingController hargaBarang =
                                  TextEditingController(
                                      text: item.harga.toString());
                              TextEditingController stokBarang =
                                  TextEditingController(
                                      text: item.stok.toString());
                              await _showBottomSheet(context, provider,
                                  namaBarang, stokBarang, hargaBarang);
                            },
                            child: const Text('Edit')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showBottomSheet(
      BuildContext context,
      DbManager provider,
      TextEditingController namaBarang,
      TextEditingController stokBarang,
      TextEditingController hargaBarang) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Edit Data',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<DbManager>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: namaBarang,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama Barang Tidak Boleh Kosong";
                              } else if (value.contains(
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
                                  value.contains(RegExp(r'[0-9]'))) {
                                return "Nama Barang Harus Alphabet";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              labelText: 'Nama Barang',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: stokBarang,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Stok Barang Tidak Boleh Kosong";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              labelText: 'Stok Barang',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: hargaBarang,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Harga Barang Tidak Boleh Kosong";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              labelText: 'Harga Barang',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () async {
                                    final selectDate = await showDatePicker(
                                        context: context,
                                        initialDate: provider.currentDate,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(
                                            provider.currentDate.year + 5));
                                    value.updateDate(selectDate!);
                                  },
                                  child: const Text(
                                    'Pilih Tanggal',
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  )),
                              Text(DateFormat('dd/MM/yyyy').format(value.date)),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.shadowColor,
                                ),
                                onPressed: () async {
                                  provider.getFile(context);
                                },
                                child: const Text(
                                  'Unggah',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(value.fileName)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                shape: const StadiumBorder()),
                            onPressed: () {
                              String date = DateFormat('dd/MM/yyyy')
                                  .format(provider.date);
                              item.nama = namaBarang.text;
                              item.harga = int.parse(hargaBarang.text);
                              item.stok = int.parse(stokBarang.text);
                              item.tanggal = date;
                              if (item.gambar != null) {
                                item.gambar =
                                    Uint8List.fromList(provider.imageBytes);
                              }
                              Provider.of<DbManager>(context, listen: false)
                                  .updateItem(item.id!, item);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barang Berhasil Diedit'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: const Text('Edit'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ]),
          ),
        );
      },
    );
  }
}
