import 'package:flutter/material.dart';

class CustomFlagSelector extends StatefulWidget {
  final Function(String) onFlagSelected;
  final String? initialValue;

  const CustomFlagSelector({
    super.key,
    required this.onFlagSelected,
    this.initialValue,
  });

  @override
  State<CustomFlagSelector> createState() => _CustomFlagSelectorState();
}

class _CustomFlagSelectorState extends State<CustomFlagSelector> {
  final List<Map<String, String>> _flags = [
    {'flag': '🇧🇷', 'country': 'Brazil'},
    {'flag': '🇺🇸', 'country': 'United States'}, 
    {'flag': '🇨🇭', 'country': 'Switzerland'},
    {'flag': '🇯🇵', 'country': 'Japan'},
    {'flag': '🇪🇸', 'country': 'Spain'},
    {'flag': '🇵🇹', 'country': 'Portugal'},
    {'flag': '🇮🇹', 'country': 'Italy'},
  ];

  String _selectedFlag = '';
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedFlag = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredFlags {
    if (_searchQuery.isEmpty) {
      return _flags;
    }
    return _flags.where((flag) {
      return flag['country']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search country...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _filteredFlags.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFlag = _filteredFlags[index]['flag']!;
                    widget.onFlagSelected(_selectedFlag);
                  });
                },
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: _selectedFlag == _filteredFlags[index]['flag']
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: _selectedFlag == _filteredFlags[index]['flag']
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _filteredFlags[index]['flag']!,
                        style: const TextStyle(fontSize: 32),
                      ),
                      Text(
                        _filteredFlags[index]['country']!,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
