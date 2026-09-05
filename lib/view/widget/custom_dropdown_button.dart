import 'package:ecommerce/core/constants/colore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final ValueNotifier<String?> valueListenable;
  final Function(String?) onChanged;
  final String hintText;
  final IconData hintIcon;
  final double buttonHeight;
  final double buttonWidth;
  final double maxHeight;
  final double dropdownWidth;
  final Offset dropdownOffset;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.valueListenable,
    required this.onChanged,
    required this.hintText,
    this.hintIcon = Icons.list,
    this.buttonHeight = 50,
    this.buttonWidth = 160,
    this.maxHeight = 200,
    this.dropdownWidth = 200,
    this.dropdownOffset = const Offset(-20, 0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              Icon(hintIcon, size: 16, color: AppColors.primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  hintText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 243, 243, 238),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map(
                (String item) => DropdownItem<String>(
                  value: item,
                  height: 40,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          valueListenable: valueListenable,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: buttonHeight,
            width: buttonWidth,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black26),
              color: AppColors.primary,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_forward_ios_outlined),
            iconSize: 14,
            iconEnabledColor: AppColors.primary,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: maxHeight,
            width: dropdownWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.primary,
            ),
            offset: dropdownOffset,
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
