// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$characterRepositoryHash() =>
    r'6dc3837850fff6f6c36b9f3118e1251569128211';

/// See also [characterRepository].
@ProviderFor(characterRepository)
final characterRepositoryProvider =
    AutoDisposeProvider<CharacterRepository>.internal(
  characterRepository,
  name: r'characterRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$characterRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CharacterRepositoryRef = AutoDisposeProviderRef<CharacterRepository>;
String _$charactersHash() => r'3f5bf10d530c67b71fbcebb46728c4d89dca7190';

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

abstract class _$Characters
    extends BuildlessAutoDisposeAsyncNotifier<List<Character>> {
  late final String projectId;

  FutureOr<List<Character>> build(
    String projectId,
  );
}

/// See also [Characters].
@ProviderFor(Characters)
const charactersProvider = CharactersFamily();

/// See also [Characters].
class CharactersFamily extends Family<AsyncValue<List<Character>>> {
  /// See also [Characters].
  const CharactersFamily();

  /// See also [Characters].
  CharactersProvider call(
    String projectId,
  ) {
    return CharactersProvider(
      projectId,
    );
  }

  @override
  CharactersProvider getProviderOverride(
    covariant CharactersProvider provider,
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
  String? get name => r'charactersProvider';
}

/// See also [Characters].
class CharactersProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Characters, List<Character>> {
  /// See also [Characters].
  CharactersProvider(
    String projectId,
  ) : this._internal(
          () => Characters()..projectId = projectId,
          from: charactersProvider,
          name: r'charactersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$charactersHash,
          dependencies: CharactersFamily._dependencies,
          allTransitiveDependencies:
              CharactersFamily._allTransitiveDependencies,
          projectId: projectId,
        );

  CharactersProvider._internal(
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
  FutureOr<List<Character>> runNotifierBuild(
    covariant Characters notifier,
  ) {
    return notifier.build(
      projectId,
    );
  }

  @override
  Override overrideWith(Characters Function() create) {
    return ProviderOverride(
      origin: this,
      override: CharactersProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<Characters, List<Character>>
      createElement() {
    return _CharactersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CharactersProvider && other.projectId == projectId;
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
mixin CharactersRef on AutoDisposeAsyncNotifierProviderRef<List<Character>> {
  /// The parameter `projectId` of this provider.
  String get projectId;
}

class _CharactersProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<Characters, List<Character>>
    with CharactersRef {
  _CharactersProviderElement(super.provider);

  @override
  String get projectId => (origin as CharactersProvider).projectId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
