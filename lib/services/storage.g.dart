// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StorageProvider on _StorageProvider, Store {
  late final _$arrangedChannelListAtom =
      Atom(name: '_StorageProvider.arrangedChannelList', context: context);

  @override
  List<Channel> get arrangedChannelList {
    _$arrangedChannelListAtom.reportRead();
    return super.arrangedChannelList;
  }

  @override
  set arrangedChannelList(List<Channel> value) {
    _$arrangedChannelListAtom.reportWrite(value, super.arrangedChannelList, () {
      super.arrangedChannelList = value;
    });
  }

  late final _$favoritedChannelsAtom =
      Atom(name: '_StorageProvider.favoritedChannels', context: context);

  @override
  List<String> get favoritedChannels {
    _$favoritedChannelsAtom.reportRead();
    return super.favoritedChannels;
  }

  @override
  set favoritedChannels(List<String> value) {
    _$favoritedChannelsAtom.reportWrite(value, super.favoritedChannels, () {
      super.favoritedChannels = value;
    });
  }

  late final _$initializeAsyncAction =
      AsyncAction('_StorageProvider.initialize', context: context);

  @override
  Future initialize() {
    return _$initializeAsyncAction.run(() => super.initialize());
  }

  late final _$saveChangesAsyncAction =
      AsyncAction('_StorageProvider.saveChanges', context: context);

  @override
  Future saveChanges() {
    return _$saveChangesAsyncAction.run(() => super.saveChanges());
  }

  late final _$_StorageProviderActionController =
      ActionController(name: '_StorageProvider', context: context);

  @override
  dynamic initializeFavorites() {
    final _$actionInfo = _$_StorageProviderActionController.startAction(
        name: '_StorageProvider.initializeFavorites');
    try {
      return super.initializeFavorites();
    } finally {
      _$_StorageProviderActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
arrangedChannelList: ${arrangedChannelList},
favoritedChannels: ${favoritedChannels}
    ''';
  }
}
