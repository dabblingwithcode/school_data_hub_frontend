import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/search_textfield_manager.dart';
import 'package:schuldaten_hub/common/services/notification_manager.dart';
import 'package:schuldaten_hub/common/utils/logger.dart';
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

import 'package:schuldaten_hub/features/pupil/manager/pupil_identity_manager.dart';
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
  logger.i('Registering base managers');

  locator.registerSingletonAsync<EnvManager>(() async {
    final envManager = EnvManager();
    await envManager.init();
    logger.i('EnvManager initialized');
    return envManager;
  });

  locator.registerSingletonAsync<ConnectionManager>(() async {
    logger.i('Registering ConnectionManager');
    final connectionManager = ConnectionManager();
    await connectionManager.checkConnectivity();
    logger.i('ConnectionManager registered');
    return connectionManager;
  });

  locator.registerSingletonAsync<SessionManager>(() async {
    logger.i('Registering SessionManager');
    final sessionManager = SessionManager();
    await sessionManager.init();
    logger.i('SessionManager initialized');
    return sessionManager;
  }, dependsOn: [EnvManager, ConnectionManager]);

  locator.registerSingletonAsync<PupilIdentityManager>(() async {
    logger.i('Registering PupilIdentityManager');
    final pupilBaseManager = PupilIdentityManager();
    await pupilBaseManager.init();
    logger.i('PupilIdentityManager initialized');
    return pupilBaseManager;
  });
  locator.registerSingleton<NotificationManager>(NotificationManager());
  locator.registerSingleton<BottomNavManager>(BottomNavManager());
  locator.registerSingleton<SearchManager>(SearchManager());
}

Future registerDependentManagers(String token) async {
  logger.i('Registering dependent managers');

  locator.registerSingletonAsync<ApiManager>(
    () async {
      logger.i('Registering ApiManager');
      final apiManager = ApiManager();
      await apiManager.init(token);
      logger.i('ApiManager initialized');
      return apiManager;
    },
    dependsOn: [EnvManager, SessionManager, ConnectionManager],
  );

  locator.registerSingletonAsync<SchooldayManager>(() async {
    logger.i('Registering SchooldayManager');
    final schooldayManager = SchooldayManager();
    await schooldayManager.init();
    logger.i('SchooldayManager initialized');
    return schooldayManager;
  }, dependsOn: [SessionManager, ApiManager]);
  locator.registerSingletonAsync<PupilManager>(() async {
    logger.i('Registering PupilManager');
    final pupilManager = PupilManager();
    await pupilManager.init();
    logger.i('PupilManager initialized');
    return pupilManager;
  }, dependsOn: [EnvManager, ApiManager, SessionManager, PupilIdentityManager]);
  locator.registerSingletonAsync<WorkbookManager>(() async {
    logger.i('Registering WorkbookManager');
    final workbookManager = WorkbookManager();
    await workbookManager.init();
    logger.i('WorkbookManager initialized');
    return workbookManager;
  }, dependsOn: [PupilManager, SessionManager, ApiManager]);

  locator.registerSingletonAsync<CompetenceManager>(() async {
    logger.i('Registering CompetenceManager');
    final competenceManager = CompetenceManager();
    await competenceManager.init();
    logger.i('CompetenceManager initialized');
    return competenceManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonWithDependencies<CompetenceFilterManager>(
    () => CompetenceFilterManager(),
    dependsOn: [CompetenceManager],
  );

  locator.registerSingletonAsync<GoalManager>(() async {
    logger.i('Registering GoalManager');
    final goalManager = GoalManager();
    await goalManager.init();
    logger.i('GoalManager initialized');
    return goalManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonAsync<AuthorizationManager>(() async {
    logger.i('Registering AuthorizationManager');
    final authorizationManager = AuthorizationManager();
    await authorizationManager.init();
    logger.i('AuthorizationManager initialized');
    return authorizationManager;
  }, dependsOn: [SessionManager, ApiManager]);

  locator.registerSingletonWithDependencies<PupilFilterManager>(
    () => PupilFilterManager(),
    dependsOn: [PupilManager],
  );
  locator.registerSingletonWithDependencies<SchooldayEventFilterManager>(
    () {
      logger.i('SchooldayEventFilterManager initialized');
      return SchooldayEventFilterManager();
    },
    dependsOn: [PupilManager, PupilFilterManager],
  );
  locator.registerSingletonWithDependencies<PupilsFilter>(
    () => PupilsFilterImplementation(
      locator<PupilManager>(),
    ),
    dependsOn: [PupilManager, PupilFilterManager, SchooldayEventFilterManager],
  );
  locator.registerSingletonAsync<SchoolListManager>(() async {
    logger.i('Registering SchoolListManager');
    final schoolListManager = SchoolListManager();
    await schoolListManager.init();
    logger.i('SchoolListManager initialized');
    return schoolListManager;
  }, dependsOn: [SessionManager, ApiManager]);
  locator.registerSingletonWithDependencies<SchoolListFilterManager>(
    () => SchoolListFilterManager(),
    dependsOn: [SchoolListManager, PupilsFilter],
  );
  locator.registerSingletonWithDependencies<AttendanceManager>(
      () => AttendanceManager(),
      dependsOn: [SchooldayManager, PupilsFilter]);
  locator.registerSingletonWithDependencies<SchooldayEventManager>(
      () => SchooldayEventManager(),
      dependsOn: [SchooldayManager, PupilsFilter]);

  if (await secureStorageContains('matrix')) {
    await registerMatrixPolicyManager();
  }
}

Future<bool> registerMatrixPolicyManager() async {
  locator.registerSingletonAsync<MatrixPolicyManager>(() async {
    logger.i('Registering MatrixPolicyManager');
    final policyManager = MatrixPolicyManager();
    await policyManager.init();
    logger.i('MatrixPolicyManager initialized');
    locator<NotificationManager>().showSnackBar(
        NotificationType.success, 'Matrix-Räumeverwaltung initialisiert');
    return policyManager;
  }, dependsOn: [SessionManager, PupilManager]);

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
