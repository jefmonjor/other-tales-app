// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsListHash() => r'51a4921dd585610f65163d69dc6ed958ba1e5a51';

/// Re-export the repository provider from the data layer.
/// This allows the presentation layer to depend on the abstract interface.
///
/// Copied from [projectsList].
@ProviderFor(projectsList)
final projectsListProvider = AutoDisposeFutureProvider<List<Project>>.internal(
  projectsList,
  name: r'projectsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$projectsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProjectsListRef = AutoDisposeFutureProviderRef<List<Project>>;
String _$createProjectHash() => r'118d0c09809174c5ce81722e71d403ab03474be6';

/// Provider for creating a new project.
/// Returns the created project on success.
///
/// Copied from [CreateProject].
@ProviderFor(CreateProject)
final createProjectProvider =
    AutoDisposeAsyncNotifierProvider<CreateProject, Project?>.internal(
  CreateProject.new,
  name: r'createProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateProject = AutoDisposeAsyncNotifier<Project?>;
String _$updateProjectHash() => r'9e70158316af4746e0840b1110a034852ceed867';

/// Provider for updating an existing project.
/// Returns the updated project on success.
///
/// Copied from [UpdateProject].
@ProviderFor(UpdateProject)
final updateProjectProvider =
    AutoDisposeAsyncNotifierProvider<UpdateProject, Project?>.internal(
  UpdateProject.new,
  name: r'updateProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$updateProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateProject = AutoDisposeAsyncNotifier<Project?>;
String _$deleteProjectHash() => r'711ff33c5f22fe1345e31b79e3b3d27af8cc409d';

/// Provider for deleting a project.
///
/// Copied from [DeleteProject].
@ProviderFor(DeleteProject)
final deleteProjectProvider =
    AutoDisposeAsyncNotifierProvider<DeleteProject, void>.internal(
  DeleteProject.new,
  name: r'deleteProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteProject = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
