import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/secure_storage.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupils_filter_impl.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_filter_manager.dart';
import 'package:schuldaten_hub/features/schoolday_events/services/schoolday_event_manager.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_filter_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/api/services/connection_manager.dart';
import 'package:schuldaten_hub/features/matrix/services/matrix_policy_manager.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/manager/pupil_manager.dart';

import 'package:schuldaten_hub/features/pupil/manager/pupil_personal_data_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/features/landing_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';
import 'package:watch_it/watch_it.dart';

import '../../api/services/api_manager.dart';
import '../../features/attendance/services/attendance_manager.dart';
import 'session_manager.dart';

final locator = GetIt.instance;

void registerBaseManagers() {
  debug.info('Registering base managers');
  locator.registerSingletonAsync<EnvManager>(() async {
    debug.info('Registering EnvManager');
    final envManager = EnvManager();
    await envManager.init();
    debug.info('EnvManager initialized');
    return envManager;
  });

  locator.registerSingletonAsync<ConnectionManager>(() async {
    debug.info('Registering ConnectionManager');
    final connectionManager = ConnectionManager();
    await connectionManager.checkConnectivity();
    debug.info('ConnectionManager initialized');
    return connectionManager;
  });

  locator.registerSingletonAsync<SessionManager>(() async {
    debug.info('Registering SessionManager');
    final sessionManager = SessionManager();
    await sessionManager.init();
    debug.info('SessionManager initialized');
    return sessionManager;
  }, dependsOn: [EnvManager, ConnectionManager]);

  locator.registerSingletonAsync<PupilPersonalDataManager>(() async {
    debug.info('Registering PupilBaseManager');
    final pupilBaseManager = PupilPersonalDataManager();
    await pupilBaseManager.init();
    debug.info('PupilBaseManager initialized');
    return pupilBaseManager;
  });
  locator.registerSingleton<NotificationManager>(NotificationManager());
  locator.registerSingleton<BottomNavManager>(BottomNavManager());
  locator.registerSingleton<SearchManager>(SearchManager());
}

Future registerDependentManagers(String token) async {
  debug.info('Registering dependent managers');

  locator.registerSingletonAsync<ApiManager>(
    () async {
      debug.info('Registering ApiManager');
      final apiManager = ApiManager();
      await apiManager.init(token);
      debug.info('ApiManager initialized');
      return apiManager;
    },
    dependsOn: [EnvManager, SessionManager, ConnectionManager],
  );

  locator.registerSingletonAsync<SchooldayManager>(() async {
    debug.info('Registering SchooldayManager');
    final schooldayManager = SchooldayManager();
    await schooldayManager.init();
    debug.info('SchooldayManager initialized');
    return schooldayManager;
  }, dependsOn: [SessionManager, ApiManager]);
  locator.registerSingletonAsync<PupilManager>(() async {
    debug.info('Registering PupilManager');
    final pupilManager = PupilManager();
    await pupilManager.init();
    debug.info('PupilManager initialized');
    return pupilManager;
  }, dependsOn: [
    EnvManager,
    ApiManager,
    SessionManager,
    PupilPersonalDataManager
  ]);
  locator.registerSingletonAsync<WorkbookManager>(() async {
    debug.info('Registering WorkbookManager');
    final workbookManager = WorkbookManager();
    await workbookManager.init();
    debug.info('WorkbookManager initialized');
    return workbookManager;
  }, dependsOn: [PupilManager, SessionManager, ApiManager]);

  locator.registerSingletonAsync<CompetenceManager>(() async {
    debug.info('Registering CompetenceManager');
    final competenceManager = CompetenceManager();
    await competenceManager.init();
    debug.info('CompetenceManager initialized');
    return competenceManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonWithDependencies<CompetenceFilterManager>(
    () => CompetenceFilterManager(),
    dependsOn: [CompetenceManager],
  );

  locator.registerSingletonAsync<GoalManager>(() async {
    debug.info('Regirstering GoalManager');
    final goalManager = GoalManager();
    await goalManager.init();
    debug.info('GoalManager initialized');
    return goalManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<AuthorizationManager>(() async {
    debug.info('Registering AuthorizationManager');
    final authorizationManager = AuthorizationManager();
    await authorizationManager.init();
    debug.warning('AuthorizationManager initialized');
    return authorizationManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonWithDependencies<PupilFilterManager>(
    () => PupilFilterManager(),
    dependsOn: [PupilManager],
  );
  locator.registerSingletonWithDependencies<PupilsFilterImplementation>(
    () => PupilsFilterImplementation(
      locator<PupilManager>(),
    ),
    dependsOn: [PupilManager],
  );
  locator.registerSingletonAsync<SchoolListManager>(() async {
    debug.info('Registering SchoolListManager');
    final schoolListManager = SchoolListManager();
    await schoolListManager.init();
    debug.info('SchoolListManager initialized');
    return schoolListManager;
  }, dependsOn: [SessionManager, ApiManager]);
  locator.registerSingletonWithDependencies<SchoolListFilterManager>(
    () => SchoolListFilterManager(),
    dependsOn: [SchoolListManager, PupilFilterManager],
  );
  locator.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [SchooldayManager, PupilFilterManager]);
  locator.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchooldayManager, PupilFilterManager]);
  locator.registerSingletonWithDependencies<SchooldayEventFilterManager>(
    () => SchooldayEventFilterManager(),
    dependsOn: [PupilFilterManager],
  );
  if (await secureStorageContains('matrix')) {
    await registerMatrixPolicyManager();
  }
}

Future<bool> registerMatrixPolicyManager() async {
  locator.registerSingletonAsync<MatrixPolicyManager>(() async {
    debug.info('Registering MatrixPolicyManager');
    final policyManager = MatrixPolicyManager();
    await policyManager.init();
    debug.info('MatrixPolicyManager initialized');
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung initialisiert');
    return policyManager;
  }, dependsOn: [SessionManager, PupilManager, PupilFilterManager]);

  locator.registerSingletonWithDependencies<MatrixPolicyFilterManager>(
    () => MatrixPolicyFilterManager(),
    dependsOn: [MatrixPolicyManager],
  );
  return true;
}

Future unregisterDependentManagers() async {
  locator.unregister<ApiManager>();
  locator.unregister<SchooldayManager>();
  locator.unregister<WorkbookManager>();
  locator.unregister<GoalManager>();
  locator.unregister<PupilManager>();
  locator.unregister<PupilFilterManager>();
  locator.unregister<CompetenceFilterManager>();
  locator.unregister<CompetenceManager>();
  locator.unregister<SchoolListManager>();
  locator.unregister<SchoolListFilterManager>();
  locator.unregister<AuthorizationManager>();
  locator.unregister<AttendanceManager>();
  locator.unregister<SchooldayEventManager>();
  locator.unregister<SchooldayEventFilterManager>();

  if (locator.isRegistered<MatrixPolicyManager>()) {
    locator.unregister<MatrixPolicyManager>();
    locator.unregister<MatrixPolicyFilterManager>();
  }
}
