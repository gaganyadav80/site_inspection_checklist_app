import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/mock_data.dart';
import 'package:site_inspection_checklist_app/model/item_category.dart';
import 'package:site_inspection_checklist_app/widgets/primary_button.dart';

class AddInspectionItemModalSheet extends StatefulWidget {
  const AddInspectionItemModalSheet({super.key});

  @override
  State<AddInspectionItemModalSheet> createState() =>
      _AddInspectionItemModalSheetState();
}

class _AddInspectionItemModalSheetState
    extends State<AddInspectionItemModalSheet> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  IdName? selectedCategory;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = context.textTheme.bodyMedium?.copyWith(
      color: Colors.grey.shade800,
    );
    final hintStyle = context.textTheme.bodyMedium?.copyWith(
      color: Colors.grey.shade600,
    );

    final inputBorder = OutlineInputBorder(
      borderRadius: kDefaultBorderRadius,
      borderSide: BorderSide(
        color: Colors.grey.shade200,
      ),
    );
    final decoration = InputDecoration(
      hintStyle: hintStyle,
      border: inputBorder,
      enabledBorder: inputBorder,
      errorBorder: inputBorder,
      focusedBorder: inputBorder.copyWith(
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(16).copyWith(
        bottom: context.bottomSafePadding + context.bottomKeyboardPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Text(
                  'Add Inspection Item',
                  style: context.textTheme.titleMedium,
                ),
              ),
              TooltipVisibility(
                visible: false,
                child: CloseButton(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey.shade200,
          ),
          SizedBox(height: 16),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item Name',
                  style: labelStyle,
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: nameController,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: decoration.copyWith(
                    hintText: 'i.e. Electrical Wiring',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Item name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Category',
                  style: labelStyle,
                ),
                SizedBox(height: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<IdName>(
                    decoration: decoration.copyWith(
                      hintText: 'Select category',
                      focusedBorder: inputBorder,
                    ),
                    borderRadius: kDefaultBorderRadius,
                    dropdownColor: Colors.white,
                    style: hintStyle,
                    onChanged: (value) {},
                    items: mockCategories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                          style: labelStyle?.copyWith(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Category is required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          PrimaryButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {}
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add Item'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
