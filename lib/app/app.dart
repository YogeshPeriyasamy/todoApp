import 'package:realtodo/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:realtodo/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:realtodo/ui/views/home/home_view.dart';
import 'package:realtodo/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:realtodo/ui/views/dashboard/dashboard_view.dart';
import 'package:realtodo/services/prefs_service_service.dart';
import 'package:realtodo/ui/views/addtask/addtask_view.dart';
import 'package:realtodo/services/themetoggle_service.dart';
import 'package:realtodo/ui/views/login/login_view.dart';
import 'package:realtodo/ui/views/sign_up/sign_up_view.dart';
import 'package:realtodo/services/supabase_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: AddtaskView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: PrefsServiceService),
    LazySingleton(classType: ThemetoggleService),
    LazySingleton(classType: SupabaseService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
