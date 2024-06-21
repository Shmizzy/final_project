
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:yardex/models/service_request.dart';

class SocketService {
  late IO.Socket socket;

  void createConnection() {
    socket = IO.io('http://10.0.2.2:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  void createRequest(ServiceRequest request){
    final jsonRequest = request.toJson();
    socket.emit('create_request', jsonRequest);
  }

  void joinRoom(String servicerId) {
    socket.emit('join_room', servicerId);
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
    }
  }
}
