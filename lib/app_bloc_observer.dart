import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/// Bloc observer is a centralized class for the methods
/// which helps use detect the changes, creation, transition
/// in bloc objects
///
///this observer needs to be registered in main.dart
class AppBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    /// it gets invoked whenever a new bloc is created
    super.onCreate(bloc);
    debugPrint('Bloc name: ${bloc.toString()} state: ${bloc.state}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    /// tells us about the state changes (from->to)
    /// the difference between this method and the one defined
    /// in the bloc class it the it has one more argument 'bloc'
    /// which tells us that the state change happens with bloc
    super.onChange(bloc, change);
    debugPrint('$bloc change-$change');
  }

}