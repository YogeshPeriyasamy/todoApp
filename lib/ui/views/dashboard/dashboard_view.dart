import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  DashboardView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DashboardViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: viewModel.isDarkThemed ? Colors.black : Colors.white,
        elevation: 10,
        shadowColor: viewModel.isDarkThemed ? Colors.white : Colors.black,
        title: Text(
          "TO DO",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: viewModel.isDarkThemed ? Colors.white : Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                viewModel.toggleTheme();
              },
              icon: Icon(
                  viewModel.isDarkThemed ? Icons.dark_mode : Icons.light_mode))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: viewModel.isDarkThemed ? Colors.black : Colors.white,
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.categoryList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          viewModel.setCategory(viewModel.categoryList[index]);
                        },
                        child: Text(
                          viewModel.categoryList[index],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        color: Colors.blue,
                      ),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 0, left: 50, right: 50),
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: const Color.fromARGB(255, 172, 211, 243)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text("Total tasks",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Text(viewModel.todoList.length.toString())
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text("Completed tasks",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Text("1")
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Pending tasks",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Text("2")
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Material(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                shadowColor:
                    viewModel.isDarkThemed ? Colors.white : Colors.black,
                child: TextField(
                  controller: viewModel.serarchController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    labelText: "Search todo",
                  ),
                  onChanged: (value) => viewModel.setSearch(value),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 14),
                child: ListView.builder(
                    itemCount: viewModel.todoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(8),
                          shadowColor: viewModel.isDarkThemed
                              ? Colors.white
                              : Colors.black,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                viewModel.todoList[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.blue),
          padding: const EdgeInsets.all(5),
          child: const Text("Add task")),
    );
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
