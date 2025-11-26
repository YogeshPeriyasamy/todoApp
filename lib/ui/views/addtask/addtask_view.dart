import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'addtask_viewmodel.dart';

class AddtaskView extends StackedView<AddtaskViewModel> {
  const AddtaskView({Key? key}) : super(key: key);

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
                      1, BoxShadow(blurRadius: 3, color: Colors.grey))),
              padding:
                  EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 18),
                          child: Text(
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 18),
                          child: Text(
                            "Category",
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
                              initialValue: viewModel.selectedCategory,
                              items: viewModel.categories.map((category) {
                                return DropdownMenuItem<String>(
                                  child: Text(category),
                                  value: category,
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                viewModel.setCategory(value);
                              }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(right: 18),
                          child: Text(
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
                                  child: Text(stat),
                                  value: stat,
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              onChanged: (value) {
                                viewModel.setCategory(value);
                              }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
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
                        viewModel.addTask();
                      },
                      child: Text(
                        "Add task",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
