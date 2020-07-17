import 'package:flutter/foundation.dart';
import '../models/sections_page_model.dart';

@immutable
abstract class SectionsState {}

class SectionsLoading extends SectionsState {
  @override
  String toString() => 'SectionsLoading';
}

class SectionLoaded extends SectionsState {
  final SectionsPageModel sectionsPage;

  SectionLoaded(this.sectionsPage);

  @override
  String toString() => 'SectionsLoaded{genres: $sectionsPage}';
}

class SectionsNotLoaded extends SectionsState {
  @override
  String toString() => 'SectionsNotLoaded';
}
