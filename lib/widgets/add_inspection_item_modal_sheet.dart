import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/enums.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/model/id_name.dart';
import 'package:site_inspection_checklist_app/model/inspection_task.dart';
import 'package:site_inspection_checklist_app/providers/generic_providers.dart';
import 'package:site_inspection_checklist_app/providers/inspection_task_notifier.dart';
import 'package:site_inspection_checklist_app/widgets/primary_button.dart';

class AddInspectionItemModalSheet extends ConsumerStatefulWidget {
  const AddInspectionItemModalSheet({super.key});

  @override
  ConsumerState<AddInspectionItemModalSheet> createState() =>
      _AddInspectionItemModalSheetState();
}

class _AddInspectionItemModalSheetState
    extends ConsumerState<AddInspectionItemModalSheet> {
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
      color: Colors.grey.shade600,
    );
    final hintStyle = context.textTheme.bodyMedium?.copyWith(
      color: Colors.grey.shade400,
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

    ref.listen(
      inspectionTaskNotifier.select(
        (value) => value.addTaskState,
      ),
      (previous, next) {
        if (next is AsyncData) {
          Navigator.of(context).pop();
        }
      },
    );

    final categories = ref.watch(categoriesProvider).valueOrNull ?? [];

    final addTaskState = ref.watch(
      inspectionTaskNotifier.select(
        (value) => value.addTaskState,
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
                  textCapitalization: TextCapitalization.sentences,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 1,
                  maxLines: null,
                  decoration: decoration.copyWith(
                    hintText: 'i.e. Electrical Wiring',
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
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
                      focusedErrorBorder: inputBorder,
                    ),
                    borderRadius: kDefaultBorderRadius,
                    dropdownColor: Colors.white,
                    style: hintStyle,
                    onChanged: (value) {
                      selectedCategory = value;
                    },
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                          style: labelStyle?.copyWith(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
            onPressed: addTaskState.isLoading
                ? null
                : () {
                    if (formKey.currentState?.validate() ?? false) {
                      final item = InspectionTask(
                        id: 0, // this will be ignored.
                        name: nameController.text.trim(),
                        category: selectedCategory!,
                        status: TaskStatus.pending.idName,
                        createdAt: DateTime.now(),
                        modifiedAt: DateTime.now(),
                      );

                      ref.read(inspectionTaskNotifier.notifier).addTask(item);
                    }
                  },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (addTaskState.isLoading)
                  SizedBox.square(
                    dimension: 20,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                else
                  Text('Add Item'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
