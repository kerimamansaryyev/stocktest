import 'dart:async';

import 'package:http/http.dart' as http;

typedef ProgressRequestPercentCallback = void Function(int progress);

class ProgressMultipartRequest extends http.MultipartRequest {
  final ProgressRequestPercentCallback? progressPercentCallback;

  ProgressMultipartRequest(
    super.method,
    super.url, {
    required this.progressPercentCallback,
  });

  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        progressPercentCallback?.call(((bytes / total) * 100).toInt());
        sink.add(data);
      },
      handleDone: (sink) {
        sink.close();
      },
      handleError: (err, trace, sink) {
        sink.close();
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
