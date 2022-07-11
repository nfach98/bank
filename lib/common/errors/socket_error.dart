import 'app_error.dart';

class SocketError extends AppError {
  const SocketError({
    String message = 'Gagal menghubungkan ke server, silahkan coba lagi',
  }) : super(message);
}
