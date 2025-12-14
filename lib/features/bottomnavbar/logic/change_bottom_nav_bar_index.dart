import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nara/features/home/presentation/screen/home_screen.dart';
import 'package:nara/features/sessions/presentation/screen/sessions_screen.dart';
import 'package:nara/features/sources/presentation/screen/sources_screen.dart';
import '../../profile/presentation/screen/profile_screen.dart';

class ChangeBottomNavBarIndex extends Cubit<int> {
  ChangeBottomNavBarIndex() : super(0);
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SessionsScreen(),
    const SourcesScreen(),
  ];
  void changeIndex(int index) {
    emit(index);
  }
}
