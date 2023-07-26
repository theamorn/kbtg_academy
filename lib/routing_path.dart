enum RoutePath { home, listView, details }

extension RoutePathExtension on RoutePath {
  String get path {
    switch (this) {
      case RoutePath.home:
        return '/';
      case RoutePath.listView:
        return '/listview-page';
      case RoutePath.details:
        return '/listview-details';
      default:
        return '/';
    }
  }
}
