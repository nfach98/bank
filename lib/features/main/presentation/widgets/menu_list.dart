import 'package:bank/common/constants/media_query_constants.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onMenuItemClicked;
  final List<String> listMenu = [
    'Beranda',
    'Anggaran',
    'Prakiraan',
    'Realisasi',
    'Laporan',
    'Pengaturan',
  ];

  MenuList(
      {Key? key, required this.selectedIndex, required this.onMenuItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.height * 0.1),
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listMenu.length,
          itemBuilder: (_, index) => InkWell(
            onTap: () => onMenuItemClicked(index),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                listMenu[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: selectedIndex == index ? 20.0 : 16.0,
                  fontWeight: selectedIndex == index
                      ? FontWeight.w900
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
