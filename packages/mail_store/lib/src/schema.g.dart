// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts with TableInfo<$AccountsTable, AccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, email, displayName, json, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<AccountRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(_displayNameMeta, displayName.isAcceptableOrUnknown(data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('json')) {
      context.handle(_jsonMeta, json.isAcceptableOrUnknown(data['json']!, _jsonMeta));
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      displayName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      json: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}json'])!,
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountRow extends DataClass implements Insertable<AccountRow> {
  final String id;
  final String email;
  final String displayName;
  final String json;
  final int sortOrder;
  const AccountRow({
    required this.id,
    required this.email,
    required this.displayName,
    required this.json,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['display_name'] = Variable<String>(displayName);
    map['json'] = Variable<String>(json);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      email: Value(email),
      displayName: Value(displayName),
      json: Value(json),
      sortOrder: Value(sortOrder),
    );
  }

  factory AccountRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountRow(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      displayName: serializer.fromJson<String>(json['displayName']),
      json: serializer.fromJson<String>(json['json']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'displayName': serializer.toJson<String>(displayName),
      'json': serializer.toJson<String>(json),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  AccountRow copyWith({String? id, String? email, String? displayName, String? json, int? sortOrder}) => AccountRow(
    id: id ?? this.id,
    email: email ?? this.email,
    displayName: displayName ?? this.displayName,
    json: json ?? this.json,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  AccountRow copyWithCompanion(AccountsCompanion data) {
    return AccountRow(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      displayName: data.displayName.present ? data.displayName.value : this.displayName,
      json: data.json.present ? data.json.value : this.json,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountRow(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('json: $json, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, displayName, json, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountRow &&
          other.id == this.id &&
          other.email == this.email &&
          other.displayName == this.displayName &&
          other.json == this.json &&
          other.sortOrder == this.sortOrder);
}

class AccountsCompanion extends UpdateCompanion<AccountRow> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> displayName;
  final Value<String> json;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.displayName = const Value.absent(),
    this.json = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String email,
    required String displayName,
    required String json,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       displayName = Value(displayName),
       json = Value(json);
  static Insertable<AccountRow> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? displayName,
    Expression<String>? json,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (displayName != null) 'display_name': displayName,
      if (json != null) 'json': json,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? displayName,
    Value<String>? json,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      json: json ?? this.json,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('displayName: $displayName, ')
          ..write('json: $json, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MailboxesTable extends Mailboxes with TableInfo<$MailboxesTable, MailboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MailboxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES accounts (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta('unreadCount');
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta('totalCount');
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSelectableMeta = const VerificationMeta('isSelectable');
  @override
  late final GeneratedColumn<bool> isSelectable = GeneratedColumn<bool>(
    'is_selectable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_selectable" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isSubscribedMeta = const VerificationMeta('isSubscribed');
  @override
  late final GeneratedColumn<bool> isSubscribed = GeneratedColumn<bool>(
    'is_subscribed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_subscribed" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    name,
    path,
    role,
    parentId,
    unreadCount,
    totalCount,
    isSelectable,
    isSubscribed,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mailboxes';
  @override
  VerificationContext validateIntegrity(Insertable<MailboxRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(_pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('role')) {
      context.handle(_roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta, parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('unread_count')) {
      context.handle(_unreadCountMeta, unreadCount.isAcceptableOrUnknown(data['unread_count']!, _unreadCountMeta));
    }
    if (data.containsKey('total_count')) {
      context.handle(_totalCountMeta, totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta));
    }
    if (data.containsKey('is_selectable')) {
      context.handle(_isSelectableMeta, isSelectable.isAcceptableOrUnknown(data['is_selectable']!, _isSelectableMeta));
    }
    if (data.containsKey('is_subscribed')) {
      context.handle(_isSubscribedMeta, isSubscribed.isAcceptableOrUnknown(data['is_subscribed']!, _isSubscribedMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MailboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MailboxRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      role: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      parentId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      unreadCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unread_count'])!,
      totalCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total_count'])!,
      isSelectable: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_selectable'])!,
      isSubscribed: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_subscribed'])!,
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $MailboxesTable createAlias(String alias) {
    return $MailboxesTable(attachedDatabase, alias);
  }
}

class MailboxRow extends DataClass implements Insertable<MailboxRow> {
  final String id;
  final String accountId;
  final String name;
  final String path;

  /// `MailboxRole.name`.
  final String role;
  final String? parentId;
  final int unreadCount;
  final int totalCount;
  final bool isSelectable;
  final bool isSubscribed;
  final int sortOrder;
  const MailboxRow({
    required this.id,
    required this.accountId,
    required this.name,
    required this.path,
    required this.role,
    this.parentId,
    required this.unreadCount,
    required this.totalCount,
    required this.isSelectable,
    required this.isSubscribed,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['total_count'] = Variable<int>(totalCount);
    map['is_selectable'] = Variable<bool>(isSelectable);
    map['is_subscribed'] = Variable<bool>(isSubscribed);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  MailboxesCompanion toCompanion(bool nullToAbsent) {
    return MailboxesCompanion(
      id: Value(id),
      accountId: Value(accountId),
      name: Value(name),
      path: Value(path),
      role: Value(role),
      parentId: parentId == null && nullToAbsent ? const Value.absent() : Value(parentId),
      unreadCount: Value(unreadCount),
      totalCount: Value(totalCount),
      isSelectable: Value(isSelectable),
      isSubscribed: Value(isSubscribed),
      sortOrder: Value(sortOrder),
    );
  }

  factory MailboxRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MailboxRow(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      role: serializer.fromJson<String>(json['role']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      isSelectable: serializer.fromJson<bool>(json['isSelectable']),
      isSubscribed: serializer.fromJson<bool>(json['isSubscribed']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'role': serializer.toJson<String>(role),
      'parentId': serializer.toJson<String?>(parentId),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'totalCount': serializer.toJson<int>(totalCount),
      'isSelectable': serializer.toJson<bool>(isSelectable),
      'isSubscribed': serializer.toJson<bool>(isSubscribed),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  MailboxRow copyWith({
    String? id,
    String? accountId,
    String? name,
    String? path,
    String? role,
    Value<String?> parentId = const Value.absent(),
    int? unreadCount,
    int? totalCount,
    bool? isSelectable,
    bool? isSubscribed,
    int? sortOrder,
  }) => MailboxRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    name: name ?? this.name,
    path: path ?? this.path,
    role: role ?? this.role,
    parentId: parentId.present ? parentId.value : this.parentId,
    unreadCount: unreadCount ?? this.unreadCount,
    totalCount: totalCount ?? this.totalCount,
    isSelectable: isSelectable ?? this.isSelectable,
    isSubscribed: isSubscribed ?? this.isSubscribed,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  MailboxRow copyWithCompanion(MailboxesCompanion data) {
    return MailboxRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
      role: data.role.present ? data.role.value : this.role,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      unreadCount: data.unreadCount.present ? data.unreadCount.value : this.unreadCount,
      totalCount: data.totalCount.present ? data.totalCount.value : this.totalCount,
      isSelectable: data.isSelectable.present ? data.isSelectable.value : this.isSelectable,
      isSubscribed: data.isSubscribed.present ? data.isSubscribed.value : this.isSubscribed,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MailboxRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('role: $role, ')
          ..write('parentId: $parentId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    name,
    path,
    role,
    parentId,
    unreadCount,
    totalCount,
    isSelectable,
    isSubscribed,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MailboxRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.name == this.name &&
          other.path == this.path &&
          other.role == this.role &&
          other.parentId == this.parentId &&
          other.unreadCount == this.unreadCount &&
          other.totalCount == this.totalCount &&
          other.isSelectable == this.isSelectable &&
          other.isSubscribed == this.isSubscribed &&
          other.sortOrder == this.sortOrder);
}

class MailboxesCompanion extends UpdateCompanion<MailboxRow> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> name;
  final Value<String> path;
  final Value<String> role;
  final Value<String?> parentId;
  final Value<int> unreadCount;
  final Value<int> totalCount;
  final Value<bool> isSelectable;
  final Value<bool> isSubscribed;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const MailboxesCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.role = const Value.absent(),
    this.parentId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.isSelectable = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MailboxesCompanion.insert({
    required String id,
    required String accountId,
    required String name,
    required String path,
    required String role,
    this.parentId = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.isSelectable = const Value.absent(),
    this.isSubscribed = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       name = Value(name),
       path = Value(path),
       role = Value(role);
  static Insertable<MailboxRow> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? name,
    Expression<String>? path,
    Expression<String>? role,
    Expression<String>? parentId,
    Expression<int>? unreadCount,
    Expression<int>? totalCount,
    Expression<bool>? isSelectable,
    Expression<bool>? isSubscribed,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (role != null) 'role': role,
      if (parentId != null) 'parent_id': parentId,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (totalCount != null) 'total_count': totalCount,
      if (isSelectable != null) 'is_selectable': isSelectable,
      if (isSubscribed != null) 'is_subscribed': isSubscribed,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MailboxesCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? name,
    Value<String>? path,
    Value<String>? role,
    Value<String?>? parentId,
    Value<int>? unreadCount,
    Value<int>? totalCount,
    Value<bool>? isSelectable,
    Value<bool>? isSubscribed,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return MailboxesCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      path: path ?? this.path,
      role: role ?? this.role,
      parentId: parentId ?? this.parentId,
      unreadCount: unreadCount ?? this.unreadCount,
      totalCount: totalCount ?? this.totalCount,
      isSelectable: isSelectable ?? this.isSelectable,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (isSelectable.present) {
      map['is_selectable'] = Variable<bool>(isSelectable.value);
    }
    if (isSubscribed.present) {
      map['is_subscribed'] = Variable<bool>(isSubscribed.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MailboxesCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('role: $role, ')
          ..write('parentId: $parentId, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('isSelectable: $isSelectable, ')
          ..write('isSubscribed: $isSubscribed, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatesTable extends SyncStates with TableInfo<$SyncStatesTable, SyncStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta('mailboxId');
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES mailboxes (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasOlderMeta = const VerificationMeta('hasOlder');
  @override
  late final GeneratedColumn<bool> hasOlder = GeneratedColumn<bool>(
    'has_older',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("has_older" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<int> syncedAt = GeneratedColumn<int>(
    'synced_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [mailboxId, state, hasOlder, syncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_states';
  @override
  VerificationContext validateIntegrity(Insertable<SyncStateRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mailbox_id')) {
      context.handle(_mailboxIdMeta, mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta));
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(_stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('has_older')) {
      context.handle(_hasOlderMeta, hasOlder.isAcceptableOrUnknown(data['has_older']!, _hasOlderMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta, syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mailboxId};
  @override
  SyncStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncStateRow(
      mailboxId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}mailbox_id'])!,
      state: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      hasOlder: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}has_older'])!,
      syncedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}synced_at'])!,
    );
  }

  @override
  $SyncStatesTable createAlias(String alias) {
    return $SyncStatesTable(attachedDatabase, alias);
  }
}

class SyncStateRow extends DataClass implements Insertable<SyncStateRow> {
  final String mailboxId;
  final String state;
  final bool hasOlder;
  final int syncedAt;
  const SyncStateRow({required this.mailboxId, required this.state, required this.hasOlder, required this.syncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['state'] = Variable<String>(state);
    map['has_older'] = Variable<bool>(hasOlder);
    map['synced_at'] = Variable<int>(syncedAt);
    return map;
  }

  SyncStatesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatesCompanion(
      mailboxId: Value(mailboxId),
      state: Value(state),
      hasOlder: Value(hasOlder),
      syncedAt: Value(syncedAt),
    );
  }

  factory SyncStateRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncStateRow(
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      state: serializer.fromJson<String>(json['state']),
      hasOlder: serializer.fromJson<bool>(json['hasOlder']),
      syncedAt: serializer.fromJson<int>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mailboxId': serializer.toJson<String>(mailboxId),
      'state': serializer.toJson<String>(state),
      'hasOlder': serializer.toJson<bool>(hasOlder),
      'syncedAt': serializer.toJson<int>(syncedAt),
    };
  }

  SyncStateRow copyWith({String? mailboxId, String? state, bool? hasOlder, int? syncedAt}) => SyncStateRow(
    mailboxId: mailboxId ?? this.mailboxId,
    state: state ?? this.state,
    hasOlder: hasOlder ?? this.hasOlder,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  SyncStateRow copyWithCompanion(SyncStatesCompanion data) {
    return SyncStateRow(
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      state: data.state.present ? data.state.value : this.state,
      hasOlder: data.hasOlder.present ? data.hasOlder.value : this.hasOlder,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncStateRow(')
          ..write('mailboxId: $mailboxId, ')
          ..write('state: $state, ')
          ..write('hasOlder: $hasOlder, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mailboxId, state, hasOlder, syncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncStateRow &&
          other.mailboxId == this.mailboxId &&
          other.state == this.state &&
          other.hasOlder == this.hasOlder &&
          other.syncedAt == this.syncedAt);
}

class SyncStatesCompanion extends UpdateCompanion<SyncStateRow> {
  final Value<String> mailboxId;
  final Value<String> state;
  final Value<bool> hasOlder;
  final Value<int> syncedAt;
  final Value<int> rowid;
  const SyncStatesCompanion({
    this.mailboxId = const Value.absent(),
    this.state = const Value.absent(),
    this.hasOlder = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatesCompanion.insert({
    required String mailboxId,
    required String state,
    this.hasOlder = const Value.absent(),
    required int syncedAt,
    this.rowid = const Value.absent(),
  }) : mailboxId = Value(mailboxId),
       state = Value(state),
       syncedAt = Value(syncedAt);
  static Insertable<SyncStateRow> custom({
    Expression<String>? mailboxId,
    Expression<String>? state,
    Expression<bool>? hasOlder,
    Expression<int>? syncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (state != null) 'state': state,
      if (hasOlder != null) 'has_older': hasOlder,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatesCompanion copyWith({
    Value<String>? mailboxId,
    Value<String>? state,
    Value<bool>? hasOlder,
    Value<int>? syncedAt,
    Value<int>? rowid,
  }) {
    return SyncStatesCompanion(
      mailboxId: mailboxId ?? this.mailboxId,
      state: state ?? this.state,
      hasOlder: hasOlder ?? this.hasOlder,
      syncedAt: syncedAt ?? this.syncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (hasOlder.present) {
      map['has_older'] = Variable<bool>(hasOlder.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<int>(syncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatesCompanion(')
          ..write('mailboxId: $mailboxId, ')
          ..write('state: $state, ')
          ..write('hasOlder: $hasOlder, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmailsTable extends Emails with TableInfo<$EmailsTable, EmailRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta('mailboxId');
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES mailboxes (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta('threadId');
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageIdHeaderMeta = const VerificationMeta('messageIdHeader');
  @override
  late final GeneratedColumn<String> messageIdHeader = GeneratedColumn<String>(
    'message_id_header',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inReplyToMeta = const VerificationMeta('inReplyTo');
  @override
  late final GeneratedColumn<String> inReplyTo = GeneratedColumn<String>(
    'in_reply_to',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referencesJsonMeta = const VerificationMeta('referencesJson');
  @override
  late final GeneratedColumn<String> referencesJson = GeneratedColumn<String>(
    'references_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _fromAddrsMeta = const VerificationMeta('fromAddrs');
  @override
  late final GeneratedColumn<String> fromAddrs = GeneratedColumn<String>(
    'from_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _toAddrsMeta = const VerificationMeta('toAddrs');
  @override
  late final GeneratedColumn<String> toAddrs = GeneratedColumn<String>(
    'to_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _ccAddrsMeta = const VerificationMeta('ccAddrs');
  @override
  late final GeneratedColumn<String> ccAddrs = GeneratedColumn<String>(
    'cc_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _bccAddrsMeta = const VerificationMeta('bccAddrs');
  @override
  late final GeneratedColumn<String> bccAddrs = GeneratedColumn<String>(
    'bcc_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _replyToAddrsMeta = const VerificationMeta('replyToAddrs');
  @override
  late final GeneratedColumn<String> replyToAddrs = GeneratedColumn<String>(
    'reply_to_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _fromEmailMeta = const VerificationMeta('fromEmail');
  @override
  late final GeneratedColumn<String> fromEmail = GeneratedColumn<String>(
    'from_email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _baseSubjectMeta = const VerificationMeta('baseSubject');
  @override
  late final GeneratedColumn<String> baseSubject = GeneratedColumn<String>(
    'base_subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _previewMeta = const VerificationMeta('preview');
  @override
  late final GeneratedColumn<String> preview = GeneratedColumn<String>(
    'preview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta('receivedAt');
  @override
  late final GeneratedColumn<int> receivedAt = GeneratedColumn<int>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<int> sentAt = GeneratedColumn<int>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _keywordsMeta = const VerificationMeta('keywords');
  @override
  late final GeneratedColumn<String> keywords = GeneratedColumn<String>(
    'keywords',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _isSeenMeta = const VerificationMeta('isSeen');
  @override
  late final GeneratedColumn<bool> isSeen = GeneratedColumn<bool>(
    'is_seen',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_seen" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFlaggedMeta = const VerificationMeta('isFlagged');
  @override
  late final GeneratedColumn<bool> isFlagged = GeneratedColumn<bool>(
    'is_flagged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_flagged" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasAttachmentMeta = const VerificationMeta('hasAttachment');
  @override
  late final GeneratedColumn<bool> hasAttachment = GeneratedColumn<bool>(
    'has_attachment',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("has_attachment" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    seq,
    id,
    accountId,
    mailboxId,
    threadId,
    messageIdHeader,
    inReplyTo,
    referencesJson,
    fromAddrs,
    toAddrs,
    ccAddrs,
    bccAddrs,
    replyToAddrs,
    fromEmail,
    subject,
    baseSubject,
    preview,
    receivedAt,
    sentAt,
    size,
    keywords,
    isSeen,
    isFlagged,
    hasAttachment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emails';
  @override
  VerificationContext validateIntegrity(Insertable<EmailRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('seq')) {
      context.handle(_seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('mailbox_id')) {
      context.handle(_mailboxIdMeta, mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta));
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(_threadIdMeta, threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta));
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    if (data.containsKey('message_id_header')) {
      context.handle(
        _messageIdHeaderMeta,
        messageIdHeader.isAcceptableOrUnknown(data['message_id_header']!, _messageIdHeaderMeta),
      );
    }
    if (data.containsKey('in_reply_to')) {
      context.handle(_inReplyToMeta, inReplyTo.isAcceptableOrUnknown(data['in_reply_to']!, _inReplyToMeta));
    }
    if (data.containsKey('references_json')) {
      context.handle(
        _referencesJsonMeta,
        referencesJson.isAcceptableOrUnknown(data['references_json']!, _referencesJsonMeta),
      );
    }
    if (data.containsKey('from_json')) {
      context.handle(_fromAddrsMeta, fromAddrs.isAcceptableOrUnknown(data['from_json']!, _fromAddrsMeta));
    }
    if (data.containsKey('to_json')) {
      context.handle(_toAddrsMeta, toAddrs.isAcceptableOrUnknown(data['to_json']!, _toAddrsMeta));
    }
    if (data.containsKey('cc_json')) {
      context.handle(_ccAddrsMeta, ccAddrs.isAcceptableOrUnknown(data['cc_json']!, _ccAddrsMeta));
    }
    if (data.containsKey('bcc_json')) {
      context.handle(_bccAddrsMeta, bccAddrs.isAcceptableOrUnknown(data['bcc_json']!, _bccAddrsMeta));
    }
    if (data.containsKey('reply_to_json')) {
      context.handle(_replyToAddrsMeta, replyToAddrs.isAcceptableOrUnknown(data['reply_to_json']!, _replyToAddrsMeta));
    }
    if (data.containsKey('from_email')) {
      context.handle(_fromEmailMeta, fromEmail.isAcceptableOrUnknown(data['from_email']!, _fromEmailMeta));
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta, subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    }
    if (data.containsKey('base_subject')) {
      context.handle(_baseSubjectMeta, baseSubject.isAcceptableOrUnknown(data['base_subject']!, _baseSubjectMeta));
    }
    if (data.containsKey('preview')) {
      context.handle(_previewMeta, preview.isAcceptableOrUnknown(data['preview']!, _previewMeta));
    }
    if (data.containsKey('received_at')) {
      context.handle(_receivedAtMeta, receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta));
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(_sentAtMeta, sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta));
    }
    if (data.containsKey('size')) {
      context.handle(_sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('keywords')) {
      context.handle(_keywordsMeta, keywords.isAcceptableOrUnknown(data['keywords']!, _keywordsMeta));
    }
    if (data.containsKey('is_seen')) {
      context.handle(_isSeenMeta, isSeen.isAcceptableOrUnknown(data['is_seen']!, _isSeenMeta));
    }
    if (data.containsKey('is_flagged')) {
      context.handle(_isFlaggedMeta, isFlagged.isAcceptableOrUnknown(data['is_flagged']!, _isFlaggedMeta));
    }
    if (data.containsKey('has_attachment')) {
      context.handle(
        _hasAttachmentMeta,
        hasAttachment.isAcceptableOrUnknown(data['has_attachment']!, _hasAttachmentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {seq};
  @override
  EmailRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailRow(
      seq: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}seq'])!,
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      mailboxId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}mailbox_id'])!,
      threadId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}thread_id'])!,
      messageIdHeader: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id_header'],
      ),
      inReplyTo: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}in_reply_to']),
      referencesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}references_json'],
      )!,
      fromAddrs: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}from_json'])!,
      toAddrs: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}to_json'])!,
      ccAddrs: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}cc_json'])!,
      bccAddrs: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}bcc_json'])!,
      replyToAddrs: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}reply_to_json'])!,
      fromEmail: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}from_email'])!,
      subject: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}subject'])!,
      baseSubject: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}base_subject'])!,
      preview: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}preview'])!,
      receivedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}received_at'])!,
      sentAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sent_at']),
      size: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}size'])!,
      keywords: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}keywords'])!,
      isSeen: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_seen'])!,
      isFlagged: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_flagged'])!,
      hasAttachment: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}has_attachment'])!,
    );
  }

  @override
  $EmailsTable createAlias(String alias) {
    return $EmailsTable(attachedDatabase, alias);
  }
}

class EmailRow extends DataClass implements Insertable<EmailRow> {
  final int seq;
  final String id;
  final String accountId;
  final String mailboxId;
  final String threadId;
  final String? messageIdHeader;
  final String? inReplyTo;
  final String referencesJson;
  final String fromAddrs;
  final String toAddrs;
  final String ccAddrs;
  final String bccAddrs;
  final String replyToAddrs;

  /// Lower-cased address of the first sender, for VIP and address filters.
  final String fromEmail;
  final String subject;

  /// Subject without reply/forward prefixes, lower-cased (threading fallback).
  final String baseSubject;
  final String preview;
  final int receivedAt;
  final int? sentAt;
  final int size;

  /// JSON array of lower-cased keywords; mirrored into [EmailKeywords] by triggers.
  final String keywords;
  final bool isSeen;
  final bool isFlagged;
  final bool hasAttachment;
  const EmailRow({
    required this.seq,
    required this.id,
    required this.accountId,
    required this.mailboxId,
    required this.threadId,
    this.messageIdHeader,
    this.inReplyTo,
    required this.referencesJson,
    required this.fromAddrs,
    required this.toAddrs,
    required this.ccAddrs,
    required this.bccAddrs,
    required this.replyToAddrs,
    required this.fromEmail,
    required this.subject,
    required this.baseSubject,
    required this.preview,
    required this.receivedAt,
    this.sentAt,
    required this.size,
    required this.keywords,
    required this.isSeen,
    required this.isFlagged,
    required this.hasAttachment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['seq'] = Variable<int>(seq);
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['thread_id'] = Variable<String>(threadId);
    if (!nullToAbsent || messageIdHeader != null) {
      map['message_id_header'] = Variable<String>(messageIdHeader);
    }
    if (!nullToAbsent || inReplyTo != null) {
      map['in_reply_to'] = Variable<String>(inReplyTo);
    }
    map['references_json'] = Variable<String>(referencesJson);
    map['from_json'] = Variable<String>(fromAddrs);
    map['to_json'] = Variable<String>(toAddrs);
    map['cc_json'] = Variable<String>(ccAddrs);
    map['bcc_json'] = Variable<String>(bccAddrs);
    map['reply_to_json'] = Variable<String>(replyToAddrs);
    map['from_email'] = Variable<String>(fromEmail);
    map['subject'] = Variable<String>(subject);
    map['base_subject'] = Variable<String>(baseSubject);
    map['preview'] = Variable<String>(preview);
    map['received_at'] = Variable<int>(receivedAt);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<int>(sentAt);
    }
    map['size'] = Variable<int>(size);
    map['keywords'] = Variable<String>(keywords);
    map['is_seen'] = Variable<bool>(isSeen);
    map['is_flagged'] = Variable<bool>(isFlagged);
    map['has_attachment'] = Variable<bool>(hasAttachment);
    return map;
  }

  EmailsCompanion toCompanion(bool nullToAbsent) {
    return EmailsCompanion(
      seq: Value(seq),
      id: Value(id),
      accountId: Value(accountId),
      mailboxId: Value(mailboxId),
      threadId: Value(threadId),
      messageIdHeader: messageIdHeader == null && nullToAbsent ? const Value.absent() : Value(messageIdHeader),
      inReplyTo: inReplyTo == null && nullToAbsent ? const Value.absent() : Value(inReplyTo),
      referencesJson: Value(referencesJson),
      fromAddrs: Value(fromAddrs),
      toAddrs: Value(toAddrs),
      ccAddrs: Value(ccAddrs),
      bccAddrs: Value(bccAddrs),
      replyToAddrs: Value(replyToAddrs),
      fromEmail: Value(fromEmail),
      subject: Value(subject),
      baseSubject: Value(baseSubject),
      preview: Value(preview),
      receivedAt: Value(receivedAt),
      sentAt: sentAt == null && nullToAbsent ? const Value.absent() : Value(sentAt),
      size: Value(size),
      keywords: Value(keywords),
      isSeen: Value(isSeen),
      isFlagged: Value(isFlagged),
      hasAttachment: Value(hasAttachment),
    );
  }

  factory EmailRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailRow(
      seq: serializer.fromJson<int>(json['seq']),
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      threadId: serializer.fromJson<String>(json['threadId']),
      messageIdHeader: serializer.fromJson<String?>(json['messageIdHeader']),
      inReplyTo: serializer.fromJson<String?>(json['inReplyTo']),
      referencesJson: serializer.fromJson<String>(json['referencesJson']),
      fromAddrs: serializer.fromJson<String>(json['fromAddrs']),
      toAddrs: serializer.fromJson<String>(json['toAddrs']),
      ccAddrs: serializer.fromJson<String>(json['ccAddrs']),
      bccAddrs: serializer.fromJson<String>(json['bccAddrs']),
      replyToAddrs: serializer.fromJson<String>(json['replyToAddrs']),
      fromEmail: serializer.fromJson<String>(json['fromEmail']),
      subject: serializer.fromJson<String>(json['subject']),
      baseSubject: serializer.fromJson<String>(json['baseSubject']),
      preview: serializer.fromJson<String>(json['preview']),
      receivedAt: serializer.fromJson<int>(json['receivedAt']),
      sentAt: serializer.fromJson<int?>(json['sentAt']),
      size: serializer.fromJson<int>(json['size']),
      keywords: serializer.fromJson<String>(json['keywords']),
      isSeen: serializer.fromJson<bool>(json['isSeen']),
      isFlagged: serializer.fromJson<bool>(json['isFlagged']),
      hasAttachment: serializer.fromJson<bool>(json['hasAttachment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'seq': serializer.toJson<int>(seq),
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'mailboxId': serializer.toJson<String>(mailboxId),
      'threadId': serializer.toJson<String>(threadId),
      'messageIdHeader': serializer.toJson<String?>(messageIdHeader),
      'inReplyTo': serializer.toJson<String?>(inReplyTo),
      'referencesJson': serializer.toJson<String>(referencesJson),
      'fromAddrs': serializer.toJson<String>(fromAddrs),
      'toAddrs': serializer.toJson<String>(toAddrs),
      'ccAddrs': serializer.toJson<String>(ccAddrs),
      'bccAddrs': serializer.toJson<String>(bccAddrs),
      'replyToAddrs': serializer.toJson<String>(replyToAddrs),
      'fromEmail': serializer.toJson<String>(fromEmail),
      'subject': serializer.toJson<String>(subject),
      'baseSubject': serializer.toJson<String>(baseSubject),
      'preview': serializer.toJson<String>(preview),
      'receivedAt': serializer.toJson<int>(receivedAt),
      'sentAt': serializer.toJson<int?>(sentAt),
      'size': serializer.toJson<int>(size),
      'keywords': serializer.toJson<String>(keywords),
      'isSeen': serializer.toJson<bool>(isSeen),
      'isFlagged': serializer.toJson<bool>(isFlagged),
      'hasAttachment': serializer.toJson<bool>(hasAttachment),
    };
  }

  EmailRow copyWith({
    int? seq,
    String? id,
    String? accountId,
    String? mailboxId,
    String? threadId,
    Value<String?> messageIdHeader = const Value.absent(),
    Value<String?> inReplyTo = const Value.absent(),
    String? referencesJson,
    String? fromAddrs,
    String? toAddrs,
    String? ccAddrs,
    String? bccAddrs,
    String? replyToAddrs,
    String? fromEmail,
    String? subject,
    String? baseSubject,
    String? preview,
    int? receivedAt,
    Value<int?> sentAt = const Value.absent(),
    int? size,
    String? keywords,
    bool? isSeen,
    bool? isFlagged,
    bool? hasAttachment,
  }) => EmailRow(
    seq: seq ?? this.seq,
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    mailboxId: mailboxId ?? this.mailboxId,
    threadId: threadId ?? this.threadId,
    messageIdHeader: messageIdHeader.present ? messageIdHeader.value : this.messageIdHeader,
    inReplyTo: inReplyTo.present ? inReplyTo.value : this.inReplyTo,
    referencesJson: referencesJson ?? this.referencesJson,
    fromAddrs: fromAddrs ?? this.fromAddrs,
    toAddrs: toAddrs ?? this.toAddrs,
    ccAddrs: ccAddrs ?? this.ccAddrs,
    bccAddrs: bccAddrs ?? this.bccAddrs,
    replyToAddrs: replyToAddrs ?? this.replyToAddrs,
    fromEmail: fromEmail ?? this.fromEmail,
    subject: subject ?? this.subject,
    baseSubject: baseSubject ?? this.baseSubject,
    preview: preview ?? this.preview,
    receivedAt: receivedAt ?? this.receivedAt,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    size: size ?? this.size,
    keywords: keywords ?? this.keywords,
    isSeen: isSeen ?? this.isSeen,
    isFlagged: isFlagged ?? this.isFlagged,
    hasAttachment: hasAttachment ?? this.hasAttachment,
  );
  EmailRow copyWithCompanion(EmailsCompanion data) {
    return EmailRow(
      seq: data.seq.present ? data.seq.value : this.seq,
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      messageIdHeader: data.messageIdHeader.present ? data.messageIdHeader.value : this.messageIdHeader,
      inReplyTo: data.inReplyTo.present ? data.inReplyTo.value : this.inReplyTo,
      referencesJson: data.referencesJson.present ? data.referencesJson.value : this.referencesJson,
      fromAddrs: data.fromAddrs.present ? data.fromAddrs.value : this.fromAddrs,
      toAddrs: data.toAddrs.present ? data.toAddrs.value : this.toAddrs,
      ccAddrs: data.ccAddrs.present ? data.ccAddrs.value : this.ccAddrs,
      bccAddrs: data.bccAddrs.present ? data.bccAddrs.value : this.bccAddrs,
      replyToAddrs: data.replyToAddrs.present ? data.replyToAddrs.value : this.replyToAddrs,
      fromEmail: data.fromEmail.present ? data.fromEmail.value : this.fromEmail,
      subject: data.subject.present ? data.subject.value : this.subject,
      baseSubject: data.baseSubject.present ? data.baseSubject.value : this.baseSubject,
      preview: data.preview.present ? data.preview.value : this.preview,
      receivedAt: data.receivedAt.present ? data.receivedAt.value : this.receivedAt,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      size: data.size.present ? data.size.value : this.size,
      keywords: data.keywords.present ? data.keywords.value : this.keywords,
      isSeen: data.isSeen.present ? data.isSeen.value : this.isSeen,
      isFlagged: data.isFlagged.present ? data.isFlagged.value : this.isFlagged,
      hasAttachment: data.hasAttachment.present ? data.hasAttachment.value : this.hasAttachment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailRow(')
          ..write('seq: $seq, ')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('threadId: $threadId, ')
          ..write('messageIdHeader: $messageIdHeader, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('referencesJson: $referencesJson, ')
          ..write('fromAddrs: $fromAddrs, ')
          ..write('toAddrs: $toAddrs, ')
          ..write('ccAddrs: $ccAddrs, ')
          ..write('bccAddrs: $bccAddrs, ')
          ..write('replyToAddrs: $replyToAddrs, ')
          ..write('fromEmail: $fromEmail, ')
          ..write('subject: $subject, ')
          ..write('baseSubject: $baseSubject, ')
          ..write('preview: $preview, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('size: $size, ')
          ..write('keywords: $keywords, ')
          ..write('isSeen: $isSeen, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('hasAttachment: $hasAttachment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    seq,
    id,
    accountId,
    mailboxId,
    threadId,
    messageIdHeader,
    inReplyTo,
    referencesJson,
    fromAddrs,
    toAddrs,
    ccAddrs,
    bccAddrs,
    replyToAddrs,
    fromEmail,
    subject,
    baseSubject,
    preview,
    receivedAt,
    sentAt,
    size,
    keywords,
    isSeen,
    isFlagged,
    hasAttachment,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailRow &&
          other.seq == this.seq &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.mailboxId == this.mailboxId &&
          other.threadId == this.threadId &&
          other.messageIdHeader == this.messageIdHeader &&
          other.inReplyTo == this.inReplyTo &&
          other.referencesJson == this.referencesJson &&
          other.fromAddrs == this.fromAddrs &&
          other.toAddrs == this.toAddrs &&
          other.ccAddrs == this.ccAddrs &&
          other.bccAddrs == this.bccAddrs &&
          other.replyToAddrs == this.replyToAddrs &&
          other.fromEmail == this.fromEmail &&
          other.subject == this.subject &&
          other.baseSubject == this.baseSubject &&
          other.preview == this.preview &&
          other.receivedAt == this.receivedAt &&
          other.sentAt == this.sentAt &&
          other.size == this.size &&
          other.keywords == this.keywords &&
          other.isSeen == this.isSeen &&
          other.isFlagged == this.isFlagged &&
          other.hasAttachment == this.hasAttachment);
}

class EmailsCompanion extends UpdateCompanion<EmailRow> {
  final Value<int> seq;
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> mailboxId;
  final Value<String> threadId;
  final Value<String?> messageIdHeader;
  final Value<String?> inReplyTo;
  final Value<String> referencesJson;
  final Value<String> fromAddrs;
  final Value<String> toAddrs;
  final Value<String> ccAddrs;
  final Value<String> bccAddrs;
  final Value<String> replyToAddrs;
  final Value<String> fromEmail;
  final Value<String> subject;
  final Value<String> baseSubject;
  final Value<String> preview;
  final Value<int> receivedAt;
  final Value<int?> sentAt;
  final Value<int> size;
  final Value<String> keywords;
  final Value<bool> isSeen;
  final Value<bool> isFlagged;
  final Value<bool> hasAttachment;
  const EmailsCompanion({
    this.seq = const Value.absent(),
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.mailboxId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.messageIdHeader = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    this.referencesJson = const Value.absent(),
    this.fromAddrs = const Value.absent(),
    this.toAddrs = const Value.absent(),
    this.ccAddrs = const Value.absent(),
    this.bccAddrs = const Value.absent(),
    this.replyToAddrs = const Value.absent(),
    this.fromEmail = const Value.absent(),
    this.subject = const Value.absent(),
    this.baseSubject = const Value.absent(),
    this.preview = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.size = const Value.absent(),
    this.keywords = const Value.absent(),
    this.isSeen = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.hasAttachment = const Value.absent(),
  });
  EmailsCompanion.insert({
    this.seq = const Value.absent(),
    required String id,
    required String accountId,
    required String mailboxId,
    required String threadId,
    this.messageIdHeader = const Value.absent(),
    this.inReplyTo = const Value.absent(),
    this.referencesJson = const Value.absent(),
    this.fromAddrs = const Value.absent(),
    this.toAddrs = const Value.absent(),
    this.ccAddrs = const Value.absent(),
    this.bccAddrs = const Value.absent(),
    this.replyToAddrs = const Value.absent(),
    this.fromEmail = const Value.absent(),
    this.subject = const Value.absent(),
    this.baseSubject = const Value.absent(),
    this.preview = const Value.absent(),
    required int receivedAt,
    this.sentAt = const Value.absent(),
    this.size = const Value.absent(),
    this.keywords = const Value.absent(),
    this.isSeen = const Value.absent(),
    this.isFlagged = const Value.absent(),
    this.hasAttachment = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       mailboxId = Value(mailboxId),
       threadId = Value(threadId),
       receivedAt = Value(receivedAt);
  static Insertable<EmailRow> custom({
    Expression<int>? seq,
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? mailboxId,
    Expression<String>? threadId,
    Expression<String>? messageIdHeader,
    Expression<String>? inReplyTo,
    Expression<String>? referencesJson,
    Expression<String>? fromAddrs,
    Expression<String>? toAddrs,
    Expression<String>? ccAddrs,
    Expression<String>? bccAddrs,
    Expression<String>? replyToAddrs,
    Expression<String>? fromEmail,
    Expression<String>? subject,
    Expression<String>? baseSubject,
    Expression<String>? preview,
    Expression<int>? receivedAt,
    Expression<int>? sentAt,
    Expression<int>? size,
    Expression<String>? keywords,
    Expression<bool>? isSeen,
    Expression<bool>? isFlagged,
    Expression<bool>? hasAttachment,
  }) {
    return RawValuesInsertable({
      if (seq != null) 'seq': seq,
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (threadId != null) 'thread_id': threadId,
      if (messageIdHeader != null) 'message_id_header': messageIdHeader,
      if (inReplyTo != null) 'in_reply_to': inReplyTo,
      if (referencesJson != null) 'references_json': referencesJson,
      if (fromAddrs != null) 'from_json': fromAddrs,
      if (toAddrs != null) 'to_json': toAddrs,
      if (ccAddrs != null) 'cc_json': ccAddrs,
      if (bccAddrs != null) 'bcc_json': bccAddrs,
      if (replyToAddrs != null) 'reply_to_json': replyToAddrs,
      if (fromEmail != null) 'from_email': fromEmail,
      if (subject != null) 'subject': subject,
      if (baseSubject != null) 'base_subject': baseSubject,
      if (preview != null) 'preview': preview,
      if (receivedAt != null) 'received_at': receivedAt,
      if (sentAt != null) 'sent_at': sentAt,
      if (size != null) 'size': size,
      if (keywords != null) 'keywords': keywords,
      if (isSeen != null) 'is_seen': isSeen,
      if (isFlagged != null) 'is_flagged': isFlagged,
      if (hasAttachment != null) 'has_attachment': hasAttachment,
    });
  }

  EmailsCompanion copyWith({
    Value<int>? seq,
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? mailboxId,
    Value<String>? threadId,
    Value<String?>? messageIdHeader,
    Value<String?>? inReplyTo,
    Value<String>? referencesJson,
    Value<String>? fromAddrs,
    Value<String>? toAddrs,
    Value<String>? ccAddrs,
    Value<String>? bccAddrs,
    Value<String>? replyToAddrs,
    Value<String>? fromEmail,
    Value<String>? subject,
    Value<String>? baseSubject,
    Value<String>? preview,
    Value<int>? receivedAt,
    Value<int?>? sentAt,
    Value<int>? size,
    Value<String>? keywords,
    Value<bool>? isSeen,
    Value<bool>? isFlagged,
    Value<bool>? hasAttachment,
  }) {
    return EmailsCompanion(
      seq: seq ?? this.seq,
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      mailboxId: mailboxId ?? this.mailboxId,
      threadId: threadId ?? this.threadId,
      messageIdHeader: messageIdHeader ?? this.messageIdHeader,
      inReplyTo: inReplyTo ?? this.inReplyTo,
      referencesJson: referencesJson ?? this.referencesJson,
      fromAddrs: fromAddrs ?? this.fromAddrs,
      toAddrs: toAddrs ?? this.toAddrs,
      ccAddrs: ccAddrs ?? this.ccAddrs,
      bccAddrs: bccAddrs ?? this.bccAddrs,
      replyToAddrs: replyToAddrs ?? this.replyToAddrs,
      fromEmail: fromEmail ?? this.fromEmail,
      subject: subject ?? this.subject,
      baseSubject: baseSubject ?? this.baseSubject,
      preview: preview ?? this.preview,
      receivedAt: receivedAt ?? this.receivedAt,
      sentAt: sentAt ?? this.sentAt,
      size: size ?? this.size,
      keywords: keywords ?? this.keywords,
      isSeen: isSeen ?? this.isSeen,
      isFlagged: isFlagged ?? this.isFlagged,
      hasAttachment: hasAttachment ?? this.hasAttachment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (messageIdHeader.present) {
      map['message_id_header'] = Variable<String>(messageIdHeader.value);
    }
    if (inReplyTo.present) {
      map['in_reply_to'] = Variable<String>(inReplyTo.value);
    }
    if (referencesJson.present) {
      map['references_json'] = Variable<String>(referencesJson.value);
    }
    if (fromAddrs.present) {
      map['from_json'] = Variable<String>(fromAddrs.value);
    }
    if (toAddrs.present) {
      map['to_json'] = Variable<String>(toAddrs.value);
    }
    if (ccAddrs.present) {
      map['cc_json'] = Variable<String>(ccAddrs.value);
    }
    if (bccAddrs.present) {
      map['bcc_json'] = Variable<String>(bccAddrs.value);
    }
    if (replyToAddrs.present) {
      map['reply_to_json'] = Variable<String>(replyToAddrs.value);
    }
    if (fromEmail.present) {
      map['from_email'] = Variable<String>(fromEmail.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (baseSubject.present) {
      map['base_subject'] = Variable<String>(baseSubject.value);
    }
    if (preview.present) {
      map['preview'] = Variable<String>(preview.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<int>(receivedAt.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<int>(sentAt.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (keywords.present) {
      map['keywords'] = Variable<String>(keywords.value);
    }
    if (isSeen.present) {
      map['is_seen'] = Variable<bool>(isSeen.value);
    }
    if (isFlagged.present) {
      map['is_flagged'] = Variable<bool>(isFlagged.value);
    }
    if (hasAttachment.present) {
      map['has_attachment'] = Variable<bool>(hasAttachment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailsCompanion(')
          ..write('seq: $seq, ')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('threadId: $threadId, ')
          ..write('messageIdHeader: $messageIdHeader, ')
          ..write('inReplyTo: $inReplyTo, ')
          ..write('referencesJson: $referencesJson, ')
          ..write('fromAddrs: $fromAddrs, ')
          ..write('toAddrs: $toAddrs, ')
          ..write('ccAddrs: $ccAddrs, ')
          ..write('bccAddrs: $bccAddrs, ')
          ..write('replyToAddrs: $replyToAddrs, ')
          ..write('fromEmail: $fromEmail, ')
          ..write('subject: $subject, ')
          ..write('baseSubject: $baseSubject, ')
          ..write('preview: $preview, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('size: $size, ')
          ..write('keywords: $keywords, ')
          ..write('isSeen: $isSeen, ')
          ..write('isFlagged: $isFlagged, ')
          ..write('hasAttachment: $hasAttachment')
          ..write(')'))
        .toString();
  }
}

class $EmailKeywordsTable extends EmailKeywords with TableInfo<$EmailKeywordsTable, EmailKeywordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmailKeywordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailIdMeta = const VerificationMeta('emailId');
  @override
  late final GeneratedColumn<String> emailId = GeneratedColumn<String>(
    'email_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _keywordMeta = const VerificationMeta('keyword');
  @override
  late final GeneratedColumn<String> keyword = GeneratedColumn<String>(
    'keyword',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [emailId, keyword];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'email_keywords';
  @override
  VerificationContext validateIntegrity(Insertable<EmailKeywordRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email_id')) {
      context.handle(_emailIdMeta, emailId.isAcceptableOrUnknown(data['email_id']!, _emailIdMeta));
    } else if (isInserting) {
      context.missing(_emailIdMeta);
    }
    if (data.containsKey('keyword')) {
      context.handle(_keywordMeta, keyword.isAcceptableOrUnknown(data['keyword']!, _keywordMeta));
    } else if (isInserting) {
      context.missing(_keywordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {emailId, keyword};
  @override
  EmailKeywordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmailKeywordRow(
      emailId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email_id'])!,
      keyword: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}keyword'])!,
    );
  }

  @override
  $EmailKeywordsTable createAlias(String alias) {
    return $EmailKeywordsTable(attachedDatabase, alias);
  }
}

class EmailKeywordRow extends DataClass implements Insertable<EmailKeywordRow> {
  final String emailId;
  final String keyword;
  const EmailKeywordRow({required this.emailId, required this.keyword});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email_id'] = Variable<String>(emailId);
    map['keyword'] = Variable<String>(keyword);
    return map;
  }

  EmailKeywordsCompanion toCompanion(bool nullToAbsent) {
    return EmailKeywordsCompanion(emailId: Value(emailId), keyword: Value(keyword));
  }

  factory EmailKeywordRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmailKeywordRow(
      emailId: serializer.fromJson<String>(json['emailId']),
      keyword: serializer.fromJson<String>(json['keyword']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'emailId': serializer.toJson<String>(emailId),
      'keyword': serializer.toJson<String>(keyword),
    };
  }

  EmailKeywordRow copyWith({String? emailId, String? keyword}) =>
      EmailKeywordRow(emailId: emailId ?? this.emailId, keyword: keyword ?? this.keyword);
  EmailKeywordRow copyWithCompanion(EmailKeywordsCompanion data) {
    return EmailKeywordRow(
      emailId: data.emailId.present ? data.emailId.value : this.emailId,
      keyword: data.keyword.present ? data.keyword.value : this.keyword,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmailKeywordRow(')
          ..write('emailId: $emailId, ')
          ..write('keyword: $keyword')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(emailId, keyword);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmailKeywordRow && other.emailId == this.emailId && other.keyword == this.keyword);
}

class EmailKeywordsCompanion extends UpdateCompanion<EmailKeywordRow> {
  final Value<String> emailId;
  final Value<String> keyword;
  final Value<int> rowid;
  const EmailKeywordsCompanion({
    this.emailId = const Value.absent(),
    this.keyword = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmailKeywordsCompanion.insert({required String emailId, required String keyword, this.rowid = const Value.absent()})
    : emailId = Value(emailId),
      keyword = Value(keyword);
  static Insertable<EmailKeywordRow> custom({
    Expression<String>? emailId,
    Expression<String>? keyword,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (emailId != null) 'email_id': emailId,
      if (keyword != null) 'keyword': keyword,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmailKeywordsCompanion copyWith({Value<String>? emailId, Value<String>? keyword, Value<int>? rowid}) {
    return EmailKeywordsCompanion(
      emailId: emailId ?? this.emailId,
      keyword: keyword ?? this.keyword,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (emailId.present) {
      map['email_id'] = Variable<String>(emailId.value);
    }
    if (keyword.present) {
      map['keyword'] = Variable<String>(keyword.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmailKeywordsCompanion(')
          ..write('emailId: $emailId, ')
          ..write('keyword: $keyword, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentsTable extends Contents with TableInfo<$ContentsTable, ContentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailIdMeta = const VerificationMeta('emailId');
  @override
  late final GeneratedColumn<String> emailId = GeneratedColumn<String>(
    'email_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _htmlMeta = const VerificationMeta('html');
  @override
  late final GeneratedColumn<String> html = GeneratedColumn<String>(
    'html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plainTextMeta = const VerificationMeta('plainText');
  @override
  late final GeneratedColumn<String> plainText = GeneratedColumn<String>(
    'plain_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFlowedMeta = const VerificationMeta('isFlowed');
  @override
  late final GeneratedColumn<bool> isFlowed = GeneratedColumn<bool>(
    'is_flowed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_flowed" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _headersJsonMeta = const VerificationMeta('headersJson');
  @override
  late final GeneratedColumn<String> headersJson = GeneratedColumn<String>(
    'headers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _attachmentsJsonMeta = const VerificationMeta('attachmentsJson');
  @override
  late final GeneratedColumn<String> attachmentsJson = GeneratedColumn<String>(
    'attachments_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _bodyTextMeta = const VerificationMeta('bodyText');
  @override
  late final GeneratedColumn<String> bodyText = GeneratedColumn<String>(
    'body_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta('fetchedAt');
  @override
  late final GeneratedColumn<int> fetchedAt = GeneratedColumn<int>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    emailId,
    html,
    plainText,
    isFlowed,
    headersJson,
    attachmentsJson,
    bodyText,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contents';
  @override
  VerificationContext validateIntegrity(Insertable<ContentRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email_id')) {
      context.handle(_emailIdMeta, emailId.isAcceptableOrUnknown(data['email_id']!, _emailIdMeta));
    } else if (isInserting) {
      context.missing(_emailIdMeta);
    }
    if (data.containsKey('html')) {
      context.handle(_htmlMeta, html.isAcceptableOrUnknown(data['html']!, _htmlMeta));
    }
    if (data.containsKey('plain_text')) {
      context.handle(_plainTextMeta, plainText.isAcceptableOrUnknown(data['plain_text']!, _plainTextMeta));
    }
    if (data.containsKey('is_flowed')) {
      context.handle(_isFlowedMeta, isFlowed.isAcceptableOrUnknown(data['is_flowed']!, _isFlowedMeta));
    }
    if (data.containsKey('headers_json')) {
      context.handle(_headersJsonMeta, headersJson.isAcceptableOrUnknown(data['headers_json']!, _headersJsonMeta));
    }
    if (data.containsKey('attachments_json')) {
      context.handle(
        _attachmentsJsonMeta,
        attachmentsJson.isAcceptableOrUnknown(data['attachments_json']!, _attachmentsJsonMeta),
      );
    }
    if (data.containsKey('body_text')) {
      context.handle(_bodyTextMeta, bodyText.isAcceptableOrUnknown(data['body_text']!, _bodyTextMeta));
    }
    if (data.containsKey('fetched_at')) {
      context.handle(_fetchedAtMeta, fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta));
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {emailId};
  @override
  ContentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentRow(
      emailId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email_id'])!,
      html: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}html']),
      plainText: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}plain_text']),
      isFlowed: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_flowed'])!,
      headersJson: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}headers_json'])!,
      attachmentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachments_json'],
      )!,
      bodyText: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}body_text'])!,
      fetchedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}fetched_at'])!,
    );
  }

  @override
  $ContentsTable createAlias(String alias) {
    return $ContentsTable(attachedDatabase, alias);
  }
}

class ContentRow extends DataClass implements Insertable<ContentRow> {
  final String emailId;
  final String? html;
  final String? plainText;
  final bool isFlowed;
  final String headersJson;
  final String attachmentsJson;

  /// Plain body text for the full-text index (capped).
  final String bodyText;
  final int fetchedAt;
  const ContentRow({
    required this.emailId,
    this.html,
    this.plainText,
    required this.isFlowed,
    required this.headersJson,
    required this.attachmentsJson,
    required this.bodyText,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email_id'] = Variable<String>(emailId);
    if (!nullToAbsent || html != null) {
      map['html'] = Variable<String>(html);
    }
    if (!nullToAbsent || plainText != null) {
      map['plain_text'] = Variable<String>(plainText);
    }
    map['is_flowed'] = Variable<bool>(isFlowed);
    map['headers_json'] = Variable<String>(headersJson);
    map['attachments_json'] = Variable<String>(attachmentsJson);
    map['body_text'] = Variable<String>(bodyText);
    map['fetched_at'] = Variable<int>(fetchedAt);
    return map;
  }

  ContentsCompanion toCompanion(bool nullToAbsent) {
    return ContentsCompanion(
      emailId: Value(emailId),
      html: html == null && nullToAbsent ? const Value.absent() : Value(html),
      plainText: plainText == null && nullToAbsent ? const Value.absent() : Value(plainText),
      isFlowed: Value(isFlowed),
      headersJson: Value(headersJson),
      attachmentsJson: Value(attachmentsJson),
      bodyText: Value(bodyText),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory ContentRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentRow(
      emailId: serializer.fromJson<String>(json['emailId']),
      html: serializer.fromJson<String?>(json['html']),
      plainText: serializer.fromJson<String?>(json['plainText']),
      isFlowed: serializer.fromJson<bool>(json['isFlowed']),
      headersJson: serializer.fromJson<String>(json['headersJson']),
      attachmentsJson: serializer.fromJson<String>(json['attachmentsJson']),
      bodyText: serializer.fromJson<String>(json['bodyText']),
      fetchedAt: serializer.fromJson<int>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'emailId': serializer.toJson<String>(emailId),
      'html': serializer.toJson<String?>(html),
      'plainText': serializer.toJson<String?>(plainText),
      'isFlowed': serializer.toJson<bool>(isFlowed),
      'headersJson': serializer.toJson<String>(headersJson),
      'attachmentsJson': serializer.toJson<String>(attachmentsJson),
      'bodyText': serializer.toJson<String>(bodyText),
      'fetchedAt': serializer.toJson<int>(fetchedAt),
    };
  }

  ContentRow copyWith({
    String? emailId,
    Value<String?> html = const Value.absent(),
    Value<String?> plainText = const Value.absent(),
    bool? isFlowed,
    String? headersJson,
    String? attachmentsJson,
    String? bodyText,
    int? fetchedAt,
  }) => ContentRow(
    emailId: emailId ?? this.emailId,
    html: html.present ? html.value : this.html,
    plainText: plainText.present ? plainText.value : this.plainText,
    isFlowed: isFlowed ?? this.isFlowed,
    headersJson: headersJson ?? this.headersJson,
    attachmentsJson: attachmentsJson ?? this.attachmentsJson,
    bodyText: bodyText ?? this.bodyText,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  ContentRow copyWithCompanion(ContentsCompanion data) {
    return ContentRow(
      emailId: data.emailId.present ? data.emailId.value : this.emailId,
      html: data.html.present ? data.html.value : this.html,
      plainText: data.plainText.present ? data.plainText.value : this.plainText,
      isFlowed: data.isFlowed.present ? data.isFlowed.value : this.isFlowed,
      headersJson: data.headersJson.present ? data.headersJson.value : this.headersJson,
      attachmentsJson: data.attachmentsJson.present ? data.attachmentsJson.value : this.attachmentsJson,
      bodyText: data.bodyText.present ? data.bodyText.value : this.bodyText,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentRow(')
          ..write('emailId: $emailId, ')
          ..write('html: $html, ')
          ..write('plainText: $plainText, ')
          ..write('isFlowed: $isFlowed, ')
          ..write('headersJson: $headersJson, ')
          ..write('attachmentsJson: $attachmentsJson, ')
          ..write('bodyText: $bodyText, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(emailId, html, plainText, isFlowed, headersJson, attachmentsJson, bodyText, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentRow &&
          other.emailId == this.emailId &&
          other.html == this.html &&
          other.plainText == this.plainText &&
          other.isFlowed == this.isFlowed &&
          other.headersJson == this.headersJson &&
          other.attachmentsJson == this.attachmentsJson &&
          other.bodyText == this.bodyText &&
          other.fetchedAt == this.fetchedAt);
}

class ContentsCompanion extends UpdateCompanion<ContentRow> {
  final Value<String> emailId;
  final Value<String?> html;
  final Value<String?> plainText;
  final Value<bool> isFlowed;
  final Value<String> headersJson;
  final Value<String> attachmentsJson;
  final Value<String> bodyText;
  final Value<int> fetchedAt;
  final Value<int> rowid;
  const ContentsCompanion({
    this.emailId = const Value.absent(),
    this.html = const Value.absent(),
    this.plainText = const Value.absent(),
    this.isFlowed = const Value.absent(),
    this.headersJson = const Value.absent(),
    this.attachmentsJson = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentsCompanion.insert({
    required String emailId,
    this.html = const Value.absent(),
    this.plainText = const Value.absent(),
    this.isFlowed = const Value.absent(),
    this.headersJson = const Value.absent(),
    this.attachmentsJson = const Value.absent(),
    this.bodyText = const Value.absent(),
    required int fetchedAt,
    this.rowid = const Value.absent(),
  }) : emailId = Value(emailId),
       fetchedAt = Value(fetchedAt);
  static Insertable<ContentRow> custom({
    Expression<String>? emailId,
    Expression<String>? html,
    Expression<String>? plainText,
    Expression<bool>? isFlowed,
    Expression<String>? headersJson,
    Expression<String>? attachmentsJson,
    Expression<String>? bodyText,
    Expression<int>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (emailId != null) 'email_id': emailId,
      if (html != null) 'html': html,
      if (plainText != null) 'plain_text': plainText,
      if (isFlowed != null) 'is_flowed': isFlowed,
      if (headersJson != null) 'headers_json': headersJson,
      if (attachmentsJson != null) 'attachments_json': attachmentsJson,
      if (bodyText != null) 'body_text': bodyText,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentsCompanion copyWith({
    Value<String>? emailId,
    Value<String?>? html,
    Value<String?>? plainText,
    Value<bool>? isFlowed,
    Value<String>? headersJson,
    Value<String>? attachmentsJson,
    Value<String>? bodyText,
    Value<int>? fetchedAt,
    Value<int>? rowid,
  }) {
    return ContentsCompanion(
      emailId: emailId ?? this.emailId,
      html: html ?? this.html,
      plainText: plainText ?? this.plainText,
      isFlowed: isFlowed ?? this.isFlowed,
      headersJson: headersJson ?? this.headersJson,
      attachmentsJson: attachmentsJson ?? this.attachmentsJson,
      bodyText: bodyText ?? this.bodyText,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (emailId.present) {
      map['email_id'] = Variable<String>(emailId.value);
    }
    if (html.present) {
      map['html'] = Variable<String>(html.value);
    }
    if (plainText.present) {
      map['plain_text'] = Variable<String>(plainText.value);
    }
    if (isFlowed.present) {
      map['is_flowed'] = Variable<bool>(isFlowed.value);
    }
    if (headersJson.present) {
      map['headers_json'] = Variable<String>(headersJson.value);
    }
    if (attachmentsJson.present) {
      map['attachments_json'] = Variable<String>(attachmentsJson.value);
    }
    if (bodyText.present) {
      map['body_text'] = Variable<String>(bodyText.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<int>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentsCompanion(')
          ..write('emailId: $emailId, ')
          ..write('html: $html, ')
          ..write('plainText: $plainText, ')
          ..write('isFlowed: $isFlowed, ')
          ..write('headersJson: $headersJson, ')
          ..write('attachmentsJson: $attachmentsJson, ')
          ..write('bodyText: $bodyText, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InlinePartsTable extends InlineParts with TableInfo<$InlinePartsTable, InlinePartRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InlinePartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailIdMeta = const VerificationMeta('emailId');
  @override
  late final GeneratedColumn<String> emailId = GeneratedColumn<String>(
    'email_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES emails (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta('contentId');
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [emailId, contentId, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inline_parts';
  @override
  VerificationContext validateIntegrity(Insertable<InlinePartRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email_id')) {
      context.handle(_emailIdMeta, emailId.isAcceptableOrUnknown(data['email_id']!, _emailIdMeta));
    } else if (isInserting) {
      context.missing(_emailIdMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(_contentIdMeta, contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta));
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('data')) {
      context.handle(_dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {emailId, contentId};
  @override
  InlinePartRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InlinePartRow(
      emailId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email_id'])!,
      contentId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}content_id'])!,
      data: attachedDatabase.typeMapping.read(DriftSqlType.blob, data['${effectivePrefix}data'])!,
    );
  }

  @override
  $InlinePartsTable createAlias(String alias) {
    return $InlinePartsTable(attachedDatabase, alias);
  }
}

class InlinePartRow extends DataClass implements Insertable<InlinePartRow> {
  final String emailId;
  final String contentId;
  final Uint8List data;
  const InlinePartRow({required this.emailId, required this.contentId, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email_id'] = Variable<String>(emailId);
    map['content_id'] = Variable<String>(contentId);
    map['data'] = Variable<Uint8List>(data);
    return map;
  }

  InlinePartsCompanion toCompanion(bool nullToAbsent) {
    return InlinePartsCompanion(emailId: Value(emailId), contentId: Value(contentId), data: Value(data));
  }

  factory InlinePartRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InlinePartRow(
      emailId: serializer.fromJson<String>(json['emailId']),
      contentId: serializer.fromJson<String>(json['contentId']),
      data: serializer.fromJson<Uint8List>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'emailId': serializer.toJson<String>(emailId),
      'contentId': serializer.toJson<String>(contentId),
      'data': serializer.toJson<Uint8List>(data),
    };
  }

  InlinePartRow copyWith({String? emailId, String? contentId, Uint8List? data}) =>
      InlinePartRow(emailId: emailId ?? this.emailId, contentId: contentId ?? this.contentId, data: data ?? this.data);
  InlinePartRow copyWithCompanion(InlinePartsCompanion data) {
    return InlinePartRow(
      emailId: data.emailId.present ? data.emailId.value : this.emailId,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InlinePartRow(')
          ..write('emailId: $emailId, ')
          ..write('contentId: $contentId, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(emailId, contentId, $driftBlobEquality.hash(data));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InlinePartRow &&
          other.emailId == this.emailId &&
          other.contentId == this.contentId &&
          $driftBlobEquality.equals(other.data, this.data));
}

class InlinePartsCompanion extends UpdateCompanion<InlinePartRow> {
  final Value<String> emailId;
  final Value<String> contentId;
  final Value<Uint8List> data;
  final Value<int> rowid;
  const InlinePartsCompanion({
    this.emailId = const Value.absent(),
    this.contentId = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InlinePartsCompanion.insert({
    required String emailId,
    required String contentId,
    required Uint8List data,
    this.rowid = const Value.absent(),
  }) : emailId = Value(emailId),
       contentId = Value(contentId),
       data = Value(data);
  static Insertable<InlinePartRow> custom({
    Expression<String>? emailId,
    Expression<String>? contentId,
    Expression<Uint8List>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (emailId != null) 'email_id': emailId,
      if (contentId != null) 'content_id': contentId,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InlinePartsCompanion copyWith({
    Value<String>? emailId,
    Value<String>? contentId,
    Value<Uint8List>? data,
    Value<int>? rowid,
  }) {
    return InlinePartsCompanion(
      emailId: emailId ?? this.emailId,
      contentId: contentId ?? this.contentId,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (emailId.present) {
      map['email_id'] = Variable<String>(emailId.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InlinePartsCompanion(')
          ..write('emailId: $emailId, ')
          ..write('contentId: $contentId, ')
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxItemsTable extends OutboxItems with TableInfo<$OutboxItemsTable, OutboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES accounts (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _messageMeta = const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sendAfterMeta = const VerificationMeta('sendAfter');
  @override
  late final GeneratedColumn<int> sendAfter = GeneratedColumn<int>(
    'send_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, accountId, message, sendAfter, status, attempts, lastError, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_items';
  @override
  VerificationContext validateIntegrity(Insertable<OutboxRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta, message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('send_after')) {
      context.handle(_sendAfterMeta, sendAfter.isAcceptableOrUnknown(data['send_after']!, _sendAfterMeta));
    } else if (isInserting) {
      context.missing(_sendAfterMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta, attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta, lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      message: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      sendAfter: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}send_after'])!,
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      attempts: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      lastError: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $OutboxItemsTable createAlias(String alias) {
    return $OutboxItemsTable(attachedDatabase, alias);
  }
}

class OutboxRow extends DataClass implements Insertable<OutboxRow> {
  final String id;
  final String accountId;
  final String message;
  final int sendAfter;

  /// `OutboxStatus.name`.
  final String status;
  final int attempts;
  final String? lastError;
  final int createdAt;
  const OutboxRow({
    required this.id,
    required this.accountId,
    required this.message,
    required this.sendAfter,
    required this.status,
    required this.attempts,
    this.lastError,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['message'] = Variable<String>(message);
    map['send_after'] = Variable<int>(sendAfter);
    map['status'] = Variable<String>(status);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  OutboxItemsCompanion toCompanion(bool nullToAbsent) {
    return OutboxItemsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      message: Value(message),
      sendAfter: Value(sendAfter),
      status: Value(status),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent ? const Value.absent() : Value(lastError),
      createdAt: Value(createdAt),
    );
  }

  factory OutboxRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxRow(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      message: serializer.fromJson<String>(json['message']),
      sendAfter: serializer.fromJson<int>(json['sendAfter']),
      status: serializer.fromJson<String>(json['status']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'message': serializer.toJson<String>(message),
      'sendAfter': serializer.toJson<int>(sendAfter),
      'status': serializer.toJson<String>(status),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  OutboxRow copyWith({
    String? id,
    String? accountId,
    String? message,
    int? sendAfter,
    String? status,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    int? createdAt,
  }) => OutboxRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    message: message ?? this.message,
    sendAfter: sendAfter ?? this.sendAfter,
    status: status ?? this.status,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
  );
  OutboxRow copyWithCompanion(OutboxItemsCompanion data) {
    return OutboxRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      message: data.message.present ? data.message.value : this.message,
      sendAfter: data.sendAfter.present ? data.sendAfter.value : this.sendAfter,
      status: data.status.present ? data.status.value : this.status,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('message: $message, ')
          ..write('sendAfter: $sendAfter, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, message, sendAfter, status, attempts, lastError, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.message == this.message &&
          other.sendAfter == this.sendAfter &&
          other.status == this.status &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt);
}

class OutboxItemsCompanion extends UpdateCompanion<OutboxRow> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<String> message;
  final Value<int> sendAfter;
  final Value<String> status;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<int> createdAt;
  final Value<int> rowid;
  const OutboxItemsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.message = const Value.absent(),
    this.sendAfter = const Value.absent(),
    this.status = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OutboxItemsCompanion.insert({
    required String id,
    required String accountId,
    required String message,
    required int sendAfter,
    required String status,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       message = Value(message),
       sendAfter = Value(sendAfter),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<OutboxRow> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? message,
    Expression<int>? sendAfter,
    Expression<String>? status,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (message != null) 'message': message,
      if (sendAfter != null) 'send_after': sendAfter,
      if (status != null) 'status': status,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OutboxItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<String>? message,
    Value<int>? sendAfter,
    Value<String>? status,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return OutboxItemsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      message: message ?? this.message,
      sendAfter: sendAfter ?? this.sendAfter,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (sendAfter.present) {
      map['send_after'] = Variable<int>(sendAfter.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxItemsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('message: $message, ')
          ..write('sendAfter: $sendAfter, ')
          ..write('status: $status, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingOpsTable extends PendingOps with TableInfo<$PendingOpsTable, PendingOpRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingOpsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES accounts (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta('attempts');
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta('nextAttemptAt');
  @override
  late final GeneratedColumn<int> nextAttemptAt = GeneratedColumn<int>(
    'next_attempt_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, accountId, type, payload, attempts, nextAttemptAt, createdAt, lastError];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_ops';
  @override
  VerificationContext validateIntegrity(Insertable<PendingOpRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta, payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(_attemptsMeta, attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta));
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(data['next_attempt_at']!, _nextAttemptAtMeta),
      );
    } else if (isInserting) {
      context.missing(_nextAttemptAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta, lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingOpRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingOpRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      payload: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      attempts: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}attempts'])!,
      nextAttemptAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}next_attempt_at'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      lastError: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}last_error']),
    );
  }

  @override
  $PendingOpsTable createAlias(String alias) {
    return $PendingOpsTable(attachedDatabase, alias);
  }
}

class PendingOpRow extends DataClass implements Insertable<PendingOpRow> {
  final int id;
  final String accountId;
  final String type;
  final String payload;
  final int attempts;
  final int nextAttemptAt;
  final int createdAt;
  final String? lastError;
  const PendingOpRow({
    required this.id,
    required this.accountId,
    required this.type,
    required this.payload,
    required this.attempts,
    required this.nextAttemptAt,
    required this.createdAt,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<String>(accountId);
    map['type'] = Variable<String>(type);
    map['payload'] = Variable<String>(payload);
    map['attempts'] = Variable<int>(attempts);
    map['next_attempt_at'] = Variable<int>(nextAttemptAt);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  PendingOpsCompanion toCompanion(bool nullToAbsent) {
    return PendingOpsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      type: Value(type),
      payload: Value(payload),
      attempts: Value(attempts),
      nextAttemptAt: Value(nextAttemptAt),
      createdAt: Value(createdAt),
      lastError: lastError == null && nullToAbsent ? const Value.absent() : Value(lastError),
    );
  }

  factory PendingOpRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingOpRow(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      type: serializer.fromJson<String>(json['type']),
      payload: serializer.fromJson<String>(json['payload']),
      attempts: serializer.fromJson<int>(json['attempts']),
      nextAttemptAt: serializer.fromJson<int>(json['nextAttemptAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<String>(accountId),
      'type': serializer.toJson<String>(type),
      'payload': serializer.toJson<String>(payload),
      'attempts': serializer.toJson<int>(attempts),
      'nextAttemptAt': serializer.toJson<int>(nextAttemptAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  PendingOpRow copyWith({
    int? id,
    String? accountId,
    String? type,
    String? payload,
    int? attempts,
    int? nextAttemptAt,
    int? createdAt,
    Value<String?> lastError = const Value.absent(),
  }) => PendingOpRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    type: type ?? this.type,
    payload: payload ?? this.payload,
    attempts: attempts ?? this.attempts,
    nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
    createdAt: createdAt ?? this.createdAt,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  PendingOpRow copyWithCompanion(PendingOpsCompanion data) {
    return PendingOpRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      type: data.type.present ? data.type.value : this.type,
      payload: data.payload.present ? data.payload.value : this.payload,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      nextAttemptAt: data.nextAttemptAt.present ? data.nextAttemptAt.value : this.nextAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingOpRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, type, payload, attempts, nextAttemptAt, createdAt, lastError);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingOpRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.type == this.type &&
          other.payload == this.payload &&
          other.attempts == this.attempts &&
          other.nextAttemptAt == this.nextAttemptAt &&
          other.createdAt == this.createdAt &&
          other.lastError == this.lastError);
}

class PendingOpsCompanion extends UpdateCompanion<PendingOpRow> {
  final Value<int> id;
  final Value<String> accountId;
  final Value<String> type;
  final Value<String> payload;
  final Value<int> attempts;
  final Value<int> nextAttemptAt;
  final Value<int> createdAt;
  final Value<String?> lastError;
  const PendingOpsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.type = const Value.absent(),
    this.payload = const Value.absent(),
    this.attempts = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  PendingOpsCompanion.insert({
    this.id = const Value.absent(),
    required String accountId,
    required String type,
    required String payload,
    this.attempts = const Value.absent(),
    required int nextAttemptAt,
    required int createdAt,
    this.lastError = const Value.absent(),
  }) : accountId = Value(accountId),
       type = Value(type),
       payload = Value(payload),
       nextAttemptAt = Value(nextAttemptAt),
       createdAt = Value(createdAt);
  static Insertable<PendingOpRow> custom({
    Expression<int>? id,
    Expression<String>? accountId,
    Expression<String>? type,
    Expression<String>? payload,
    Expression<int>? attempts,
    Expression<int>? nextAttemptAt,
    Expression<int>? createdAt,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (type != null) 'type': type,
      if (payload != null) 'payload': payload,
      if (attempts != null) 'attempts': attempts,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
      if (lastError != null) 'last_error': lastError,
    });
  }

  PendingOpsCompanion copyWith({
    Value<int>? id,
    Value<String>? accountId,
    Value<String>? type,
    Value<String>? payload,
    Value<int>? attempts,
    Value<int>? nextAttemptAt,
    Value<int>? createdAt,
    Value<String?>? lastError,
  }) {
    return PendingOpsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      attempts: attempts ?? this.attempts,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      createdAt: createdAt ?? this.createdAt,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<int>(nextAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingOpsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('attempts: $attempts, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $VipAddressesTable extends VipAddresses with TableInfo<$VipAddressesTable, VipRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VipAddressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [email];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vip_addresses';
  @override
  VerificationContext validateIntegrity(Insertable<VipRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  VipRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VipRow(email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email'])!);
  }

  @override
  $VipAddressesTable createAlias(String alias) {
    return $VipAddressesTable(attachedDatabase, alias);
  }
}

class VipRow extends DataClass implements Insertable<VipRow> {
  /// Lower-cased address.
  final String email;
  const VipRow({required this.email});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email'] = Variable<String>(email);
    return map;
  }

  VipAddressesCompanion toCompanion(bool nullToAbsent) {
    return VipAddressesCompanion(email: Value(email));
  }

  factory VipRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VipRow(email: serializer.fromJson<String>(json['email']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'email': serializer.toJson<String>(email)};
  }

  VipRow copyWith({String? email}) => VipRow(email: email ?? this.email);
  VipRow copyWithCompanion(VipAddressesCompanion data) {
    return VipRow(email: data.email.present ? data.email.value : this.email);
  }

  @override
  String toString() {
    return (StringBuffer('VipRow(')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => email.hashCode;
  @override
  bool operator ==(Object other) => identical(this, other) || (other is VipRow && other.email == this.email);
}

class VipAddressesCompanion extends UpdateCompanion<VipRow> {
  final Value<String> email;
  final Value<int> rowid;
  const VipAddressesCompanion({this.email = const Value.absent(), this.rowid = const Value.absent()});
  VipAddressesCompanion.insert({required String email, this.rowid = const Value.absent()}) : email = Value(email);
  static Insertable<VipRow> custom({Expression<String>? email, Expression<int>? rowid}) {
    return RawValuesInsertable({if (email != null) 'email': email, if (rowid != null) 'rowid': rowid});
  }

  VipAddressesCompanion copyWith({Value<String>? email, Value<int>? rowid}) {
    return VipAddressesCompanion(email: email ?? this.email, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VipAddressesCompanion(')
          ..write('email: $email, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AddressBookTable extends AddressBook with TableInfo<$AddressBookTable, AddressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AddressBookTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _seenCountMeta = const VerificationMeta('seenCount');
  @override
  late final GeneratedColumn<int> seenCount = GeneratedColumn<int>(
    'seen_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sentCountMeta = const VerificationMeta('sentCount');
  @override
  late final GeneratedColumn<int> sentCount = GeneratedColumn<int>(
    'sent_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta('lastUsedAt');
  @override
  late final GeneratedColumn<int> lastUsedAt = GeneratedColumn<int>(
    'last_used_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [email, name, seenCount, sentCount, lastUsedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'address_book';
  @override
  VerificationContext validateIntegrity(Insertable<AddressRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(_emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('seen_count')) {
      context.handle(_seenCountMeta, seenCount.isAcceptableOrUnknown(data['seen_count']!, _seenCountMeta));
    }
    if (data.containsKey('sent_count')) {
      context.handle(_sentCountMeta, sentCount.isAcceptableOrUnknown(data['sent_count']!, _sentCountMeta));
    }
    if (data.containsKey('last_used_at')) {
      context.handle(_lastUsedAtMeta, lastUsedAt.isAcceptableOrUnknown(data['last_used_at']!, _lastUsedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUsedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  AddressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AddressRow(
      email: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name']),
      seenCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}seen_count'])!,
      sentCount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sent_count'])!,
      lastUsedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}last_used_at'])!,
    );
  }

  @override
  $AddressBookTable createAlias(String alias) {
    return $AddressBookTable(attachedDatabase, alias);
  }
}

class AddressRow extends DataClass implements Insertable<AddressRow> {
  /// Lower-cased address.
  final String email;
  final String? name;
  final int seenCount;
  final int sentCount;
  final int lastUsedAt;
  const AddressRow({
    required this.email,
    this.name,
    required this.seenCount,
    required this.sentCount,
    required this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['seen_count'] = Variable<int>(seenCount);
    map['sent_count'] = Variable<int>(sentCount);
    map['last_used_at'] = Variable<int>(lastUsedAt);
    return map;
  }

  AddressBookCompanion toCompanion(bool nullToAbsent) {
    return AddressBookCompanion(
      email: Value(email),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      seenCount: Value(seenCount),
      sentCount: Value(sentCount),
      lastUsedAt: Value(lastUsedAt),
    );
  }

  factory AddressRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AddressRow(
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String?>(json['name']),
      seenCount: serializer.fromJson<int>(json['seenCount']),
      sentCount: serializer.fromJson<int>(json['sentCount']),
      lastUsedAt: serializer.fromJson<int>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String?>(name),
      'seenCount': serializer.toJson<int>(seenCount),
      'sentCount': serializer.toJson<int>(sentCount),
      'lastUsedAt': serializer.toJson<int>(lastUsedAt),
    };
  }

  AddressRow copyWith({
    String? email,
    Value<String?> name = const Value.absent(),
    int? seenCount,
    int? sentCount,
    int? lastUsedAt,
  }) => AddressRow(
    email: email ?? this.email,
    name: name.present ? name.value : this.name,
    seenCount: seenCount ?? this.seenCount,
    sentCount: sentCount ?? this.sentCount,
    lastUsedAt: lastUsedAt ?? this.lastUsedAt,
  );
  AddressRow copyWithCompanion(AddressBookCompanion data) {
    return AddressRow(
      email: data.email.present ? data.email.value : this.email,
      name: data.name.present ? data.name.value : this.name,
      seenCount: data.seenCount.present ? data.seenCount.value : this.seenCount,
      sentCount: data.sentCount.present ? data.sentCount.value : this.sentCount,
      lastUsedAt: data.lastUsedAt.present ? data.lastUsedAt.value : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AddressRow(')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('seenCount: $seenCount, ')
          ..write('sentCount: $sentCount, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(email, name, seenCount, sentCount, lastUsedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressRow &&
          other.email == this.email &&
          other.name == this.name &&
          other.seenCount == this.seenCount &&
          other.sentCount == this.sentCount &&
          other.lastUsedAt == this.lastUsedAt);
}

class AddressBookCompanion extends UpdateCompanion<AddressRow> {
  final Value<String> email;
  final Value<String?> name;
  final Value<int> seenCount;
  final Value<int> sentCount;
  final Value<int> lastUsedAt;
  final Value<int> rowid;
  const AddressBookCompanion({
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.seenCount = const Value.absent(),
    this.sentCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AddressBookCompanion.insert({
    required String email,
    this.name = const Value.absent(),
    this.seenCount = const Value.absent(),
    this.sentCount = const Value.absent(),
    required int lastUsedAt,
    this.rowid = const Value.absent(),
  }) : email = Value(email),
       lastUsedAt = Value(lastUsedAt);
  static Insertable<AddressRow> custom({
    Expression<String>? email,
    Expression<String>? name,
    Expression<int>? seenCount,
    Expression<int>? sentCount,
    Expression<int>? lastUsedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (seenCount != null) 'seen_count': seenCount,
      if (sentCount != null) 'sent_count': sentCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AddressBookCompanion copyWith({
    Value<String>? email,
    Value<String?>? name,
    Value<int>? seenCount,
    Value<int>? sentCount,
    Value<int>? lastUsedAt,
    Value<int>? rowid,
  }) {
    return AddressBookCompanion(
      email: email ?? this.email,
      name: name ?? this.name,
      seenCount: seenCount ?? this.seenCount,
      sentCount: sentCount ?? this.sentCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (seenCount.present) {
      map['seen_count'] = Variable<int>(seenCount.value);
    }
    if (sentCount.present) {
      map['sent_count'] = Variable<int>(sentCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<int>(lastUsedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressBookCompanion(')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('seenCount: $seenCount, ')
          ..write('sentCount: $sentCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThreadRefsTable extends ThreadRefs with TableInfo<$ThreadRefsTable, ThreadRefRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThreadRefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES accounts (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _messageIdMeta = const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta('threadId');
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [accountId, messageId, threadId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'thread_refs';
  @override
  VerificationContext validateIntegrity(Insertable<ThreadRefRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta, messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(_threadIdMeta, threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta));
    } else if (isInserting) {
      context.missing(_threadIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId, messageId};
  @override
  ThreadRefRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThreadRefRow(
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}account_id'])!,
      messageId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}message_id'])!,
      threadId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}thread_id'])!,
    );
  }

  @override
  $ThreadRefsTable createAlias(String alias) {
    return $ThreadRefsTable(attachedDatabase, alias);
  }
}

class ThreadRefRow extends DataClass implements Insertable<ThreadRefRow> {
  final String accountId;
  final String messageId;
  final String threadId;
  const ThreadRefRow({required this.accountId, required this.messageId, required this.threadId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['message_id'] = Variable<String>(messageId);
    map['thread_id'] = Variable<String>(threadId);
    return map;
  }

  ThreadRefsCompanion toCompanion(bool nullToAbsent) {
    return ThreadRefsCompanion(accountId: Value(accountId), messageId: Value(messageId), threadId: Value(threadId));
  }

  factory ThreadRefRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThreadRefRow(
      accountId: serializer.fromJson<String>(json['accountId']),
      messageId: serializer.fromJson<String>(json['messageId']),
      threadId: serializer.fromJson<String>(json['threadId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'messageId': serializer.toJson<String>(messageId),
      'threadId': serializer.toJson<String>(threadId),
    };
  }

  ThreadRefRow copyWith({String? accountId, String? messageId, String? threadId}) => ThreadRefRow(
    accountId: accountId ?? this.accountId,
    messageId: messageId ?? this.messageId,
    threadId: threadId ?? this.threadId,
  );
  ThreadRefRow copyWithCompanion(ThreadRefsCompanion data) {
    return ThreadRefRow(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThreadRefRow(')
          ..write('accountId: $accountId, ')
          ..write('messageId: $messageId, ')
          ..write('threadId: $threadId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(accountId, messageId, threadId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThreadRefRow &&
          other.accountId == this.accountId &&
          other.messageId == this.messageId &&
          other.threadId == this.threadId);
}

class ThreadRefsCompanion extends UpdateCompanion<ThreadRefRow> {
  final Value<String> accountId;
  final Value<String> messageId;
  final Value<String> threadId;
  final Value<int> rowid;
  const ThreadRefsCompanion({
    this.accountId = const Value.absent(),
    this.messageId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThreadRefsCompanion.insert({
    required String accountId,
    required String messageId,
    required String threadId,
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId),
       messageId = Value(messageId),
       threadId = Value(threadId);
  static Insertable<ThreadRefRow> custom({
    Expression<String>? accountId,
    Expression<String>? messageId,
    Expression<String>? threadId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (messageId != null) 'message_id': messageId,
      if (threadId != null) 'thread_id': threadId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThreadRefsCompanion copyWith({
    Value<String>? accountId,
    Value<String>? messageId,
    Value<String>? threadId,
    Value<int>? rowid,
  }) {
    return ThreadRefsCompanion(
      accountId: accountId ?? this.accountId,
      messageId: messageId ?? this.messageId,
      threadId: threadId ?? this.threadId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThreadRefsCompanion(')
          ..write('accountId: $accountId, ')
          ..write('messageId: $messageId, ')
          ..write('threadId: $threadId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IdAliasesTable extends IdAliases with TableInfo<$IdAliasesTable, IdAliasRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IdAliasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _oldIdMeta = const VerificationMeta('oldId');
  @override
  late final GeneratedColumn<String> oldId = GeneratedColumn<String>(
    'old_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newIdMeta = const VerificationMeta('newId');
  @override
  late final GeneratedColumn<String> newId = GeneratedColumn<String>(
    'new_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [oldId, newId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'id_aliases';
  @override
  VerificationContext validateIntegrity(Insertable<IdAliasRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('old_id')) {
      context.handle(_oldIdMeta, oldId.isAcceptableOrUnknown(data['old_id']!, _oldIdMeta));
    } else if (isInserting) {
      context.missing(_oldIdMeta);
    }
    if (data.containsKey('new_id')) {
      context.handle(_newIdMeta, newId.isAcceptableOrUnknown(data['new_id']!, _newIdMeta));
    } else if (isInserting) {
      context.missing(_newIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {oldId};
  @override
  IdAliasRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IdAliasRow(
      oldId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}old_id'])!,
      newId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}new_id'])!,
    );
  }

  @override
  $IdAliasesTable createAlias(String alias) {
    return $IdAliasesTable(attachedDatabase, alias);
  }
}

class IdAliasRow extends DataClass implements Insertable<IdAliasRow> {
  final String oldId;
  final String newId;
  const IdAliasRow({required this.oldId, required this.newId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['old_id'] = Variable<String>(oldId);
    map['new_id'] = Variable<String>(newId);
    return map;
  }

  IdAliasesCompanion toCompanion(bool nullToAbsent) {
    return IdAliasesCompanion(oldId: Value(oldId), newId: Value(newId));
  }

  factory IdAliasRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IdAliasRow(
      oldId: serializer.fromJson<String>(json['oldId']),
      newId: serializer.fromJson<String>(json['newId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'oldId': serializer.toJson<String>(oldId), 'newId': serializer.toJson<String>(newId)};
  }

  IdAliasRow copyWith({String? oldId, String? newId}) =>
      IdAliasRow(oldId: oldId ?? this.oldId, newId: newId ?? this.newId);
  IdAliasRow copyWithCompanion(IdAliasesCompanion data) {
    return IdAliasRow(
      oldId: data.oldId.present ? data.oldId.value : this.oldId,
      newId: data.newId.present ? data.newId.value : this.newId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IdAliasRow(')
          ..write('oldId: $oldId, ')
          ..write('newId: $newId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(oldId, newId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is IdAliasRow && other.oldId == this.oldId && other.newId == this.newId);
}

class IdAliasesCompanion extends UpdateCompanion<IdAliasRow> {
  final Value<String> oldId;
  final Value<String> newId;
  final Value<int> rowid;
  const IdAliasesCompanion({
    this.oldId = const Value.absent(),
    this.newId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IdAliasesCompanion.insert({required String oldId, required String newId, this.rowid = const Value.absent()})
    : oldId = Value(oldId),
      newId = Value(newId);
  static Insertable<IdAliasRow> custom({Expression<String>? oldId, Expression<String>? newId, Expression<int>? rowid}) {
    return RawValuesInsertable({
      if (oldId != null) 'old_id': oldId,
      if (newId != null) 'new_id': newId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IdAliasesCompanion copyWith({Value<String>? oldId, Value<String>? newId, Value<int>? rowid}) {
    return IdAliasesCompanion(oldId: oldId ?? this.oldId, newId: newId ?? this.newId, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (oldId.present) {
      map['old_id'] = Variable<String>(oldId.value);
    }
    if (newId.present) {
      map['new_id'] = Variable<String>(newId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IdAliasesCompanion(')
          ..write('oldId: $oldId, ')
          ..write('newId: $newId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RulesTable extends Rules with TableInfo<$RulesTable, RuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, json, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rules';
  @override
  VerificationContext validateIntegrity(Insertable<RuleRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json')) {
      context.handle(_jsonMeta, json.isAcceptableOrUnknown(data['json']!, _jsonMeta));
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta, sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleRow(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      json: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}json'])!,
      sortOrder: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $RulesTable createAlias(String alias) {
    return $RulesTable(attachedDatabase, alias);
  }
}

class RuleRow extends DataClass implements Insertable<RuleRow> {
  final String id;
  final String json;
  final int sortOrder;
  const RuleRow({required this.id, required this.json, required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['json'] = Variable<String>(json);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RulesCompanion toCompanion(bool nullToAbsent) {
    return RulesCompanion(id: Value(id), json: Value(json), sortOrder: Value(sortOrder));
  }

  factory RuleRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleRow(
      id: serializer.fromJson<String>(json['id']),
      json: serializer.fromJson<String>(json['json']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'json': serializer.toJson<String>(json),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RuleRow copyWith({String? id, String? json, int? sortOrder}) =>
      RuleRow(id: id ?? this.id, json: json ?? this.json, sortOrder: sortOrder ?? this.sortOrder);
  RuleRow copyWithCompanion(RulesCompanion data) {
    return RuleRow(
      id: data.id.present ? data.id.value : this.id,
      json: data.json.present ? data.json.value : this.json,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleRow(')
          ..write('id: $id, ')
          ..write('json: $json, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, json, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleRow && other.id == this.id && other.json == this.json && other.sortOrder == this.sortOrder);
}

class RulesCompanion extends UpdateCompanion<RuleRow> {
  final Value<String> id;
  final Value<String> json;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RulesCompanion({
    this.id = const Value.absent(),
    this.json = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RulesCompanion.insert({
    required String id,
    required String json,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       json = Value(json);
  static Insertable<RuleRow> custom({
    Expression<String>? id,
    Expression<String>? json,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (json != null) 'json': json,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RulesCompanion copyWith({Value<String>? id, Value<String>? json, Value<int>? sortOrder, Value<int>? rowid}) {
    return RulesCompanion(
      id: id ?? this.id,
      json: json ?? this.json,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RulesCompanion(')
          ..write('id: $id, ')
          ..write('json: $json, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RuleWatermarksTable extends RuleWatermarks with TableInfo<$RuleWatermarksTable, RuleWatermarkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RuleWatermarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta('mailboxId');
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES mailboxes (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uidValidityMeta = const VerificationMeta('uidValidity');
  @override
  late final GeneratedColumn<int> uidValidity = GeneratedColumn<int>(
    'uid_validity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<int> uid = GeneratedColumn<int>(
    'uid',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [mailboxId, seq, uidValidity, uid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rule_watermarks';
  @override
  VerificationContext validateIntegrity(Insertable<RuleWatermarkRow> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mailbox_id')) {
      context.handle(_mailboxIdMeta, mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta));
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(_seqMeta, seq.isAcceptableOrUnknown(data['seq']!, _seqMeta));
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('uid_validity')) {
      context.handle(_uidValidityMeta, uidValidity.isAcceptableOrUnknown(data['uid_validity']!, _uidValidityMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(_uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mailboxId};
  @override
  RuleWatermarkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RuleWatermarkRow(
      mailboxId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}mailbox_id'])!,
      seq: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}seq'])!,
      uidValidity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}uid_validity']),
      uid: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}uid']),
    );
  }

  @override
  $RuleWatermarksTable createAlias(String alias) {
    return $RuleWatermarksTable(attachedDatabase, alias);
  }
}

class RuleWatermarkRow extends DataClass implements Insertable<RuleWatermarkRow> {
  final String mailboxId;
  final int seq;
  final int? uidValidity;
  final int? uid;
  const RuleWatermarkRow({required this.mailboxId, required this.seq, this.uidValidity, this.uid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['seq'] = Variable<int>(seq);
    if (!nullToAbsent || uidValidity != null) {
      map['uid_validity'] = Variable<int>(uidValidity);
    }
    if (!nullToAbsent || uid != null) {
      map['uid'] = Variable<int>(uid);
    }
    return map;
  }

  RuleWatermarksCompanion toCompanion(bool nullToAbsent) {
    return RuleWatermarksCompanion(
      mailboxId: Value(mailboxId),
      seq: Value(seq),
      uidValidity: uidValidity == null && nullToAbsent ? const Value.absent() : Value(uidValidity),
      uid: uid == null && nullToAbsent ? const Value.absent() : Value(uid),
    );
  }

  factory RuleWatermarkRow.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RuleWatermarkRow(
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      seq: serializer.fromJson<int>(json['seq']),
      uidValidity: serializer.fromJson<int?>(json['uidValidity']),
      uid: serializer.fromJson<int?>(json['uid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mailboxId': serializer.toJson<String>(mailboxId),
      'seq': serializer.toJson<int>(seq),
      'uidValidity': serializer.toJson<int?>(uidValidity),
      'uid': serializer.toJson<int?>(uid),
    };
  }

  RuleWatermarkRow copyWith({
    String? mailboxId,
    int? seq,
    Value<int?> uidValidity = const Value.absent(),
    Value<int?> uid = const Value.absent(),
  }) => RuleWatermarkRow(
    mailboxId: mailboxId ?? this.mailboxId,
    seq: seq ?? this.seq,
    uidValidity: uidValidity.present ? uidValidity.value : this.uidValidity,
    uid: uid.present ? uid.value : this.uid,
  );
  RuleWatermarkRow copyWithCompanion(RuleWatermarksCompanion data) {
    return RuleWatermarkRow(
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      seq: data.seq.present ? data.seq.value : this.seq,
      uidValidity: data.uidValidity.present ? data.uidValidity.value : this.uidValidity,
      uid: data.uid.present ? data.uid.value : this.uid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RuleWatermarkRow(')
          ..write('mailboxId: $mailboxId, ')
          ..write('seq: $seq, ')
          ..write('uidValidity: $uidValidity, ')
          ..write('uid: $uid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(mailboxId, seq, uidValidity, uid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RuleWatermarkRow &&
          other.mailboxId == this.mailboxId &&
          other.seq == this.seq &&
          other.uidValidity == this.uidValidity &&
          other.uid == this.uid);
}

class RuleWatermarksCompanion extends UpdateCompanion<RuleWatermarkRow> {
  final Value<String> mailboxId;
  final Value<int> seq;
  final Value<int?> uidValidity;
  final Value<int?> uid;
  final Value<int> rowid;
  const RuleWatermarksCompanion({
    this.mailboxId = const Value.absent(),
    this.seq = const Value.absent(),
    this.uidValidity = const Value.absent(),
    this.uid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RuleWatermarksCompanion.insert({
    required String mailboxId,
    required int seq,
    this.uidValidity = const Value.absent(),
    this.uid = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mailboxId = Value(mailboxId),
       seq = Value(seq);
  static Insertable<RuleWatermarkRow> custom({
    Expression<String>? mailboxId,
    Expression<int>? seq,
    Expression<int>? uidValidity,
    Expression<int>? uid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (seq != null) 'seq': seq,
      if (uidValidity != null) 'uid_validity': uidValidity,
      if (uid != null) 'uid': uid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RuleWatermarksCompanion copyWith({
    Value<String>? mailboxId,
    Value<int>? seq,
    Value<int?>? uidValidity,
    Value<int?>? uid,
    Value<int>? rowid,
  }) {
    return RuleWatermarksCompanion(
      mailboxId: mailboxId ?? this.mailboxId,
      seq: seq ?? this.seq,
      uidValidity: uidValidity ?? this.uidValidity,
      uid: uid ?? this.uid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (uidValidity.present) {
      map['uid_validity'] = Variable<int>(uidValidity.value);
    }
    if (uid.present) {
      map['uid'] = Variable<int>(uid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RuleWatermarksCompanion(')
          ..write('mailboxId: $mailboxId, ')
          ..write('seq: $seq, ')
          ..write('uidValidity: $uidValidity, ')
          ..write('uid: $uid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$StoreDatabase extends GeneratedDatabase {
  _$StoreDatabase(QueryExecutor e) : super(e);
  $StoreDatabaseManager get managers => $StoreDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $MailboxesTable mailboxes = $MailboxesTable(this);
  late final $SyncStatesTable syncStates = $SyncStatesTable(this);
  late final $EmailsTable emails = $EmailsTable(this);
  late final $EmailKeywordsTable emailKeywords = $EmailKeywordsTable(this);
  late final $ContentsTable contents = $ContentsTable(this);
  late final $InlinePartsTable inlineParts = $InlinePartsTable(this);
  late final $OutboxItemsTable outboxItems = $OutboxItemsTable(this);
  late final $PendingOpsTable pendingOps = $PendingOpsTable(this);
  late final $VipAddressesTable vipAddresses = $VipAddressesTable(this);
  late final $AddressBookTable addressBook = $AddressBookTable(this);
  late final $ThreadRefsTable threadRefs = $ThreadRefsTable(this);
  late final $IdAliasesTable idAliases = $IdAliasesTable(this);
  late final $RulesTable rules = $RulesTable(this);
  late final $RuleWatermarksTable ruleWatermarks = $RuleWatermarksTable(this);
  late final Index emailsMailboxReceived = Index(
    'emails_mailbox_received',
    'CREATE INDEX emails_mailbox_received ON emails (mailbox_id, received_at)',
  );
  late final Index emailsReceived = Index('emails_received', 'CREATE INDEX emails_received ON emails (received_at)');
  late final Index emailsThread = Index(
    'emails_thread',
    'CREATE INDEX emails_thread ON emails (account_id, thread_id)',
  );
  late final Index emailsMessageId = Index(
    'emails_message_id',
    'CREATE INDEX emails_message_id ON emails (account_id, message_id_header)',
  );
  late final Index emailsBaseSubject = Index(
    'emails_base_subject',
    'CREATE INDEX emails_base_subject ON emails (account_id, base_subject, received_at)',
  );
  late final Index emailsFrom = Index('emails_from', 'CREATE INDEX emails_from ON emails (from_email)');
  late final Index emailKeywordsKeyword = Index(
    'email_keywords_keyword',
    'CREATE INDEX email_keywords_keyword ON email_keywords (keyword)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    mailboxes,
    syncStates,
    emails,
    emailKeywords,
    contents,
    inlineParts,
    outboxItems,
    pendingOps,
    vipAddresses,
    addressBook,
    threadRefs,
    idAliases,
    rules,
    ruleWatermarks,
    emailsMailboxReceived,
    emailsReceived,
    emailsThread,
    emailsMessageId,
    emailsBaseSubject,
    emailsFrom,
    emailKeywordsKeyword,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName('accounts', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('mailboxes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('mailboxes', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('sync_states', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('mailboxes', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('emails', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('email_keywords', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.update),
      result: [TableUpdate('email_keywords', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('contents', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.update),
      result: [TableUpdate('contents', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('inline_parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('emails', limitUpdateKind: UpdateKind.update),
      result: [TableUpdate('inline_parts', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('accounts', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('outbox_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('accounts', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('pending_ops', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('accounts', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('thread_refs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName('mailboxes', limitUpdateKind: UpdateKind.delete),
      result: [TableUpdate('rule_watermarks', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  required String email,
  required String displayName,
  required String json,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> email,
  Value<String> displayName,
  Value<String> json,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$AccountsTableReferences extends BaseReferences<_$StoreDatabase, $AccountsTable, AccountRow> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MailboxesTable, List<MailboxRow>> _mailboxesRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.mailboxes, aliasName: 'accounts__id__mailboxes__account_id');

  $$MailboxesTableProcessedTableManager get mailboxesRefs {
    final manager = $$MailboxesTableTableManager(
      $_db,
      $_db.mailboxes,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mailboxesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OutboxItemsTable, List<OutboxRow>> _outboxItemsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.outboxItems, aliasName: 'accounts__id__outbox_items__account_id');

  $$OutboxItemsTableProcessedTableManager get outboxItemsRefs {
    final manager = $$OutboxItemsTableTableManager(
      $_db,
      $_db.outboxItems,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_outboxItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PendingOpsTable, List<PendingOpRow>> _pendingOpsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.pendingOps, aliasName: 'accounts__id__pending_ops__account_id');

  $$PendingOpsTableProcessedTableManager get pendingOpsRefs {
    final manager = $$PendingOpsTableTableManager(
      $_db,
      $_db.pendingOps,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pendingOpsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ThreadRefsTable, List<ThreadRefRow>> _threadRefsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.threadRefs, aliasName: 'accounts__id__thread_refs__account_id');

  $$ThreadRefsTableProcessedTableManager get threadRefsRefs {
    final manager = $$ThreadRefsTableTableManager(
      $_db,
      $_db.threadRefs,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_threadRefsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountsTableFilterComposer extends Composer<_$StoreDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName =>
      $composableBuilder(column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get json => $composableBuilder(column: $table.json, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> mailboxesRefs(Expression<bool> Function($$MailboxesTableFilterComposer f) f) {
    final $$MailboxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableFilterComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> outboxItemsRefs(Expression<bool> Function($$OutboxItemsTableFilterComposer f) f) {
    final $$OutboxItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outboxItems,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OutboxItemsTableFilterComposer(
            $db: $db,
            $table: $db.outboxItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pendingOpsRefs(Expression<bool> Function($$PendingOpsTableFilterComposer f) f) {
    final $$PendingOpsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pendingOps,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PendingOpsTableFilterComposer(
            $db: $db,
            $table: $db.pendingOps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> threadRefsRefs(Expression<bool> Function($$ThreadRefsTableFilterComposer f) f) {
    final $$ThreadRefsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.threadRefs,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ThreadRefsTableFilterComposer(
            $db: $db,
            $table: $db.threadRefs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer extends Composer<_$StoreDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName =>
      $composableBuilder(column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableAnnotationComposer extends Composer<_$StoreDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get displayName =>
      $composableBuilder(column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get json => $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<int> get sortOrder => $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> mailboxesRefs<T extends Object>(Expression<T> Function($$MailboxesTableAnnotationComposer a) f) {
    final $$MailboxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableAnnotationComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> outboxItemsRefs<T extends Object>(Expression<T> Function($$OutboxItemsTableAnnotationComposer a) f) {
    final $$OutboxItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.outboxItems,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$OutboxItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.outboxItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pendingOpsRefs<T extends Object>(Expression<T> Function($$PendingOpsTableAnnotationComposer a) f) {
    final $$PendingOpsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pendingOps,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PendingOpsTableAnnotationComposer(
            $db: $db,
            $table: $db.pendingOps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> threadRefsRefs<T extends Object>(Expression<T> Function($$ThreadRefsTableAnnotationComposer a) f) {
    final $$ThreadRefsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.threadRefs,
      getReferencedColumn: (t) => t.accountId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ThreadRefsTableAnnotationComposer(
            $db: $db,
            $table: $db.threadRefs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $AccountsTable,
          AccountRow,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (AccountRow, $$AccountsTableReferences),
          AccountRow,
          PrefetchHooks Function({bool mailboxesRefs, bool outboxItemsRefs, bool pendingOpsRefs, bool threadRefsRefs})
        > {
  $$AccountsTableTableManager(_$StoreDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                email: email,
                displayName: displayName,
                json: json,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String displayName,
                required String json,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                email: email,
                displayName: displayName,
                json: json,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$AccountsTable, AccountRow>(table), $$AccountsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({mailboxesRefs = false, outboxItemsRefs = false, pendingOpsRefs = false, threadRefsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mailboxesRefs) db.mailboxes,
                    if (outboxItemsRefs) db.outboxItems,
                    if (pendingOpsRefs) db.pendingOps,
                    if (threadRefsRefs) db.threadRefs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mailboxesRefs)
                        await $_getPrefetchedData<AccountRow, $AccountsTable, MailboxRow>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences._mailboxesRefsTable(db),
                          managerFromTypedResult: (p0) => $$AccountsTableReferences(db, table, p0).mailboxesRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.accountId == item.id),
                          typedResults: items,
                        ),
                      if (outboxItemsRefs)
                        await $_getPrefetchedData<AccountRow, $AccountsTable, OutboxRow>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences._outboxItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $$AccountsTableReferences(db, table, p0).outboxItemsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.accountId == item.id),
                          typedResults: items,
                        ),
                      if (pendingOpsRefs)
                        await $_getPrefetchedData<AccountRow, $AccountsTable, PendingOpRow>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences._pendingOpsRefsTable(db),
                          managerFromTypedResult: (p0) => $$AccountsTableReferences(db, table, p0).pendingOpsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.accountId == item.id),
                          typedResults: items,
                        ),
                      if (threadRefsRefs)
                        await $_getPrefetchedData<AccountRow, $AccountsTable, ThreadRefRow>(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences._threadRefsRefsTable(db),
                          managerFromTypedResult: (p0) => $$AccountsTableReferences(db, table, p0).threadRefsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.accountId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $AccountsTable,
      AccountRow,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (AccountRow, $$AccountsTableReferences),
      AccountRow,
      PrefetchHooks Function({bool mailboxesRefs, bool outboxItemsRefs, bool pendingOpsRefs, bool threadRefsRefs})
    >;
typedef $$MailboxesTableCreateCompanionBuilder = MailboxesCompanion Function({
  required String id,
  required String accountId,
  required String name,
  required String path,
  required String role,
  Value<String?> parentId,
  Value<int> unreadCount,
  Value<int> totalCount,
  Value<bool> isSelectable,
  Value<bool> isSubscribed,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$MailboxesTableUpdateCompanionBuilder = MailboxesCompanion Function({
  Value<String> id,
  Value<String> accountId,
  Value<String> name,
  Value<String> path,
  Value<String> role,
  Value<String?> parentId,
  Value<int> unreadCount,
  Value<int> totalCount,
  Value<bool> isSelectable,
  Value<bool> isSubscribed,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$MailboxesTableReferences extends BaseReferences<_$StoreDatabase, $MailboxesTable, MailboxRow> {
  $$MailboxesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$StoreDatabase db) =>
      db.accounts.createAlias('mailboxes__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SyncStatesTable, List<SyncStateRow>> _syncStatesRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.syncStates, aliasName: 'mailboxes__id__sync_states__mailbox_id');

  $$SyncStatesTableProcessedTableManager get syncStatesRefs {
    final manager = $$SyncStatesTableTableManager(
      $_db,
      $_db.syncStates,
    ).filter((f) => f.mailboxId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_syncStatesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EmailsTable, List<EmailRow>> _emailsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.emails, aliasName: 'mailboxes__id__emails__mailbox_id');

  $$EmailsTableProcessedTableManager get emailsRefs {
    final manager = $$EmailsTableTableManager(
      $_db,
      $_db.emails,
    ).filter((f) => f.mailboxId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_emailsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RuleWatermarksTable, List<RuleWatermarkRow>> _ruleWatermarksRefsTable(
    _$StoreDatabase db,
  ) => MultiTypedResultKey.fromTable(db.ruleWatermarks, aliasName: 'mailboxes__id__rule_watermarks__mailbox_id');

  $$RuleWatermarksTableProcessedTableManager get ruleWatermarksRefs {
    final manager = $$RuleWatermarksTableTableManager(
      $_db,
      $_db.ruleWatermarks,
    ).filter((f) => f.mailboxId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ruleWatermarksRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MailboxesTableFilterComposer extends Composer<_$StoreDatabase, $MailboxesTable> {
  $$MailboxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unreadCount =>
      $composableBuilder(column: $table.unreadCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalCount =>
      $composableBuilder(column: $table.totalCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSelectable =>
      $composableBuilder(column: $table.isSelectable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSubscribed =>
      $composableBuilder(column: $table.isSubscribed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> syncStatesRefs(Expression<bool> Function($$SyncStatesTableFilterComposer f) f) {
    final $$SyncStatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncStates,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SyncStatesTableFilterComposer(
            $db: $db,
            $table: $db.syncStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> emailsRefs(Expression<bool> Function($$EmailsTableFilterComposer f) f) {
    final $$EmailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableFilterComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ruleWatermarksRefs(Expression<bool> Function($$RuleWatermarksTableFilterComposer f) f) {
    final $$RuleWatermarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleWatermarks,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RuleWatermarksTableFilterComposer(
            $db: $db,
            $table: $db.ruleWatermarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MailboxesTableOrderingComposer extends Composer<_$StoreDatabase, $MailboxesTable> {
  $$MailboxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unreadCount =>
      $composableBuilder(column: $table.unreadCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalCount =>
      $composableBuilder(column: $table.totalCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSelectable =>
      $composableBuilder(column: $table.isSelectable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSubscribed =>
      $composableBuilder(column: $table.isSubscribed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MailboxesTableAnnotationComposer extends Composer<_$StoreDatabase, $MailboxesTable> {
  $$MailboxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path => $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get role => $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get parentId => $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(column: $table.unreadCount, builder: (column) => column);

  GeneratedColumn<int> get totalCount => $composableBuilder(column: $table.totalCount, builder: (column) => column);

  GeneratedColumn<bool> get isSelectable =>
      $composableBuilder(column: $table.isSelectable, builder: (column) => column);

  GeneratedColumn<bool> get isSubscribed =>
      $composableBuilder(column: $table.isSubscribed, builder: (column) => column);

  GeneratedColumn<int> get sortOrder => $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> syncStatesRefs<T extends Object>(Expression<T> Function($$SyncStatesTableAnnotationComposer a) f) {
    final $$SyncStatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.syncStates,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SyncStatesTableAnnotationComposer(
            $db: $db,
            $table: $db.syncStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> emailsRefs<T extends Object>(Expression<T> Function($$EmailsTableAnnotationComposer a) f) {
    final $$EmailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableAnnotationComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ruleWatermarksRefs<T extends Object>(
    Expression<T> Function($$RuleWatermarksTableAnnotationComposer a) f,
  ) {
    final $$RuleWatermarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ruleWatermarks,
      getReferencedColumn: (t) => t.mailboxId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$RuleWatermarksTableAnnotationComposer(
            $db: $db,
            $table: $db.ruleWatermarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MailboxesTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $MailboxesTable,
          MailboxRow,
          $$MailboxesTableFilterComposer,
          $$MailboxesTableOrderingComposer,
          $$MailboxesTableAnnotationComposer,
          $$MailboxesTableCreateCompanionBuilder,
          $$MailboxesTableUpdateCompanionBuilder,
          (MailboxRow, $$MailboxesTableReferences),
          MailboxRow,
          PrefetchHooks Function({bool accountId, bool syncStatesRefs, bool emailsRefs, bool ruleWatermarksRefs})
        > {
  $$MailboxesTableTableManager(_$StoreDatabase db, $MailboxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$MailboxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$MailboxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$MailboxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<bool> isSelectable = const Value.absent(),
                Value<bool> isSubscribed = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MailboxesCompanion(
                id: id,
                accountId: accountId,
                name: name,
                path: path,
                role: role,
                parentId: parentId,
                unreadCount: unreadCount,
                totalCount: totalCount,
                isSelectable: isSelectable,
                isSubscribed: isSubscribed,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String name,
                required String path,
                required String role,
                Value<String?> parentId = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<bool> isSelectable = const Value.absent(),
                Value<bool> isSubscribed = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MailboxesCompanion.insert(
                id: id,
                accountId: accountId,
                name: name,
                path: path,
                role: role,
                parentId: parentId,
                unreadCount: unreadCount,
                totalCount: totalCount,
                isSelectable: isSelectable,
                isSubscribed: isSubscribed,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$MailboxesTable, MailboxRow>(table), $$MailboxesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, syncStatesRefs = false, emailsRefs = false, ruleWatermarksRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (syncStatesRefs) db.syncStates,
                    if (emailsRefs) db.emails,
                    if (ruleWatermarksRefs) db.ruleWatermarks,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$MailboxesTableReferences._accountIdTable(db),
                            referencedColumn: $$MailboxesTableReferences._accountIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (syncStatesRefs)
                        await $_getPrefetchedData<MailboxRow, $MailboxesTable, SyncStateRow>(
                          currentTable: table,
                          referencedTable: $$MailboxesTableReferences._syncStatesRefsTable(db),
                          managerFromTypedResult: (p0) => $$MailboxesTableReferences(db, table, p0).syncStatesRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.mailboxId == item.id),
                          typedResults: items,
                        ),
                      if (emailsRefs)
                        await $_getPrefetchedData<MailboxRow, $MailboxesTable, EmailRow>(
                          currentTable: table,
                          referencedTable: $$MailboxesTableReferences._emailsRefsTable(db),
                          managerFromTypedResult: (p0) => $$MailboxesTableReferences(db, table, p0).emailsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.mailboxId == item.id),
                          typedResults: items,
                        ),
                      if (ruleWatermarksRefs)
                        await $_getPrefetchedData<MailboxRow, $MailboxesTable, RuleWatermarkRow>(
                          currentTable: table,
                          referencedTable: $$MailboxesTableReferences._ruleWatermarksRefsTable(db),
                          managerFromTypedResult: (p0) => $$MailboxesTableReferences(db, table, p0).ruleWatermarksRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.mailboxId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MailboxesTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $MailboxesTable,
      MailboxRow,
      $$MailboxesTableFilterComposer,
      $$MailboxesTableOrderingComposer,
      $$MailboxesTableAnnotationComposer,
      $$MailboxesTableCreateCompanionBuilder,
      $$MailboxesTableUpdateCompanionBuilder,
      (MailboxRow, $$MailboxesTableReferences),
      MailboxRow,
      PrefetchHooks Function({bool accountId, bool syncStatesRefs, bool emailsRefs, bool ruleWatermarksRefs})
    >;
typedef $$SyncStatesTableCreateCompanionBuilder = SyncStatesCompanion Function({
  required String mailboxId,
  required String state,
  Value<bool> hasOlder,
  required int syncedAt,
  Value<int> rowid,
});
typedef $$SyncStatesTableUpdateCompanionBuilder = SyncStatesCompanion Function({
  Value<String> mailboxId,
  Value<String> state,
  Value<bool> hasOlder,
  Value<int> syncedAt,
  Value<int> rowid,
});

final class $$SyncStatesTableReferences extends BaseReferences<_$StoreDatabase, $SyncStatesTable, SyncStateRow> {
  $$SyncStatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MailboxesTable _mailboxIdTable(_$StoreDatabase db) =>
      db.mailboxes.createAlias('sync_states__mailbox_id__mailboxes__id');

  $$MailboxesTableProcessedTableManager get mailboxId {
    final $_column = $_itemColumn<String>('mailbox_id')!;

    final manager = $$MailboxesTableTableManager($_db, $_db.mailboxes).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mailboxIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SyncStatesTableFilterComposer extends Composer<_$StoreDatabase, $SyncStatesTable> {
  $$SyncStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasOlder =>
      $composableBuilder(column: $table.hasOlder, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  $$MailboxesTableFilterComposer get mailboxId {
    final $$MailboxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableFilterComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStatesTableOrderingComposer extends Composer<_$StoreDatabase, $SyncStatesTable> {
  $$SyncStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasOlder =>
      $composableBuilder(column: $table.hasOlder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  $$MailboxesTableOrderingComposer get mailboxId {
    final $$MailboxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableOrderingComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStatesTableAnnotationComposer extends Composer<_$StoreDatabase, $SyncStatesTable> {
  $$SyncStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get state => $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<bool> get hasOlder => $composableBuilder(column: $table.hasOlder, builder: (column) => column);

  GeneratedColumn<int> get syncedAt => $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  $$MailboxesTableAnnotationComposer get mailboxId {
    final $$MailboxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableAnnotationComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SyncStatesTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $SyncStatesTable,
          SyncStateRow,
          $$SyncStatesTableFilterComposer,
          $$SyncStatesTableOrderingComposer,
          $$SyncStatesTableAnnotationComposer,
          $$SyncStatesTableCreateCompanionBuilder,
          $$SyncStatesTableUpdateCompanionBuilder,
          (SyncStateRow, $$SyncStatesTableReferences),
          SyncStateRow,
          PrefetchHooks Function({bool mailboxId})
        > {
  $$SyncStatesTableTableManager(_$StoreDatabase db, $SyncStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SyncStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SyncStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SyncStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mailboxId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<bool> hasOlder = const Value.absent(),
                Value<int> syncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion(
                mailboxId: mailboxId,
                state: state,
                hasOlder: hasOlder,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mailboxId,
                required String state,
                Value<bool> hasOlder = const Value.absent(),
                required int syncedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion.insert(
                mailboxId: mailboxId,
                state: state,
                hasOlder: hasOlder,
                syncedAt: syncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable<$SyncStatesTable, SyncStateRow>(table), $$SyncStatesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({mailboxId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mailboxId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mailboxId,
                        referencedTable: $$SyncStatesTableReferences._mailboxIdTable(db),
                        referencedColumn: $$SyncStatesTableReferences._mailboxIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SyncStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $SyncStatesTable,
      SyncStateRow,
      $$SyncStatesTableFilterComposer,
      $$SyncStatesTableOrderingComposer,
      $$SyncStatesTableAnnotationComposer,
      $$SyncStatesTableCreateCompanionBuilder,
      $$SyncStatesTableUpdateCompanionBuilder,
      (SyncStateRow, $$SyncStatesTableReferences),
      SyncStateRow,
      PrefetchHooks Function({bool mailboxId})
    >;
typedef $$EmailsTableCreateCompanionBuilder = EmailsCompanion Function({
  Value<int> seq,
  required String id,
  required String accountId,
  required String mailboxId,
  required String threadId,
  Value<String?> messageIdHeader,
  Value<String?> inReplyTo,
  Value<String> referencesJson,
  Value<String> fromAddrs,
  Value<String> toAddrs,
  Value<String> ccAddrs,
  Value<String> bccAddrs,
  Value<String> replyToAddrs,
  Value<String> fromEmail,
  Value<String> subject,
  Value<String> baseSubject,
  Value<String> preview,
  required int receivedAt,
  Value<int?> sentAt,
  Value<int> size,
  Value<String> keywords,
  Value<bool> isSeen,
  Value<bool> isFlagged,
  Value<bool> hasAttachment,
});
typedef $$EmailsTableUpdateCompanionBuilder = EmailsCompanion Function({
  Value<int> seq,
  Value<String> id,
  Value<String> accountId,
  Value<String> mailboxId,
  Value<String> threadId,
  Value<String?> messageIdHeader,
  Value<String?> inReplyTo,
  Value<String> referencesJson,
  Value<String> fromAddrs,
  Value<String> toAddrs,
  Value<String> ccAddrs,
  Value<String> bccAddrs,
  Value<String> replyToAddrs,
  Value<String> fromEmail,
  Value<String> subject,
  Value<String> baseSubject,
  Value<String> preview,
  Value<int> receivedAt,
  Value<int?> sentAt,
  Value<int> size,
  Value<String> keywords,
  Value<bool> isSeen,
  Value<bool> isFlagged,
  Value<bool> hasAttachment,
});

final class $$EmailsTableReferences extends BaseReferences<_$StoreDatabase, $EmailsTable, EmailRow> {
  $$EmailsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MailboxesTable _mailboxIdTable(_$StoreDatabase db) =>
      db.mailboxes.createAlias('emails__mailbox_id__mailboxes__id');

  $$MailboxesTableProcessedTableManager get mailboxId {
    final $_column = $_itemColumn<String>('mailbox_id')!;

    final manager = $$MailboxesTableTableManager($_db, $_db.mailboxes).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mailboxIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EmailKeywordsTable, List<EmailKeywordRow>> _emailKeywordsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.emailKeywords, aliasName: 'emails__id__email_keywords__email_id');

  $$EmailKeywordsTableProcessedTableManager get emailKeywordsRefs {
    final manager = $$EmailKeywordsTableTableManager(
      $_db,
      $_db.emailKeywords,
    ).filter((f) => f.emailId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_emailKeywordsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ContentsTable, List<ContentRow>> _contentsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.contents, aliasName: 'emails__id__contents__email_id');

  $$ContentsTableProcessedTableManager get contentsRefs {
    final manager = $$ContentsTableTableManager(
      $_db,
      $_db.contents,
    ).filter((f) => f.emailId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$InlinePartsTable, List<InlinePartRow>> _inlinePartsRefsTable(_$StoreDatabase db) =>
      MultiTypedResultKey.fromTable(db.inlineParts, aliasName: 'emails__id__inline_parts__email_id');

  $$InlinePartsTableProcessedTableManager get inlinePartsRefs {
    final manager = $$InlinePartsTableTableManager(
      $_db,
      $_db.inlineParts,
    ).filter((f) => f.emailId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_inlinePartsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EmailsTableFilterComposer extends Composer<_$StoreDatabase, $EmailsTable> {
  $$EmailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageIdHeader =>
      $composableBuilder(column: $table.messageIdHeader, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inReplyTo =>
      $composableBuilder(column: $table.inReplyTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referencesJson =>
      $composableBuilder(column: $table.referencesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromAddrs =>
      $composableBuilder(column: $table.fromAddrs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toAddrs =>
      $composableBuilder(column: $table.toAddrs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ccAddrs =>
      $composableBuilder(column: $table.ccAddrs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bccAddrs =>
      $composableBuilder(column: $table.bccAddrs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get replyToAddrs =>
      $composableBuilder(column: $table.replyToAddrs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromEmail =>
      $composableBuilder(column: $table.fromEmail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get baseSubject =>
      $composableBuilder(column: $table.baseSubject, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get receivedAt =>
      $composableBuilder(column: $table.receivedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get size => $composableBuilder(column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get keywords =>
      $composableBuilder(column: $table.keywords, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSeen =>
      $composableBuilder(column: $table.isSeen, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFlagged =>
      $composableBuilder(column: $table.isFlagged, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasAttachment =>
      $composableBuilder(column: $table.hasAttachment, builder: (column) => ColumnFilters(column));

  $$MailboxesTableFilterComposer get mailboxId {
    final $$MailboxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableFilterComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> emailKeywordsRefs(Expression<bool> Function($$EmailKeywordsTableFilterComposer f) f) {
    final $$EmailKeywordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emailKeywords,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailKeywordsTableFilterComposer(
            $db: $db,
            $table: $db.emailKeywords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contentsRefs(Expression<bool> Function($$ContentsTableFilterComposer f) f) {
    final $$ContentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ContentsTableFilterComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inlinePartsRefs(Expression<bool> Function($$InlinePartsTableFilterComposer f) f) {
    final $$InlinePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inlineParts,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InlinePartsTableFilterComposer(
            $db: $db,
            $table: $db.inlineParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmailsTableOrderingComposer extends Composer<_$StoreDatabase, $EmailsTable> {
  $$EmailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageIdHeader =>
      $composableBuilder(column: $table.messageIdHeader, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inReplyTo =>
      $composableBuilder(column: $table.inReplyTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referencesJson =>
      $composableBuilder(column: $table.referencesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromAddrs =>
      $composableBuilder(column: $table.fromAddrs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toAddrs =>
      $composableBuilder(column: $table.toAddrs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ccAddrs =>
      $composableBuilder(column: $table.ccAddrs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bccAddrs =>
      $composableBuilder(column: $table.bccAddrs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get replyToAddrs =>
      $composableBuilder(column: $table.replyToAddrs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromEmail =>
      $composableBuilder(column: $table.fromEmail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get baseSubject =>
      $composableBuilder(column: $table.baseSubject, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preview =>
      $composableBuilder(column: $table.preview, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get receivedAt =>
      $composableBuilder(column: $table.receivedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get keywords =>
      $composableBuilder(column: $table.keywords, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSeen =>
      $composableBuilder(column: $table.isSeen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFlagged =>
      $composableBuilder(column: $table.isFlagged, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasAttachment =>
      $composableBuilder(column: $table.hasAttachment, builder: (column) => ColumnOrderings(column));

  $$MailboxesTableOrderingComposer get mailboxId {
    final $$MailboxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableOrderingComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmailsTableAnnotationComposer extends Composer<_$StoreDatabase, $EmailsTable> {
  $$EmailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountId => $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<String> get threadId => $composableBuilder(column: $table.threadId, builder: (column) => column);

  GeneratedColumn<String> get messageIdHeader =>
      $composableBuilder(column: $table.messageIdHeader, builder: (column) => column);

  GeneratedColumn<String> get inReplyTo => $composableBuilder(column: $table.inReplyTo, builder: (column) => column);

  GeneratedColumn<String> get referencesJson =>
      $composableBuilder(column: $table.referencesJson, builder: (column) => column);

  GeneratedColumn<String> get fromAddrs => $composableBuilder(column: $table.fromAddrs, builder: (column) => column);

  GeneratedColumn<String> get toAddrs => $composableBuilder(column: $table.toAddrs, builder: (column) => column);

  GeneratedColumn<String> get ccAddrs => $composableBuilder(column: $table.ccAddrs, builder: (column) => column);

  GeneratedColumn<String> get bccAddrs => $composableBuilder(column: $table.bccAddrs, builder: (column) => column);

  GeneratedColumn<String> get replyToAddrs =>
      $composableBuilder(column: $table.replyToAddrs, builder: (column) => column);

  GeneratedColumn<String> get fromEmail => $composableBuilder(column: $table.fromEmail, builder: (column) => column);

  GeneratedColumn<String> get subject => $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get baseSubject =>
      $composableBuilder(column: $table.baseSubject, builder: (column) => column);

  GeneratedColumn<String> get preview => $composableBuilder(column: $table.preview, builder: (column) => column);

  GeneratedColumn<int> get receivedAt => $composableBuilder(column: $table.receivedAt, builder: (column) => column);

  GeneratedColumn<int> get sentAt => $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<int> get size => $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<String> get keywords => $composableBuilder(column: $table.keywords, builder: (column) => column);

  GeneratedColumn<bool> get isSeen => $composableBuilder(column: $table.isSeen, builder: (column) => column);

  GeneratedColumn<bool> get isFlagged => $composableBuilder(column: $table.isFlagged, builder: (column) => column);

  GeneratedColumn<bool> get hasAttachment =>
      $composableBuilder(column: $table.hasAttachment, builder: (column) => column);

  $$MailboxesTableAnnotationComposer get mailboxId {
    final $$MailboxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableAnnotationComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> emailKeywordsRefs<T extends Object>(
    Expression<T> Function($$EmailKeywordsTableAnnotationComposer a) f,
  ) {
    final $$EmailKeywordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.emailKeywords,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailKeywordsTableAnnotationComposer(
            $db: $db,
            $table: $db.emailKeywords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> contentsRefs<T extends Object>(Expression<T> Function($$ContentsTableAnnotationComposer a) f) {
    final $$ContentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contents,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ContentsTableAnnotationComposer(
            $db: $db,
            $table: $db.contents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inlinePartsRefs<T extends Object>(Expression<T> Function($$InlinePartsTableAnnotationComposer a) f) {
    final $$InlinePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.inlineParts,
      getReferencedColumn: (t) => t.emailId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$InlinePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.inlineParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmailsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $EmailsTable,
          EmailRow,
          $$EmailsTableFilterComposer,
          $$EmailsTableOrderingComposer,
          $$EmailsTableAnnotationComposer,
          $$EmailsTableCreateCompanionBuilder,
          $$EmailsTableUpdateCompanionBuilder,
          (EmailRow, $$EmailsTableReferences),
          EmailRow,
          PrefetchHooks Function({bool mailboxId, bool emailKeywordsRefs, bool contentsRefs, bool inlinePartsRefs})
        > {
  $$EmailsTableTableManager(_$StoreDatabase db, $EmailsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$EmailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$EmailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$EmailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> mailboxId = const Value.absent(),
                Value<String> threadId = const Value.absent(),
                Value<String?> messageIdHeader = const Value.absent(),
                Value<String?> inReplyTo = const Value.absent(),
                Value<String> referencesJson = const Value.absent(),
                Value<String> fromAddrs = const Value.absent(),
                Value<String> toAddrs = const Value.absent(),
                Value<String> ccAddrs = const Value.absent(),
                Value<String> bccAddrs = const Value.absent(),
                Value<String> replyToAddrs = const Value.absent(),
                Value<String> fromEmail = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> baseSubject = const Value.absent(),
                Value<String> preview = const Value.absent(),
                Value<int> receivedAt = const Value.absent(),
                Value<int?> sentAt = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<bool> isSeen = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<bool> hasAttachment = const Value.absent(),
              }) => EmailsCompanion(
                seq: seq,
                id: id,
                accountId: accountId,
                mailboxId: mailboxId,
                threadId: threadId,
                messageIdHeader: messageIdHeader,
                inReplyTo: inReplyTo,
                referencesJson: referencesJson,
                fromAddrs: fromAddrs,
                toAddrs: toAddrs,
                ccAddrs: ccAddrs,
                bccAddrs: bccAddrs,
                replyToAddrs: replyToAddrs,
                fromEmail: fromEmail,
                subject: subject,
                baseSubject: baseSubject,
                preview: preview,
                receivedAt: receivedAt,
                sentAt: sentAt,
                size: size,
                keywords: keywords,
                isSeen: isSeen,
                isFlagged: isFlagged,
                hasAttachment: hasAttachment,
              ),
          createCompanionCallback:
              ({
                Value<int> seq = const Value.absent(),
                required String id,
                required String accountId,
                required String mailboxId,
                required String threadId,
                Value<String?> messageIdHeader = const Value.absent(),
                Value<String?> inReplyTo = const Value.absent(),
                Value<String> referencesJson = const Value.absent(),
                Value<String> fromAddrs = const Value.absent(),
                Value<String> toAddrs = const Value.absent(),
                Value<String> ccAddrs = const Value.absent(),
                Value<String> bccAddrs = const Value.absent(),
                Value<String> replyToAddrs = const Value.absent(),
                Value<String> fromEmail = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> baseSubject = const Value.absent(),
                Value<String> preview = const Value.absent(),
                required int receivedAt,
                Value<int?> sentAt = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<String> keywords = const Value.absent(),
                Value<bool> isSeen = const Value.absent(),
                Value<bool> isFlagged = const Value.absent(),
                Value<bool> hasAttachment = const Value.absent(),
              }) => EmailsCompanion.insert(
                seq: seq,
                id: id,
                accountId: accountId,
                mailboxId: mailboxId,
                threadId: threadId,
                messageIdHeader: messageIdHeader,
                inReplyTo: inReplyTo,
                referencesJson: referencesJson,
                fromAddrs: fromAddrs,
                toAddrs: toAddrs,
                ccAddrs: ccAddrs,
                bccAddrs: bccAddrs,
                replyToAddrs: replyToAddrs,
                fromEmail: fromEmail,
                subject: subject,
                baseSubject: baseSubject,
                preview: preview,
                receivedAt: receivedAt,
                sentAt: sentAt,
                size: size,
                keywords: keywords,
                isSeen: isSeen,
                isFlagged: isFlagged,
                hasAttachment: hasAttachment,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$EmailsTable, EmailRow>(table), $$EmailsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({mailboxId = false, emailKeywordsRefs = false, contentsRefs = false, inlinePartsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (emailKeywordsRefs) db.emailKeywords,
                    if (contentsRefs) db.contents,
                    if (inlinePartsRefs) db.inlineParts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (mailboxId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.mailboxId,
                            referencedTable: $$EmailsTableReferences._mailboxIdTable(db),
                            referencedColumn: $$EmailsTableReferences._mailboxIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (emailKeywordsRefs)
                        await $_getPrefetchedData<EmailRow, $EmailsTable, EmailKeywordRow>(
                          currentTable: table,
                          referencedTable: $$EmailsTableReferences._emailKeywordsRefsTable(db),
                          managerFromTypedResult: (p0) => $$EmailsTableReferences(db, table, p0).emailKeywordsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.emailId == item.id),
                          typedResults: items,
                        ),
                      if (contentsRefs)
                        await $_getPrefetchedData<EmailRow, $EmailsTable, ContentRow>(
                          currentTable: table,
                          referencedTable: $$EmailsTableReferences._contentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$EmailsTableReferences(db, table, p0).contentsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.emailId == item.id),
                          typedResults: items,
                        ),
                      if (inlinePartsRefs)
                        await $_getPrefetchedData<EmailRow, $EmailsTable, InlinePartRow>(
                          currentTable: table,
                          referencedTable: $$EmailsTableReferences._inlinePartsRefsTable(db),
                          managerFromTypedResult: (p0) => $$EmailsTableReferences(db, table, p0).inlinePartsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) =>
                              referencedItems.where((e) => e.emailId == item.id),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EmailsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $EmailsTable,
      EmailRow,
      $$EmailsTableFilterComposer,
      $$EmailsTableOrderingComposer,
      $$EmailsTableAnnotationComposer,
      $$EmailsTableCreateCompanionBuilder,
      $$EmailsTableUpdateCompanionBuilder,
      (EmailRow, $$EmailsTableReferences),
      EmailRow,
      PrefetchHooks Function({bool mailboxId, bool emailKeywordsRefs, bool contentsRefs, bool inlinePartsRefs})
    >;
typedef $$EmailKeywordsTableCreateCompanionBuilder = EmailKeywordsCompanion Function({
  required String emailId,
  required String keyword,
  Value<int> rowid,
});
typedef $$EmailKeywordsTableUpdateCompanionBuilder = EmailKeywordsCompanion Function({
  Value<String> emailId,
  Value<String> keyword,
  Value<int> rowid,
});

final class $$EmailKeywordsTableReferences
    extends BaseReferences<_$StoreDatabase, $EmailKeywordsTable, EmailKeywordRow> {
  $$EmailKeywordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmailsTable _emailIdTable(_$StoreDatabase db) =>
      db.emails.createAlias('email_keywords__email_id__emails__id');

  $$EmailsTableProcessedTableManager get emailId {
    final $_column = $_itemColumn<String>('email_id')!;

    final manager = $$EmailsTableTableManager($_db, $_db.emails).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_emailIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EmailKeywordsTableFilterComposer extends Composer<_$StoreDatabase, $EmailKeywordsTable> {
  $$EmailKeywordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get keyword =>
      $composableBuilder(column: $table.keyword, builder: (column) => ColumnFilters(column));

  $$EmailsTableFilterComposer get emailId {
    final $$EmailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableFilterComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmailKeywordsTableOrderingComposer extends Composer<_$StoreDatabase, $EmailKeywordsTable> {
  $$EmailKeywordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get keyword =>
      $composableBuilder(column: $table.keyword, builder: (column) => ColumnOrderings(column));

  $$EmailsTableOrderingComposer get emailId {
    final $$EmailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableOrderingComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmailKeywordsTableAnnotationComposer extends Composer<_$StoreDatabase, $EmailKeywordsTable> {
  $$EmailKeywordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get keyword => $composableBuilder(column: $table.keyword, builder: (column) => column);

  $$EmailsTableAnnotationComposer get emailId {
    final $$EmailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableAnnotationComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmailKeywordsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $EmailKeywordsTable,
          EmailKeywordRow,
          $$EmailKeywordsTableFilterComposer,
          $$EmailKeywordsTableOrderingComposer,
          $$EmailKeywordsTableAnnotationComposer,
          $$EmailKeywordsTableCreateCompanionBuilder,
          $$EmailKeywordsTableUpdateCompanionBuilder,
          (EmailKeywordRow, $$EmailKeywordsTableReferences),
          EmailKeywordRow,
          PrefetchHooks Function({bool emailId})
        > {
  $$EmailKeywordsTableTableManager(_$StoreDatabase db, $EmailKeywordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$EmailKeywordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$EmailKeywordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$EmailKeywordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> emailId = const Value.absent(),
            Value<String> keyword = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => EmailKeywordsCompanion(emailId: emailId, keyword: keyword, rowid: rowid),
          createCompanionCallback: ({
            required String emailId,
            required String keyword,
            Value<int> rowid = const Value.absent(),
          }) => EmailKeywordsCompanion.insert(emailId: emailId, keyword: keyword, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmailKeywordsTable, EmailKeywordRow>(table),
                  $$EmailKeywordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({emailId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (emailId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.emailId,
                        referencedTable: $$EmailKeywordsTableReferences._emailIdTable(db),
                        referencedColumn: $$EmailKeywordsTableReferences._emailIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EmailKeywordsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $EmailKeywordsTable,
      EmailKeywordRow,
      $$EmailKeywordsTableFilterComposer,
      $$EmailKeywordsTableOrderingComposer,
      $$EmailKeywordsTableAnnotationComposer,
      $$EmailKeywordsTableCreateCompanionBuilder,
      $$EmailKeywordsTableUpdateCompanionBuilder,
      (EmailKeywordRow, $$EmailKeywordsTableReferences),
      EmailKeywordRow,
      PrefetchHooks Function({bool emailId})
    >;
typedef $$ContentsTableCreateCompanionBuilder = ContentsCompanion Function({
  required String emailId,
  Value<String?> html,
  Value<String?> plainText,
  Value<bool> isFlowed,
  Value<String> headersJson,
  Value<String> attachmentsJson,
  Value<String> bodyText,
  required int fetchedAt,
  Value<int> rowid,
});
typedef $$ContentsTableUpdateCompanionBuilder = ContentsCompanion Function({
  Value<String> emailId,
  Value<String?> html,
  Value<String?> plainText,
  Value<bool> isFlowed,
  Value<String> headersJson,
  Value<String> attachmentsJson,
  Value<String> bodyText,
  Value<int> fetchedAt,
  Value<int> rowid,
});

final class $$ContentsTableReferences extends BaseReferences<_$StoreDatabase, $ContentsTable, ContentRow> {
  $$ContentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmailsTable _emailIdTable(_$StoreDatabase db) => db.emails.createAlias('contents__email_id__emails__id');

  $$EmailsTableProcessedTableManager get emailId {
    final $_column = $_itemColumn<String>('email_id')!;

    final manager = $$EmailsTableTableManager($_db, $_db.emails).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_emailIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ContentsTableFilterComposer extends Composer<_$StoreDatabase, $ContentsTable> {
  $$ContentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get html => $composableBuilder(column: $table.html, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plainText =>
      $composableBuilder(column: $table.plainText, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFlowed =>
      $composableBuilder(column: $table.isFlowed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get headersJson =>
      $composableBuilder(column: $table.headersJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attachmentsJson =>
      $composableBuilder(column: $table.attachmentsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => ColumnFilters(column));

  $$EmailsTableFilterComposer get emailId {
    final $$EmailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableFilterComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentsTableOrderingComposer extends Composer<_$StoreDatabase, $ContentsTable> {
  $$ContentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get html =>
      $composableBuilder(column: $table.html, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plainText =>
      $composableBuilder(column: $table.plainText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFlowed =>
      $composableBuilder(column: $table.isFlowed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get headersJson =>
      $composableBuilder(column: $table.headersJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attachmentsJson =>
      $composableBuilder(column: $table.attachmentsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => ColumnOrderings(column));

  $$EmailsTableOrderingComposer get emailId {
    final $$EmailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableOrderingComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentsTableAnnotationComposer extends Composer<_$StoreDatabase, $ContentsTable> {
  $$ContentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get html => $composableBuilder(column: $table.html, builder: (column) => column);

  GeneratedColumn<String> get plainText => $composableBuilder(column: $table.plainText, builder: (column) => column);

  GeneratedColumn<bool> get isFlowed => $composableBuilder(column: $table.isFlowed, builder: (column) => column);

  GeneratedColumn<String> get headersJson =>
      $composableBuilder(column: $table.headersJson, builder: (column) => column);

  GeneratedColumn<String> get attachmentsJson =>
      $composableBuilder(column: $table.attachmentsJson, builder: (column) => column);

  GeneratedColumn<String> get bodyText => $composableBuilder(column: $table.bodyText, builder: (column) => column);

  GeneratedColumn<int> get fetchedAt => $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  $$EmailsTableAnnotationComposer get emailId {
    final $$EmailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableAnnotationComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $ContentsTable,
          ContentRow,
          $$ContentsTableFilterComposer,
          $$ContentsTableOrderingComposer,
          $$ContentsTableAnnotationComposer,
          $$ContentsTableCreateCompanionBuilder,
          $$ContentsTableUpdateCompanionBuilder,
          (ContentRow, $$ContentsTableReferences),
          ContentRow,
          PrefetchHooks Function({bool emailId})
        > {
  $$ContentsTableTableManager(_$StoreDatabase db, $ContentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ContentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ContentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ContentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> emailId = const Value.absent(),
                Value<String?> html = const Value.absent(),
                Value<String?> plainText = const Value.absent(),
                Value<bool> isFlowed = const Value.absent(),
                Value<String> headersJson = const Value.absent(),
                Value<String> attachmentsJson = const Value.absent(),
                Value<String> bodyText = const Value.absent(),
                Value<int> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentsCompanion(
                emailId: emailId,
                html: html,
                plainText: plainText,
                isFlowed: isFlowed,
                headersJson: headersJson,
                attachmentsJson: attachmentsJson,
                bodyText: bodyText,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String emailId,
                Value<String?> html = const Value.absent(),
                Value<String?> plainText = const Value.absent(),
                Value<bool> isFlowed = const Value.absent(),
                Value<String> headersJson = const Value.absent(),
                Value<String> attachmentsJson = const Value.absent(),
                Value<String> bodyText = const Value.absent(),
                required int fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => ContentsCompanion.insert(
                emailId: emailId,
                html: html,
                plainText: plainText,
                isFlowed: isFlowed,
                headersJson: headersJson,
                attachmentsJson: attachmentsJson,
                bodyText: bodyText,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$ContentsTable, ContentRow>(table), $$ContentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({emailId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (emailId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.emailId,
                        referencedTable: $$ContentsTableReferences._emailIdTable(db),
                        referencedColumn: $$ContentsTableReferences._emailIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContentsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $ContentsTable,
      ContentRow,
      $$ContentsTableFilterComposer,
      $$ContentsTableOrderingComposer,
      $$ContentsTableAnnotationComposer,
      $$ContentsTableCreateCompanionBuilder,
      $$ContentsTableUpdateCompanionBuilder,
      (ContentRow, $$ContentsTableReferences),
      ContentRow,
      PrefetchHooks Function({bool emailId})
    >;
typedef $$InlinePartsTableCreateCompanionBuilder = InlinePartsCompanion Function({
  required String emailId,
  required String contentId,
  required Uint8List data,
  Value<int> rowid,
});
typedef $$InlinePartsTableUpdateCompanionBuilder = InlinePartsCompanion Function({
  Value<String> emailId,
  Value<String> contentId,
  Value<Uint8List> data,
  Value<int> rowid,
});

final class $$InlinePartsTableReferences extends BaseReferences<_$StoreDatabase, $InlinePartsTable, InlinePartRow> {
  $$InlinePartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmailsTable _emailIdTable(_$StoreDatabase db) => db.emails.createAlias('inline_parts__email_id__emails__id');

  $$EmailsTableProcessedTableManager get emailId {
    final $_column = $_itemColumn<String>('email_id')!;

    final manager = $$EmailsTableTableManager($_db, $_db.emails).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_emailIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$InlinePartsTableFilterComposer extends Composer<_$StoreDatabase, $InlinePartsTable> {
  $$InlinePartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => ColumnFilters(column));

  $$EmailsTableFilterComposer get emailId {
    final $$EmailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableFilterComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InlinePartsTableOrderingComposer extends Composer<_$StoreDatabase, $InlinePartsTable> {
  $$InlinePartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => ColumnOrderings(column));

  $$EmailsTableOrderingComposer get emailId {
    final $$EmailsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableOrderingComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InlinePartsTableAnnotationComposer extends Composer<_$StoreDatabase, $InlinePartsTable> {
  $$InlinePartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get contentId => $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<Uint8List> get data => $composableBuilder(column: $table.data, builder: (column) => column);

  $$EmailsTableAnnotationComposer get emailId {
    final $$EmailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.emailId,
      referencedTable: $db.emails,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$EmailsTableAnnotationComposer(
            $db: $db,
            $table: $db.emails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InlinePartsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $InlinePartsTable,
          InlinePartRow,
          $$InlinePartsTableFilterComposer,
          $$InlinePartsTableOrderingComposer,
          $$InlinePartsTableAnnotationComposer,
          $$InlinePartsTableCreateCompanionBuilder,
          $$InlinePartsTableUpdateCompanionBuilder,
          (InlinePartRow, $$InlinePartsTableReferences),
          InlinePartRow,
          PrefetchHooks Function({bool emailId})
        > {
  $$InlinePartsTableTableManager(_$StoreDatabase db, $InlinePartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$InlinePartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$InlinePartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$InlinePartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> emailId = const Value.absent(),
            Value<String> contentId = const Value.absent(),
            Value<Uint8List> data = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => InlinePartsCompanion(emailId: emailId, contentId: contentId, data: data, rowid: rowid),
          createCompanionCallback: ({
            required String emailId,
            required String contentId,
            required Uint8List data,
            Value<int> rowid = const Value.absent(),
          }) => InlinePartsCompanion.insert(emailId: emailId, contentId: contentId, data: data, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable<$InlinePartsTable, InlinePartRow>(table), $$InlinePartsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({emailId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (emailId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.emailId,
                        referencedTable: $$InlinePartsTableReferences._emailIdTable(db),
                        referencedColumn: $$InlinePartsTableReferences._emailIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InlinePartsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $InlinePartsTable,
      InlinePartRow,
      $$InlinePartsTableFilterComposer,
      $$InlinePartsTableOrderingComposer,
      $$InlinePartsTableAnnotationComposer,
      $$InlinePartsTableCreateCompanionBuilder,
      $$InlinePartsTableUpdateCompanionBuilder,
      (InlinePartRow, $$InlinePartsTableReferences),
      InlinePartRow,
      PrefetchHooks Function({bool emailId})
    >;
typedef $$OutboxItemsTableCreateCompanionBuilder = OutboxItemsCompanion Function({
  required String id,
  required String accountId,
  required String message,
  required int sendAfter,
  required String status,
  Value<int> attempts,
  Value<String?> lastError,
  required int createdAt,
  Value<int> rowid,
});
typedef $$OutboxItemsTableUpdateCompanionBuilder = OutboxItemsCompanion Function({
  Value<String> id,
  Value<String> accountId,
  Value<String> message,
  Value<int> sendAfter,
  Value<String> status,
  Value<int> attempts,
  Value<String?> lastError,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $$OutboxItemsTableReferences extends BaseReferences<_$StoreDatabase, $OutboxItemsTable, OutboxRow> {
  $$OutboxItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$StoreDatabase db) =>
      db.accounts.createAlias('outbox_items__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$OutboxItemsTableFilterComposer extends Composer<_$StoreDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sendAfter =>
      $composableBuilder(column: $table.sendAfter, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxItemsTableOrderingComposer extends Composer<_$StoreDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sendAfter =>
      $composableBuilder(column: $table.sendAfter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxItemsTableAnnotationComposer extends Composer<_$StoreDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get message => $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<int> get sendAfter => $composableBuilder(column: $table.sendAfter, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get attempts => $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError => $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<int> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OutboxItemsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $OutboxItemsTable,
          OutboxRow,
          $$OutboxItemsTableFilterComposer,
          $$OutboxItemsTableOrderingComposer,
          $$OutboxItemsTableAnnotationComposer,
          $$OutboxItemsTableCreateCompanionBuilder,
          $$OutboxItemsTableUpdateCompanionBuilder,
          (OutboxRow, $$OutboxItemsTableReferences),
          OutboxRow,
          PrefetchHooks Function({bool accountId})
        > {
  $$OutboxItemsTableTableManager(_$StoreDatabase db, $OutboxItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$OutboxItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$OutboxItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$OutboxItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<int> sendAfter = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OutboxItemsCompanion(
                id: id,
                accountId: accountId,
                message: message,
                sendAfter: sendAfter,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required String message,
                required int sendAfter,
                required String status,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => OutboxItemsCompanion.insert(
                id: id,
                accountId: accountId,
                message: message,
                sendAfter: sendAfter,
                status: status,
                attempts: attempts,
                lastError: lastError,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable<$OutboxItemsTable, OutboxRow>(table), $$OutboxItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$OutboxItemsTableReferences._accountIdTable(db),
                        referencedColumn: $$OutboxItemsTableReferences._accountIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OutboxItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $OutboxItemsTable,
      OutboxRow,
      $$OutboxItemsTableFilterComposer,
      $$OutboxItemsTableOrderingComposer,
      $$OutboxItemsTableAnnotationComposer,
      $$OutboxItemsTableCreateCompanionBuilder,
      $$OutboxItemsTableUpdateCompanionBuilder,
      (OutboxRow, $$OutboxItemsTableReferences),
      OutboxRow,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$PendingOpsTableCreateCompanionBuilder = PendingOpsCompanion Function({
  Value<int> id,
  required String accountId,
  required String type,
  required String payload,
  Value<int> attempts,
  required int nextAttemptAt,
  required int createdAt,
  Value<String?> lastError,
});
typedef $$PendingOpsTableUpdateCompanionBuilder = PendingOpsCompanion Function({
  Value<int> id,
  Value<String> accountId,
  Value<String> type,
  Value<String> payload,
  Value<int> attempts,
  Value<int> nextAttemptAt,
  Value<int> createdAt,
  Value<String?> lastError,
});

final class $$PendingOpsTableReferences extends BaseReferences<_$StoreDatabase, $PendingOpsTable, PendingOpRow> {
  $$PendingOpsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$StoreDatabase db) =>
      db.accounts.createAlias('pending_ops__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PendingOpsTableFilterComposer extends Composer<_$StoreDatabase, $PendingOpsTable> {
  $$PendingOpsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nextAttemptAt =>
      $composableBuilder(column: $table.nextAttemptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingOpsTableOrderingComposer extends Composer<_$StoreDatabase, $PendingOpsTable> {
  $$PendingOpsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nextAttemptAt =>
      $composableBuilder(column: $table.nextAttemptAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingOpsTableAnnotationComposer extends Composer<_$StoreDatabase, $PendingOpsTable> {
  $$PendingOpsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get payload => $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get attempts => $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<int> get nextAttemptAt =>
      $composableBuilder(column: $table.nextAttemptAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get lastError => $composableBuilder(column: $table.lastError, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PendingOpsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $PendingOpsTable,
          PendingOpRow,
          $$PendingOpsTableFilterComposer,
          $$PendingOpsTableOrderingComposer,
          $$PendingOpsTableAnnotationComposer,
          $$PendingOpsTableCreateCompanionBuilder,
          $$PendingOpsTableUpdateCompanionBuilder,
          (PendingOpRow, $$PendingOpsTableReferences),
          PendingOpRow,
          PrefetchHooks Function({bool accountId})
        > {
  $$PendingOpsTableTableManager(_$StoreDatabase db, $PendingOpsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PendingOpsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PendingOpsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PendingOpsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<int> nextAttemptAt = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => PendingOpsCompanion(
                id: id,
                accountId: accountId,
                type: type,
                payload: payload,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String accountId,
                required String type,
                required String payload,
                Value<int> attempts = const Value.absent(),
                required int nextAttemptAt,
                required int createdAt,
                Value<String?> lastError = const Value.absent(),
              }) => PendingOpsCompanion.insert(
                id: id,
                accountId: accountId,
                type: type,
                payload: payload,
                attempts: attempts,
                nextAttemptAt: nextAttemptAt,
                createdAt: createdAt,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable<$PendingOpsTable, PendingOpRow>(table), $$PendingOpsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$PendingOpsTableReferences._accountIdTable(db),
                        referencedColumn: $$PendingOpsTableReferences._accountIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PendingOpsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $PendingOpsTable,
      PendingOpRow,
      $$PendingOpsTableFilterComposer,
      $$PendingOpsTableOrderingComposer,
      $$PendingOpsTableAnnotationComposer,
      $$PendingOpsTableCreateCompanionBuilder,
      $$PendingOpsTableUpdateCompanionBuilder,
      (PendingOpRow, $$PendingOpsTableReferences),
      PendingOpRow,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$VipAddressesTableCreateCompanionBuilder = VipAddressesCompanion Function({
  required String email,
  Value<int> rowid,
});
typedef $$VipAddressesTableUpdateCompanionBuilder = VipAddressesCompanion Function({
  Value<String> email,
  Value<int> rowid,
});

class $$VipAddressesTableFilterComposer extends Composer<_$StoreDatabase, $VipAddressesTable> {
  $$VipAddressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));
}

class $$VipAddressesTableOrderingComposer extends Composer<_$StoreDatabase, $VipAddressesTable> {
  $$VipAddressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));
}

class $$VipAddressesTableAnnotationComposer extends Composer<_$StoreDatabase, $VipAddressesTable> {
  $$VipAddressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);
}

class $$VipAddressesTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $VipAddressesTable,
          VipRow,
          $$VipAddressesTableFilterComposer,
          $$VipAddressesTableOrderingComposer,
          $$VipAddressesTableAnnotationComposer,
          $$VipAddressesTableCreateCompanionBuilder,
          $$VipAddressesTableUpdateCompanionBuilder,
          (VipRow, BaseReferences<_$StoreDatabase, $VipAddressesTable, VipRow>),
          VipRow,
          PrefetchHooks Function()
        > {
  $$VipAddressesTableTableManager(_$StoreDatabase db, $VipAddressesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$VipAddressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$VipAddressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$VipAddressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> email = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => VipAddressesCompanion(email: email, rowid: rowid),
          createCompanionCallback: ({required String email, Value<int> rowid = const Value.absent()}) =>
              VipAddressesCompanion.insert(email: email, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VipAddressesTable, VipRow>(table),
                  BaseReferences<_$StoreDatabase, $VipAddressesTable, VipRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VipAddressesTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $VipAddressesTable,
      VipRow,
      $$VipAddressesTableFilterComposer,
      $$VipAddressesTableOrderingComposer,
      $$VipAddressesTableAnnotationComposer,
      $$VipAddressesTableCreateCompanionBuilder,
      $$VipAddressesTableUpdateCompanionBuilder,
      (VipRow, BaseReferences<_$StoreDatabase, $VipAddressesTable, VipRow>),
      VipRow,
      PrefetchHooks Function()
    >;
typedef $$AddressBookTableCreateCompanionBuilder = AddressBookCompanion Function({
  required String email,
  Value<String?> name,
  Value<int> seenCount,
  Value<int> sentCount,
  required int lastUsedAt,
  Value<int> rowid,
});
typedef $$AddressBookTableUpdateCompanionBuilder = AddressBookCompanion Function({
  Value<String> email,
  Value<String?> name,
  Value<int> seenCount,
  Value<int> sentCount,
  Value<int> lastUsedAt,
  Value<int> rowid,
});

class $$AddressBookTableFilterComposer extends Composer<_$StoreDatabase, $AddressBookTable> {
  $$AddressBookTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get seenCount =>
      $composableBuilder(column: $table.seenCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sentCount =>
      $composableBuilder(column: $table.sentCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUsedAt =>
      $composableBuilder(column: $table.lastUsedAt, builder: (column) => ColumnFilters(column));
}

class $$AddressBookTableOrderingComposer extends Composer<_$StoreDatabase, $AddressBookTable> {
  $$AddressBookTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get seenCount =>
      $composableBuilder(column: $table.seenCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sentCount =>
      $composableBuilder(column: $table.sentCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUsedAt =>
      $composableBuilder(column: $table.lastUsedAt, builder: (column) => ColumnOrderings(column));
}

class $$AddressBookTableAnnotationComposer extends Composer<_$StoreDatabase, $AddressBookTable> {
  $$AddressBookTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get seenCount => $composableBuilder(column: $table.seenCount, builder: (column) => column);

  GeneratedColumn<int> get sentCount => $composableBuilder(column: $table.sentCount, builder: (column) => column);

  GeneratedColumn<int> get lastUsedAt => $composableBuilder(column: $table.lastUsedAt, builder: (column) => column);
}

class $$AddressBookTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $AddressBookTable,
          AddressRow,
          $$AddressBookTableFilterComposer,
          $$AddressBookTableOrderingComposer,
          $$AddressBookTableAnnotationComposer,
          $$AddressBookTableCreateCompanionBuilder,
          $$AddressBookTableUpdateCompanionBuilder,
          (AddressRow, BaseReferences<_$StoreDatabase, $AddressBookTable, AddressRow>),
          AddressRow,
          PrefetchHooks Function()
        > {
  $$AddressBookTableTableManager(_$StoreDatabase db, $AddressBookTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$AddressBookTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AddressBookTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$AddressBookTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> email = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> seenCount = const Value.absent(),
                Value<int> sentCount = const Value.absent(),
                Value<int> lastUsedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AddressBookCompanion(
                email: email,
                name: name,
                seenCount: seenCount,
                sentCount: sentCount,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String email,
                Value<String?> name = const Value.absent(),
                Value<int> seenCount = const Value.absent(),
                Value<int> sentCount = const Value.absent(),
                required int lastUsedAt,
                Value<int> rowid = const Value.absent(),
              }) => AddressBookCompanion.insert(
                email: email,
                name: name,
                seenCount: seenCount,
                sentCount: sentCount,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AddressBookTable, AddressRow>(table),
                  BaseReferences<_$StoreDatabase, $AddressBookTable, AddressRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AddressBookTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $AddressBookTable,
      AddressRow,
      $$AddressBookTableFilterComposer,
      $$AddressBookTableOrderingComposer,
      $$AddressBookTableAnnotationComposer,
      $$AddressBookTableCreateCompanionBuilder,
      $$AddressBookTableUpdateCompanionBuilder,
      (AddressRow, BaseReferences<_$StoreDatabase, $AddressBookTable, AddressRow>),
      AddressRow,
      PrefetchHooks Function()
    >;
typedef $$ThreadRefsTableCreateCompanionBuilder = ThreadRefsCompanion Function({
  required String accountId,
  required String messageId,
  required String threadId,
  Value<int> rowid,
});
typedef $$ThreadRefsTableUpdateCompanionBuilder = ThreadRefsCompanion Function({
  Value<String> accountId,
  Value<String> messageId,
  Value<String> threadId,
  Value<int> rowid,
});

final class $$ThreadRefsTableReferences extends BaseReferences<_$StoreDatabase, $ThreadRefsTable, ThreadRefRow> {
  $$ThreadRefsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$StoreDatabase db) =>
      db.accounts.createAlias('thread_refs__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$AccountsTableTableManager($_db, $_db.accounts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ThreadRefsTableFilterComposer extends Composer<_$StoreDatabase, $ThreadRefsTable> {
  $$ThreadRefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThreadRefsTableOrderingComposer extends Composer<_$StoreDatabase, $ThreadRefsTable> {
  $$ThreadRefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThreadRefsTableAnnotationComposer extends Composer<_$StoreDatabase, $ThreadRefsTable> {
  $$ThreadRefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId => $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get threadId => $composableBuilder(column: $table.threadId, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ThreadRefsTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $ThreadRefsTable,
          ThreadRefRow,
          $$ThreadRefsTableFilterComposer,
          $$ThreadRefsTableOrderingComposer,
          $$ThreadRefsTableAnnotationComposer,
          $$ThreadRefsTableCreateCompanionBuilder,
          $$ThreadRefsTableUpdateCompanionBuilder,
          (ThreadRefRow, $$ThreadRefsTableReferences),
          ThreadRefRow,
          PrefetchHooks Function({bool accountId})
        > {
  $$ThreadRefsTableTableManager(_$StoreDatabase db, $ThreadRefsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ThreadRefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ThreadRefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ThreadRefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> accountId = const Value.absent(),
            Value<String> messageId = const Value.absent(),
            Value<String> threadId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ThreadRefsCompanion(accountId: accountId, messageId: messageId, threadId: threadId, rowid: rowid),
          createCompanionCallback:
              ({
                required String accountId,
                required String messageId,
                required String threadId,
                Value<int> rowid = const Value.absent(),
              }) => ThreadRefsCompanion.insert(
                accountId: accountId,
                messageId: messageId,
                threadId: threadId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (e.readTable<$ThreadRefsTable, ThreadRefRow>(table), $$ThreadRefsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$ThreadRefsTableReferences._accountIdTable(db),
                        referencedColumn: $$ThreadRefsTableReferences._accountIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ThreadRefsTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $ThreadRefsTable,
      ThreadRefRow,
      $$ThreadRefsTableFilterComposer,
      $$ThreadRefsTableOrderingComposer,
      $$ThreadRefsTableAnnotationComposer,
      $$ThreadRefsTableCreateCompanionBuilder,
      $$ThreadRefsTableUpdateCompanionBuilder,
      (ThreadRefRow, $$ThreadRefsTableReferences),
      ThreadRefRow,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$IdAliasesTableCreateCompanionBuilder = IdAliasesCompanion Function({
  required String oldId,
  required String newId,
  Value<int> rowid,
});
typedef $$IdAliasesTableUpdateCompanionBuilder = IdAliasesCompanion Function({
  Value<String> oldId,
  Value<String> newId,
  Value<int> rowid,
});

class $$IdAliasesTableFilterComposer extends Composer<_$StoreDatabase, $IdAliasesTable> {
  $$IdAliasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get oldId =>
      $composableBuilder(column: $table.oldId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get newId =>
      $composableBuilder(column: $table.newId, builder: (column) => ColumnFilters(column));
}

class $$IdAliasesTableOrderingComposer extends Composer<_$StoreDatabase, $IdAliasesTable> {
  $$IdAliasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get oldId =>
      $composableBuilder(column: $table.oldId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get newId =>
      $composableBuilder(column: $table.newId, builder: (column) => ColumnOrderings(column));
}

class $$IdAliasesTableAnnotationComposer extends Composer<_$StoreDatabase, $IdAliasesTable> {
  $$IdAliasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get oldId => $composableBuilder(column: $table.oldId, builder: (column) => column);

  GeneratedColumn<String> get newId => $composableBuilder(column: $table.newId, builder: (column) => column);
}

class $$IdAliasesTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $IdAliasesTable,
          IdAliasRow,
          $$IdAliasesTableFilterComposer,
          $$IdAliasesTableOrderingComposer,
          $$IdAliasesTableAnnotationComposer,
          $$IdAliasesTableCreateCompanionBuilder,
          $$IdAliasesTableUpdateCompanionBuilder,
          (IdAliasRow, BaseReferences<_$StoreDatabase, $IdAliasesTable, IdAliasRow>),
          IdAliasRow,
          PrefetchHooks Function()
        > {
  $$IdAliasesTableTableManager(_$StoreDatabase db, $IdAliasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$IdAliasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$IdAliasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$IdAliasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> oldId = const Value.absent(),
            Value<String> newId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => IdAliasesCompanion(oldId: oldId, newId: newId, rowid: rowid),
          createCompanionCallback: ({
            required String oldId,
            required String newId,
            Value<int> rowid = const Value.absent(),
          }) => IdAliasesCompanion.insert(oldId: oldId, newId: newId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IdAliasesTable, IdAliasRow>(table),
                  BaseReferences<_$StoreDatabase, $IdAliasesTable, IdAliasRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$IdAliasesTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $IdAliasesTable,
      IdAliasRow,
      $$IdAliasesTableFilterComposer,
      $$IdAliasesTableOrderingComposer,
      $$IdAliasesTableAnnotationComposer,
      $$IdAliasesTableCreateCompanionBuilder,
      $$IdAliasesTableUpdateCompanionBuilder,
      (IdAliasRow, BaseReferences<_$StoreDatabase, $IdAliasesTable, IdAliasRow>),
      IdAliasRow,
      PrefetchHooks Function()
    >;
typedef $$RulesTableCreateCompanionBuilder = RulesCompanion Function({
  required String id,
  required String json,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$RulesTableUpdateCompanionBuilder = RulesCompanion Function({
  Value<String> id,
  Value<String> json,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$RulesTableFilterComposer extends Composer<_$StoreDatabase, $RulesTable> {
  $$RulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get json => $composableBuilder(column: $table.json, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnFilters(column));
}

class $$RulesTableOrderingComposer extends Composer<_$StoreDatabase, $RulesTable> {
  $$RulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$RulesTableAnnotationComposer extends Composer<_$StoreDatabase, $RulesTable> {
  $$RulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get json => $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<int> get sortOrder => $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$RulesTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $RulesTable,
          RuleRow,
          $$RulesTableFilterComposer,
          $$RulesTableOrderingComposer,
          $$RulesTableAnnotationComposer,
          $$RulesTableCreateCompanionBuilder,
          $$RulesTableUpdateCompanionBuilder,
          (RuleRow, BaseReferences<_$StoreDatabase, $RulesTable, RuleRow>),
          RuleRow,
          PrefetchHooks Function()
        > {
  $$RulesTableTableManager(_$StoreDatabase db, $RulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> json = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => RulesCompanion(id: id, json: json, sortOrder: sortOrder, rowid: rowid),
          createCompanionCallback: ({
            required String id,
            required String json,
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => RulesCompanion.insert(id: id, json: json, sortOrder: sortOrder, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RulesTable, RuleRow>(table),
                  BaseReferences<_$StoreDatabase, $RulesTable, RuleRow>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RulesTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $RulesTable,
      RuleRow,
      $$RulesTableFilterComposer,
      $$RulesTableOrderingComposer,
      $$RulesTableAnnotationComposer,
      $$RulesTableCreateCompanionBuilder,
      $$RulesTableUpdateCompanionBuilder,
      (RuleRow, BaseReferences<_$StoreDatabase, $RulesTable, RuleRow>),
      RuleRow,
      PrefetchHooks Function()
    >;
typedef $$RuleWatermarksTableCreateCompanionBuilder = RuleWatermarksCompanion Function({
  required String mailboxId,
  required int seq,
  Value<int?> uidValidity,
  Value<int?> uid,
  Value<int> rowid,
});
typedef $$RuleWatermarksTableUpdateCompanionBuilder = RuleWatermarksCompanion Function({
  Value<String> mailboxId,
  Value<int> seq,
  Value<int?> uidValidity,
  Value<int?> uid,
  Value<int> rowid,
});

final class $$RuleWatermarksTableReferences
    extends BaseReferences<_$StoreDatabase, $RuleWatermarksTable, RuleWatermarkRow> {
  $$RuleWatermarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MailboxesTable _mailboxIdTable(_$StoreDatabase db) =>
      db.mailboxes.createAlias('rule_watermarks__mailbox_id__mailboxes__id');

  $$MailboxesTableProcessedTableManager get mailboxId {
    final $_column = $_itemColumn<String>('mailbox_id')!;

    final manager = $$MailboxesTableTableManager($_db, $_db.mailboxes).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mailboxIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RuleWatermarksTableFilterComposer extends Composer<_$StoreDatabase, $RuleWatermarksTable> {
  $$RuleWatermarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get uidValidity =>
      $composableBuilder(column: $table.uidValidity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get uid => $composableBuilder(column: $table.uid, builder: (column) => ColumnFilters(column));

  $$MailboxesTableFilterComposer get mailboxId {
    final $$MailboxesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableFilterComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleWatermarksTableOrderingComposer extends Composer<_$StoreDatabase, $RuleWatermarksTable> {
  $$RuleWatermarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uidValidity =>
      $composableBuilder(column: $table.uidValidity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get uid => $composableBuilder(column: $table.uid, builder: (column) => ColumnOrderings(column));

  $$MailboxesTableOrderingComposer get mailboxId {
    final $$MailboxesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableOrderingComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleWatermarksTableAnnotationComposer extends Composer<_$StoreDatabase, $RuleWatermarksTable> {
  $$RuleWatermarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get seq => $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<int> get uidValidity => $composableBuilder(column: $table.uidValidity, builder: (column) => column);

  GeneratedColumn<int> get uid => $composableBuilder(column: $table.uid, builder: (column) => column);

  $$MailboxesTableAnnotationComposer get mailboxId {
    final $$MailboxesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mailboxId,
      referencedTable: $db.mailboxes,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MailboxesTableAnnotationComposer(
            $db: $db,
            $table: $db.mailboxes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RuleWatermarksTableTableManager
    extends
        RootTableManager<
          _$StoreDatabase,
          $RuleWatermarksTable,
          RuleWatermarkRow,
          $$RuleWatermarksTableFilterComposer,
          $$RuleWatermarksTableOrderingComposer,
          $$RuleWatermarksTableAnnotationComposer,
          $$RuleWatermarksTableCreateCompanionBuilder,
          $$RuleWatermarksTableUpdateCompanionBuilder,
          (RuleWatermarkRow, $$RuleWatermarksTableReferences),
          RuleWatermarkRow,
          PrefetchHooks Function({bool mailboxId})
        > {
  $$RuleWatermarksTableTableManager(_$StoreDatabase db, $RuleWatermarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RuleWatermarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RuleWatermarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RuleWatermarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> mailboxId = const Value.absent(),
                Value<int> seq = const Value.absent(),
                Value<int?> uidValidity = const Value.absent(),
                Value<int?> uid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RuleWatermarksCompanion(
                mailboxId: mailboxId,
                seq: seq,
                uidValidity: uidValidity,
                uid: uid,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mailboxId,
                required int seq,
                Value<int?> uidValidity = const Value.absent(),
                Value<int?> uid = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RuleWatermarksCompanion.insert(
                mailboxId: mailboxId,
                seq: seq,
                uidValidity: uidValidity,
                uid: uid,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RuleWatermarksTable, RuleWatermarkRow>(table),
                  $$RuleWatermarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mailboxId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (mailboxId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.mailboxId,
                        referencedTable: $$RuleWatermarksTableReferences._mailboxIdTable(db),
                        referencedColumn: $$RuleWatermarksTableReferences._mailboxIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RuleWatermarksTableProcessedTableManager =
    ProcessedTableManager<
      _$StoreDatabase,
      $RuleWatermarksTable,
      RuleWatermarkRow,
      $$RuleWatermarksTableFilterComposer,
      $$RuleWatermarksTableOrderingComposer,
      $$RuleWatermarksTableAnnotationComposer,
      $$RuleWatermarksTableCreateCompanionBuilder,
      $$RuleWatermarksTableUpdateCompanionBuilder,
      (RuleWatermarkRow, $$RuleWatermarksTableReferences),
      RuleWatermarkRow,
      PrefetchHooks Function({bool mailboxId})
    >;

class $StoreDatabaseManager {
  final _$StoreDatabase _db;
  $StoreDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts => $$AccountsTableTableManager(_db, _db.accounts);
  $$MailboxesTableTableManager get mailboxes => $$MailboxesTableTableManager(_db, _db.mailboxes);
  $$SyncStatesTableTableManager get syncStates => $$SyncStatesTableTableManager(_db, _db.syncStates);
  $$EmailsTableTableManager get emails => $$EmailsTableTableManager(_db, _db.emails);
  $$EmailKeywordsTableTableManager get emailKeywords => $$EmailKeywordsTableTableManager(_db, _db.emailKeywords);
  $$ContentsTableTableManager get contents => $$ContentsTableTableManager(_db, _db.contents);
  $$InlinePartsTableTableManager get inlineParts => $$InlinePartsTableTableManager(_db, _db.inlineParts);
  $$OutboxItemsTableTableManager get outboxItems => $$OutboxItemsTableTableManager(_db, _db.outboxItems);
  $$PendingOpsTableTableManager get pendingOps => $$PendingOpsTableTableManager(_db, _db.pendingOps);
  $$VipAddressesTableTableManager get vipAddresses => $$VipAddressesTableTableManager(_db, _db.vipAddresses);
  $$AddressBookTableTableManager get addressBook => $$AddressBookTableTableManager(_db, _db.addressBook);
  $$ThreadRefsTableTableManager get threadRefs => $$ThreadRefsTableTableManager(_db, _db.threadRefs);
  $$IdAliasesTableTableManager get idAliases => $$IdAliasesTableTableManager(_db, _db.idAliases);
  $$RulesTableTableManager get rules => $$RulesTableTableManager(_db, _db.rules);
  $$RuleWatermarksTableTableManager get ruleWatermarks => $$RuleWatermarksTableTableManager(_db, _db.ruleWatermarks);
}
