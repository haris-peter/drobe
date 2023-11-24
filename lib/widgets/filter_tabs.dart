import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class FilterTabs extends StatefulWidget {
  final TabController? tabController;
  final List? listToFilter;
  final List<String>? tabNames;
  final void Function(List<List<int>>)? updateParent;
  final void Function()? reloadParent;

  FilterTabs({
    Key? key,
    this.tabController,
    this.listToFilter,
    this.tabNames,
    this.updateParent,
    this.reloadParent,
  }) : super(key: key);

  @override
  _FilterTabsState createState() => _FilterTabsState();
}

class _FilterTabsState extends State<FilterTabs> with TickerProviderStateMixin {
  late List<String> _tabNames;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabNames = widget.tabNames ?? [];
    _tabController = widget.tabController ?? TabController(length: _tabNames.length, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        widget.updateParent?.call(_filterList());
        widget.reloadParent?.call();
      }
    });
  }

  List<List<int>> _filterList() {
    List<List<int>> _filteredList = List.filled(_tabNames.length, []);
    _filteredList[0] = List.generate(widget.listToFilter!.length, (index) => index);
    for (int i = 1; i < _tabNames.length; i++) {
      List<int> tempList = [];
      for (int j = 0; j < widget.listToFilter!.length; j++) {
        if (widget.listToFilter![j].contains(_tabNames[i])) {
          tempList.add(j);
          _filteredList[i] = tempList;
        }
      }
    }
    return _filteredList;
  }

  List<Widget> _buildTabs() {
    return _tabNames
        .map(
          (name) => Text(
            name,
            maxLines: 1,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Builder(
          builder: (context) {
            return TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BubbleTabIndicator(
                indicatorHeight: 18.0,
                indicatorColor: Colors.blueAccent,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: _buildTabs(),
              controller: _tabController,
            );
          },
        ),
      ),
    );
  }
}
