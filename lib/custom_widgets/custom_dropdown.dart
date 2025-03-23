import 'package:cipherschool_assignment/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomExpandableDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final Function(String) onItemSelected;

  const CustomExpandableDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onItemSelected,
  });

  @override
  State<CustomExpandableDropdown> createState() =>
      _CustomExpandableDropdownState();
}

class _CustomExpandableDropdownState extends State<CustomExpandableDropdown> {
  bool _isExpanded = false;
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectItem(String value) {
    widget.onItemSelected(value);
    setState(() {
      _selectedValue = value;
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: 3.w,
          color: textFieldColor,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleDropdown,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedValue ?? widget.hintText,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: _selectedValue == null ? textColor : Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  SvgPicture.asset(
                    _isExpanded
                        ? "assets/images/arrow_down.svg"
                        : "assets/images/arrow_down.svg",
                    color: textColor,
                  ),
                ],
              ),
            ),
          ),
          // Dropdown Items (When Expanded)
          if (_isExpanded) ...[
            SizedBox(height: 8.h),
            Column(
              children: List.generate(
                widget.items.length,
                (index) => Column(
                  children: [
                    InkWell(
                      onTap: () => _selectItem(widget.items[index]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                              ),
                              child: Text(
                                widget.items[index],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index != widget.items.length - 1)
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 2,
                        height: 2,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
