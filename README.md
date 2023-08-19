CrySto - Crypto + Stock market trading view app
* Base project: https://github.com/ntminhdn/Flutter-Bloc-CleanArchitecture
* Requirements
  Dart: 3.0.5
  Flutter SDK: 3.10.5
  Melos: 3.1.0
  CocoaPods: 1.12.0
* Tools/Libs
  melos: A tool for managing Dart & Flutter repositories with multiple packages (monorepo).
  ...
* Project Structure:
    1. App module: UI, BLoC, UI resources(Colors, Dimens, and Text Styles), main(), splash screen, app icon
      - app: AppBloc, global state(ex. localization, app theme, app mode, etc.)
      - base: base class(BasePageState, BaseBloc, BaseEvent, BaseState)
      - shared_view/common_view (scross-scope): reusable UIViews(popup, shimmer, app_bar, scaffold, etc.)
      - config:app config (Firebase.initializeApp(), )
      - di: di container of the app module
      - exception_handler: take care of all exceptions in the project.
      - helper: contains Helper classes used exclusively for the app module
      - navigation: app navigation
      - resource: UI resources (Colors, Dimens, and Text Styles)
      - ui: BLoC, UI/views
      - utils: utils functions used exclusively for the app module
    2. Domain module:
      - config: domain config
      - di: di container
      - entity: entity classes
      - navigation: AppNavigator(push, replace, and pop the screens)
      - repository: abstract repository classes/interface (aka contract)
      - usecase: use-case classes 
    3. Data
      - repository: repository implementation, converter, mapper, model, source
      - di
      - config
      - graphql
    4. Resources: This is a simple module, it only contains .arb files which provide Strings for localization. This module is injected into two other modules,app and domain so the UI, Bloc, Entity, and Use Case classes can use.
    5. Shared: this module provides constants, custom exception classes, helper classes, mixins, and utils functions for other modules to use.
    6. Initializer: This module only contains the AppInitializer class. This class is responsible for gathering all configs from other modules into aninit()function; The main() function only has to call this init() function to retrieve all configs from all modules.
    7. Other folders and files
       - The folder .github is for configuring CI/CD if your project uses Github Actions.
       - The folder .lefthook and file lefthook.yml are for configuring Git convention using the lefthook library.
       - The folder .vscode is for declaring VSCode settings used for this project.
       - The folder .env is for declaring secrets for each environment.
       - The folder tools contains tools I’ve created.
       - The file analysis_options.yaml is for declaring linter rules of two libraries flutter_lints and dart_code_metrics.
       - The file bitbucket-pipelines.yml is for configuring CI if your project uses Bitbucket Pipelines.
       - The file makefile keeps track of all commands used in the project. For example, the command make format helps format all the code with .dart file extension within the project. There are many more commands like make test which runs Unit Test on all modules.
       - The file melos.yaml is for configuring Melos.
