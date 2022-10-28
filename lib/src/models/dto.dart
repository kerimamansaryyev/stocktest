import 'package:meta/meta.dart';
import 'package:stocktest/src/utils/misc.dart';

typedef ServerModelDTOMapper<T> = T Function(Map<String, dynamic> element);

/// Implementation of DTO (data transfer object) pattern
@immutable
abstract class ServerModelDTO<T> {
  @protected
  final Map<String, dynamic> dtoRawModel;

  const ServerModelDTO(this.dtoRawModel);

  T get primaryKey;

  @override
  int get hashCode => primaryKey.hashCode;

  @override
  bool operator ==(other) =>
      other is ServerModelDTO<T> && other.hashCode == hashCode;

  Map<String, dynamic> getRawData() => {...dtoRawModel};

  static T createSafelyFromDynamic<T extends ServerModelDTO>({
    required dynamic data,
    required ServerModelDTOMapper<T> mapper,
  }) =>
      mapper(leaveOnlyStringKeys(safelyGetMapFromDynamic(data)));
}

mixin CopyableAppDTOMixin<T, C extends ServerModelDTO<T>> on ServerModelDTO<T> {
  C copyWith(Map<String, dynamic> data);
}
