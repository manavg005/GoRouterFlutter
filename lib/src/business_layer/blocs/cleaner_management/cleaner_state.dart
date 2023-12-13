part of 'cleaner_bloc.dart';

abstract class CleanerManagementState {
  const CleanerManagementState();
}

class CleanerManagementInitial extends CleanerManagementState {}

class CleanerManagementSuccessState extends CleanerManagementInitial {
  final CleanerManagementResponseModel cleanerManagementResponseModel;
  final bool hasMoreData;
  final int currentPage;

  CleanerManagementSuccessState(
      {required this.cleanerManagementResponseModel,
      required this.hasMoreData,
      required this.currentPage});
/*
  // Add copyWith method for convenient state modification
  CleanerManagementSuccessState copyWith({
    CleanerManagementResponseModel? cleanerManagementResponseModel,
    bool? hasMoreData,
    int? currentPage,
  }) {
    return CleanerManagementSuccessState(
      cleanerManagementResponseModel:
          cleanerManagementResponseModel ?? this.cleanerManagementResponseModel,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
    );
  }*/
}

class CleanerActiveInactiveState extends CleanerManagementInitial {}

class CleanerManagementLoadingState extends CleanerManagementInitial {}

class CleanerManagementErrorState extends CleanerManagementInitial {
  final String errorMessage;

  CleanerManagementErrorState({required this.errorMessage});
}
