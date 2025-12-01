import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StackedView<DashboardViewModel> {
  const DashboardView({Key? key}) : super(key: key);

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
                        color: Colors.blue,
                        child: Text(
                          viewModel.categoryList[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 50, right: 50),
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 172, 211, 243)),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                          child: Text("Total tasks",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Text(viewModel.totalTasks)
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text("Completed tasks",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Text(viewModel.completedTasks)
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Text(
                        "Pending tasks",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Text(viewModel.pendingTasks)
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
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
                    itemCount: viewModel.todos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(8),
                          shadowColor: viewModel.isDarkThemed
                              ? Colors.white
                              : Colors.black,
                          child: InkWell(
                            onTap: () {
                              viewModel.toExpandList(index);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            viewModel.todos[index].title,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            viewModel.editList(
                                                viewModel.todos[index], index);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              viewModel.deleteList(index);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    if (viewModel.expandedList.contains(index))
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Description:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  viewModel
                                                      .todos[index].description,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Categories:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                  child: Wrap(
                                                spacing: 4,
                                                runSpacing: 4,
                                                children: viewModel
                                                    .todos[index].categories
                                                    .map<Widget>((cat) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(8),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              196,
                                                              195,
                                                              195),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 4,
                                                        vertical: 0),
                                                    child: Text(
                                                      cat,
                                                      style: const TextStyle(
                                                          fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),
                                                    ),
                                                  );
                                                }).toList(),
                                              ))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Status:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                viewModel.todos[index].isDone,
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          viewModel.navigateToAddtaskview();
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.blue),
            padding: const EdgeInsets.all(5),
            child: const Text("Add task")),
      ),
    );
  }

  @override
  void onViewModelReady(DashboardViewModel viewModel) async {
    // TODO: implement onModelReady
    print("VIEWMODEL READY");
    viewModel.getList();
    viewModel.getTaskStatus();
  }

  @override
  DashboardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DashboardViewModel();
}
