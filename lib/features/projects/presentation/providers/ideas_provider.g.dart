// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ideas_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ideaRepositoryHash() => r'4e15553df3f6e4b8c25133d737726353f0dcd1d5';

/// See also [ideaRepository].
@ProviderFor(ideaRepository)
final ideaRepositoryProvider = AutoDisposeProvider<IdeaRepository>.internal(
  ideaRepository,
  name: r'ideaRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ideaRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IdeaRepositoryRef = AutoDisposeProviderRef<IdeaRepository>;
String _$ideasHash() => r'6c38e04c9f0cabe4b1b2f952e552cccea329b9e9';

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

abstract class _$Ideas extends BuildlessAutoDisposeAsyncNotifier<List<Idea>> {
  late final String projectId;

  FutureOr<List<Idea>> build(
    String projectId,
  );
}

/// See also [Ideas].
@ProviderFor(Ideas)
const ideasProvider = IdeasFamily();

/// See also [Ideas].
class IdeasFamily extends Family<AsyncValue<List<Idea>>> {
  /// See also [Ideas].
  const IdeasFamily();

  /// See also [Ideas].
  IdeasProvider call(
    String projectId,
  ) {
    return IdeasProvider(
      projectId,
    );
  }

  @override
  IdeasProvider getProviderOverride(
    covariant IdeasProvider provider,
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
  String? get name => r'ideasProvider';
}

/// See also [Ideas].
class IdeasProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Ideas, List<Idea>> {
  /// See also [Ideas].
  IdeasProvider(
    String projectId,
  ) : this._internal(
          () => Ideas()..projectId = projectId,
          from: ideasProvider,
          name: r'ideasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ideasHash,
          dependencies: IdeasFamily._dependencies,
          allTransitiveDependencies: IdeasFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  IdeasProvider._internal(
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
  FutureOr<List<Idea>> runNotifierBuild(
    covariant Ideas notifier,
  ) {
    return notifier.build(
      projectId,
    );
  }

  @override
  Override overrideWith(Ideas Function() create) {
    return ProviderOverride(
      origin: this,
      override: IdeasProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Ideas, List<Idea>> createElement() {
    return _IdeasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IdeasProvider && other.projectId == projectId;
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
mixin IdeasRef on AutoDisposeAsyncNotifierProviderRef<List<Idea>> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _IdeasProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Ideas, List<Idea>>
    with IdeasRef {
  _IdeasProviderElement(super.provider);

  @override
  String get projectId => (origin as IdeasProvider).projectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
