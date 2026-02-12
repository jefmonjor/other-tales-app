// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storyRepositoryHash() => r'02406ad1216df556a21f6ce8ab1cc3e1ee9fb162';

/// See also [storyRepository].
@ProviderFor(storyRepository)
final storyRepositoryProvider = AutoDisposeProvider<StoryRepository>.internal(
  storyRepository,
  name: r'storyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StoryRepositoryRef = AutoDisposeProviderRef<StoryRepository>;
String _$storiesHash() => r'f3bb3df9b5326bd216ea5df12e744b1900ac329b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Stories
    extends BuildlessAutoDisposeAsyncNotifier<List<Story>> {
  late final String projectId;

  FutureOr<List<Story>> build(
    String projectId,
  );
}

/// See also [Stories].
@ProviderFor(Stories)
const storiesProvider = StoriesFamily();

/// See also [Stories].
class StoriesFamily extends Family<AsyncValue<List<Story>>> {
  /// See also [Stories].
  const StoriesFamily();

  /// See also [Stories].
  StoriesProvider call(
    String projectId,
  ) {
    return StoriesProvider(
      projectId,
    );
  }

  @override
  StoriesProvider getProviderOverride(
    covariant StoriesProvider provider,
  ) {
    return call(
      provider.projectId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'storiesProvider';
}

/// See also [Stories].
class StoriesProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Stories, List<Story>> {
  /// See also [Stories].
  StoriesProvider(
    String projectId,
  ) : this._internal(
          () => Stories()..projectId = projectId,
          from: storiesProvider,
          name: r'storiesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$storiesHash,
          dependencies: StoriesFamily._dependencies,
          allTransitiveDependencies: StoriesFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  StoriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.projectId,
  }) : super.internal();

  final String projectId;

  @override
  FutureOr<List<Story>> runNotifierBuild(
    covariant Stories notifier,
  ) {
    return notifier.build(
      projectId,
    );
  }

  @override
  Override overrideWith(Stories Function() create) {
    return ProviderOverride(
      origin: this,
      override: StoriesProvider._internal(
        () => create()..projectId = projectId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        projectId: projectId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Stories, List<Story>>
      createElement() {
    return _StoriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoriesProvider && other.projectId == projectId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, projectId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StoriesRef on AutoDisposeAsyncNotifierProviderRef<List<Story>> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _StoriesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Stories, List<Story>>
    with StoriesRef {
  _StoriesProviderElement(super.provider);

  @override
  String get projectId => (origin as StoriesProvider).projectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
