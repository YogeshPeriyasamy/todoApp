import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/todo_model.dart';

import 'addtask_viewmodel.dart';

class AddtaskView extends StackedView<AddtaskViewModel> {
  final bool isEditing;
  final Todo? todo;
  final int? index;

  const AddtaskView({
    Key? key,
    this.isEditing = false,
    this.todo,
    this.index,
  }) : super(key: key);

  @override
  void onViewModelReady(AddtaskViewModel viewmodel) async {
    if (isEditing == true) {
      await viewmodel.initialize(todo, index, isEditing);
    }
  }

  @override
  Widget builder(
    BuildContext context,
    AddtaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: viewModel.isDark ? Colors.black : Colors.white,
        elevation: 10,
        shadowColor: viewModel.isDark ? Colors.white : Colors.black,
        leading: IconButton(
            onPressed: () {
              viewModel.navBacktoDashboard();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: Text(
          "Add/Edit task",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: viewModel.isDark ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: viewModel.isDark ? Colors.black : Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.isDark
                      ? Colors.white
                      : const Color.fromARGB(244, 255, 255, 255),
                  boxShadow: List.filled(
                      1, const BoxShadow(blurRadius: 3, color: Colors.grey))),
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 18),
                          child: const Text(
                            "Title",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                        child: Material(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(3)),
                          shadowColor: Colors.grey,
                          child: TextField(
                              controller: viewModel.titleController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.all(8),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Enter title")),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Material(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(3)),
                    shadowColor: Colors.grey,
                    child: TextField(
                        maxLines: null,
                        minLines: 4,
                        controller: viewModel.descriptionController,
                        decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.all(8),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Enter description")),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.only(right: 18),
                      child: const Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 2,
                    children: viewModel.categories.map((category) {
                      final isSelected =
                          viewModel.selectedCategories.contains(category);
                      return FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          viewModel.setCategory(category);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 0),
                        selectedColor: Colors.blue,
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(right: 18),
                          child: const Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          )),
                      Expanded(
                        child: Material(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(3)),
                          shadowColor: Colors.grey,
                          child: DropdownButtonFormField<String>(
                              initialValue: viewModel.status,
                              items: viewModel.statusList.map((stat) {
                                return DropdownMenuItem<String>(
                                  value: stat,
                                  child: Text(stat),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                viewModel.setStatus(value);
                              }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        viewModel.addOrEditTask();
                      },
                      child: Text(
                        isEditing ? "Update" : "Add",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  AddtaskViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddtaskViewModel();
}
