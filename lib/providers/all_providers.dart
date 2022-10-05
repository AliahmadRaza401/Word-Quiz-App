import 'package:provider/provider.dart';
import 'package:qapp/providers/home_provider.dart';
import 'package:qapp/providers/loading_provider.dart';

var allProvider = [
  ChangeNotifierProvider<LoadingProvider>(
    create: (_) => LoadingProvider(),
    lazy: true,
  ),
    ChangeNotifierProvider<HomeProvider>(
    create: (_) => HomeProvider(),
    lazy: true,
  ),
];