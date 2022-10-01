# Flutter clean architecture sample

 - Clean architecture with SOLID principals
 - Developed under test driven development
 - Blocs has been used for state management

# File Structure

```bash
 lib
 ├── core
 │   ├── error
 │   │   ├── exceptions.dart
 │   │   └── failures.dart
 │   ├── network
 │   │   ├── network_info.dart
 │   │   ├── rest_client_service.chopper.dart
 │   │   └── rest_client_service.dart
 │   ├── usecases
 │   │   └── usecase.dart
 │   ├── utils
 │   │   ├── constants.dart
 │   │   ├── router.dart
 │   │   └── theme.dart
 │   └── widgets
 │       └── custom_snak_bar.dart
 ├── injection_container.dart
 ├── main.dart
 └── screens
     └── news
         ├── data
         │   ├── datasources
         │   │   ├── news_local_datasource.dart
         │   │   └── news_remote_datasource.dart
         │   ├── models
         │   │   ├── get_news_response_model.dart
         │   └── repositories
         │       └── get_news_repository_impl.dart
         ├── domain
         │   ├── entities
         │   │   └── get_news_response.dart
         │   ├── repositories
         │   │   └── get_news_repository.dart
         │   └── usecases
         │       └── get_news_usecase.dart
         │       └── get_last_news_from_database_usecase.dart
         └── presentation
             ├── blocs
             │   └── user_login
             │       ├── bloc.dart
             │       ├── news_bloc.dart
             │       ├── news_event.dart
             │       └── news_state.dart
             └── page
                 └── news.dart
```