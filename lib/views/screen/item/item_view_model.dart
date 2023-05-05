// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:inventku/model/item_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/database_helper.dart';

enum DbManagerState {
  none,
  loading,
  error,
}

class DbManager extends ChangeNotifier {
  // getter setter untuk menyimpan state widget
  DbManagerState _state = DbManagerState.none;
  DbManagerState get state => _state;

  changeState(DbManagerState s) {
    _state = s;
    notifyListeners();
  }

  // formkey dan text controller
  final formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController gambarController = TextEditingController();

  // shared preferences utk get data username yg sdg login
  String _username = '';
  String get username => _username;

  late DatabaseHelper _dbHelper;

  // list items
  List<ItemModel> _items = [];
  List<ItemModel> get items => _items;

  // fav items
  final List<ItemModel> _favItems = [];
  List<ItemModel> get favItems => _favItems;

  // tanggal
  DateTime _date = DateTime.now();
  final currentDate = DateTime.now();
  DateTime get date => _date;

  // pick files
  List<int> _imageBytes = [];
  String _fileName = '';

  // getter image
  List<int> get imageBytes => _imageBytes;
  String get fileName => _fileName;

  void updateDate(DateTime selectDate) {
    _date = selectDate;
    notifyListeners();
  }

  // get file image
  Future<void> getFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = path.basename(file.path);
      log('File path: $file');
      log('File name: $fileName');

      _imageBytes = file.readAsBytesSync();
      _fileName = fileName;

      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Tolong pilih gambar'),
      ));
    }
  }

  // save item to database
  Future<void> saveItem(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Barang Berhasil Ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );
      // format tanggal
      String date = DateFormat('dd/MM/yyyy').format(_date);
      // get username utk createdBy
      SharedPreferences logindata = await SharedPreferences.getInstance();
      _username = logindata.getString('username').toString();

      final addItem = ItemModel(
        nama: namaController.text,
        harga: int.parse(hargaController.text),
        stok: int.parse(stokController.text),
        gambar: Uint8List.fromList(imageBytes),
        tanggal: date,
        createdBy: _username,
      );

      log(addItem.createdBy);
      Provider.of<DbManager>(context, listen: false).addItem(addItem);

      namaController.clear();
      hargaController.clear();
      stokController.clear();
      gambarController.clear();

      Navigator.pop(context);
    }
  }

  // inisialisasi database
  DbManager() {
    _dbHelper = DatabaseHelper();
    _getAllItems();
    notifyListeners();
  }

  // get all item from database
  void _getAllItems() async {
    changeState(DbManagerState.loading);
    try {
      _items = await _dbHelper.getItem();
      notifyListeners();
      changeState(DbManagerState.none);
    } catch (e) {
      changeState(DbManagerState.error);
    }
  }

  // add item to database
  Future<void> addItem(ItemModel item) async {
    await _dbHelper.insertItem(item);
    _getAllItems();
    notifyListeners();
  }

  // get item by id
  Future<ItemModel> getItemById(int id) async {
    return await _dbHelper.getItemById(id);
  }

  // update item in database
  void updateItem(int id, ItemModel item) async {
    await _dbHelper.updateItem(id, item);
    _getAllItems();
    notifyListeners();
  }

  // delete item in database
  void deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    _getAllItems();
    notifyListeners();
  }

  // search data item from database
  Future<void> searchData(String keyword) async {
    _items = await _dbHelper.searchData(keyword);
    notifyListeners();
  }

  // menambahkan barang ke list favorite
  void addFavorite(ItemModel item) {
    _favItems.add(item);
    notifyListeners();
  }

  // menghapus barang dari list favorite
  void removeFavorite(ItemModel item) {
    _favItems.remove(item);
    notifyListeners();
  }
}
