import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:drobe/database/db_helper.dart';
import 'package:drobe/models/item_model.dart';
import 'package:drobe/models/outfit_model.dart';
import 'package:drobe/screens/image_capture_screen.dart';
import 'package:drobe/screens/insights_screen.dart';
import 'package:drobe/screens/items_screen.dart';
import 'package:drobe/screens/outfit_screen.dart';
import 'package:drobe/screens/outfit_add_items_screen.dart';
import 'package:drobe/screens/item_details_screen.dart';
import 'package:drobe/screens/outfit_details_screen.dart';
import 'package:drobe/widgets/bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _screens = [];
  final DbHelper _dbHelper = DbHelper();
  List<Item> _items = [];
  List<Outfit> _outfits = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  @override
  void dispose() {
    _dbHelper.close();
    super.dispose();
  }

  void _onBottomBarTap(int? index) {
    setState(() {
      _selectedIndex = index ?? 0;
    });
  }

  void _refreshItems() async {
    final items = await _dbHelper.getItems();
    final outfits = await _dbHelper.getOutfits();

    setState(() {
      _outfits.clear();
      _outfits.addAll(outfits);

      _items.clear();
      _items.addAll(items);

      _updateItemImages();

      _outfits.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
      _items.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));

      _screens = [
        ItemScreen(
          items: _items,
          onItemCardTap: _showItemDetails,
        ),
        OutfitScreen(
          items: _items,
          outfits: _outfits,
          onOutfitCardTap: _showOutfitDetails,
        ),
        InsightsScreen(
          items: _items,
          outfits: _outfits,
        ),
      ];
    });
  }

  void _updateItemImages() {
    for (Item item in _items) {
      item.imageWidget = Image.memory(
        base64Decode(item.image!),
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    }
  }

  void _showItemDetails(Item item) async {
    final val = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(
          dbHelper: _dbHelper,
          item: item,
        ),
      ),
    );

    if (val == 'refresh') {
      _refreshItems();
    }
  }

  void _showOutfitDetails(Outfit outfit, List<Item> itemsInOutfit) async {
    final val = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OutfitDetailsScreen(
          dbHelper: _dbHelper,
          outfit: outfit,
          itemsInOutfit: itemsInOutfit.toList(),
        ),
      ),
    );

    if (val == 'refresh') {
      _refreshItems();
    }
  }

  void _onFABPress() {
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ImageCaptureScreen(
            dbHelper: _dbHelper,
          ),
        ),
      ).then((_) {
        _refreshItems();
      });
    } else if (_selectedIndex == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OutfitAddItemsScreen(
            dbHelper: _dbHelper,
            items: _items,
          ),
        ),
      ).then((_) {
        _refreshItems();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onBottomBarTap: _onBottomBarTap,
      ),
    );
  }

  FloatingActionButton? _buildFloatingActionButton() {
    if (_selectedIndex == 0 || _selectedIndex == 1) {
      return FloatingActionButton(
        onPressed: _onFABPress,
        child: Icon(Icons.add),
      );
    } else {
      return null;
    }
  }
}
