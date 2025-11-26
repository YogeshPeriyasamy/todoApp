import 'package:realtodo/app/app.locator.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:stacked/stacked.dart';

class AddtaskViewModel extends BaseViewModel {
  final ThemetoggleService _themeService = locator<ThemetoggleService>();

  bool get isDark => _themeService.isDark;

  String selectedCategory = "Work";
  List<String> categories = ["Work", "Personal", "Home", "Urgent", "Health"];
  void setCategory(category) {
    selectedCategory = category;
  }

  String status = "Pending";
  List<String> statusList = ["Pending", "Completed"];
  void setStatus(stat) {
    status = stat;
  }
}
