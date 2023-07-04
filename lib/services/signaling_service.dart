import 'package:socket_io_client/socket_io_client.dart' as IO;

class SignallingService {
  IO.Socket? socket;

  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          "stun:stun.l.google.com:19302",
          "stun:stun1.l.google.com:19302",
          "stun:stun2.l.google.com:19302",
          "stun:stun3.l.google.com:19302",
          "stun:stun4.l.google.com:19302",
        ],
      },
    ]
  };

  // RTCPeerConnection? peerConnection;
  // MediaStream? localStream;
  // MediaStream? remoteStream;
  // String? roomId;
  // String? currentRoomText;

  connectSocket() {
    socket = IO.io(
        'http://100.21.156.51:5001',
        IO.OptionBuilder().setTransports(['websocket'])
            // .enableForceNew()
            .build());
    socket?.on('test', (data) => print(data));
  }

  // getMedia
}
