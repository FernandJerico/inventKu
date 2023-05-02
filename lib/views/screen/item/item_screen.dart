import 'dart:io';
import 'dart:typed_data';

import 'package:inventku/model/item_model.dart';
import 'package:inventku/views/screen/detail_item/detail_item_screen.dart';
import 'package:path/path.dart' as path;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventku/views/screen/item/item_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/const/app_colors.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DbManager>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barang'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Column(
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
                'List Katalog',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<DbManager>(builder: (context, value, child) {
                final listItem = value.items;
                return Expanded(
                  child: ListView.separated(
                    itemCount: listItem.length,
                    itemBuilder: (context, index) {
                      final list = listItem[index];
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
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return DetailItemScreen(
                                  item: list,
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
                              const Text('Harga:'),
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
                  ),
                );
              }),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet(context, provider);
        },
        backgroundColor: AppColors.secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context, DbManager provider) {
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
                  'Tambah Data',
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
                            controller: provider.namaController,
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
                            controller: provider.stokController,
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
                            controller: provider.hargaController,
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
                              provider.saveItem(context);
                            },
                            child: const Text('Tambah'),
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
