// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chaptersHash() => r'924fd6839d005cd4826479d4f4d342fb936aac6e';

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

/// See also [chapters].
@ProviderFor(chapters)
const chaptersProvider = ChaptersFamily();

/// See also [chapters].
class ChaptersFamily extends Family<AsyncValue<List<Chapter>>> {
  /// See also [chapters].
  const ChaptersFamily();

  /// See also [chapters].
  ChaptersProvider call(
    String projectId,
  ) {
    return ChaptersProvider(
      projectId,
    );
  }

  @override
  ChaptersProvider getProviderOverride(
    covariant ChaptersProvider provider,
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
  String? get name => r'chaptersProvider';
}

/// See also [chapters].
class ChaptersProvider extends AutoDisposeFutureProvider<List<Chapter>> {
  /// See also [chapters].
  ChaptersProvider(
    String projectId,
  ) : this._internal(
          (ref) => chapters(
            ref as ChaptersRef,
            projectId,
          ),
          from: chaptersProvider,
          name: r'chaptersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chaptersHash,
          dependencies: ChaptersFamily._dependencies,
          allTransitiveDependencies: ChaptersFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  ChaptersProvider._internal(
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
  Override overrideWith(
    FutureOr<List<Chapter>> Function(ChaptersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChaptersProvider._internal(
        (ref) => create(ref as ChaptersRef),
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
  AutoDisposeFutureProviderElement<List<Chapter>> createElement() {
    return _ChaptersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChaptersProvider && other.projectId == projectId;
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
mixin ChaptersRef on AutoDisposeFutureProviderRef<List<Chapter>> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _ChaptersProviderElement
    extends AutoDisposeFutureProviderElement<List<Chapter>> with ChaptersRef {
  _ChaptersProviderElement(super.provider);

  @override
  String get projectId => (origin as ChaptersProvider).projectId;
}

String _$chapterControllerHash() => r'ade2a53ca09adf08c2c4831aa03d09da848169f3';

/// See also [ChapterController].
@ProviderFor(ChapterController)
final chapterControllerProvider = AutoDisposeNotifierProvider<ChapterController,
    AsyncValue<Chapter?>>.internal(
  ChapterController.new,
  name: r'chapterControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chapterControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChapterController = AutoDisposeNotifier<AsyncValue<Chapter?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
