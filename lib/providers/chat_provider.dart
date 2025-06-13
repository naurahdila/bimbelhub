import 'package:flutter/material.dart';
import 'dart:async';

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String chatId;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.chatId,
  });
}

class Chat {
  final String id;
  final String name;
  final String? avatar;
  final Color? avatarColor;
  final List<ChatMessage> messages;
  int unreadCount;

  Chat({
    required this.id,
    required this.name,
    this.avatar,
    this.avatarColor,
    required this.messages,
    this.unreadCount = 0,
  });

  String get lastMessage {
    return messages.isNotEmpty ? messages.last.text : '';
  }

  String get lastMessageTime {
    return messages.isNotEmpty ? messages.last.time : '';
  }
}

class ChatProvider with ChangeNotifier {
  final List<Chat> _chats = [
    Chat(
      id: 'ruangguru5',
      name: 'Ruangguru',
      messages: [
        ChatMessage(
          text: 'Selamat datang dibimbel terbaik no 1 di Indonesia, ada yang bisa saya bantu?',
          isMe: false,
          time: '13:11',
          chatId: 'ruangguru5',
        ),
      ],
      unreadCount: 1,
    ),
    Chat(
      id: 'AGI',
      name: 'Aulad Gemilang Indonesia',
      messages: [
        ChatMessage(
          text: 'Selamat datang dibimbel terbaik no 1 di Surabaya, ada yang bisa saya bantu?',
          isMe: false,
          time: '13:11',
          chatId: 'ruangguru6',
        ),
      ],
      unreadCount: 1,
    ),
    Chat(
      id: 'starclass',
      name: 'Star Class',
      messages: [
        ChatMessage(
          text: 'Untuk fasilitas ruang kelasnya terdapat papan tulis digital yang...',
          isMe: false,
          time: '13:11',
          chatId: 'ruangguru7',
        ),
      ],
      unreadCount: 1,
    ),
  ];

  List<Chat> get chats => _chats;

  Chat getChatById(String id) {
    return _chats.firstWhere((chat) => chat.id == id);
  }

  void sendMessage(String chatId, String text) {
    final now = DateTime.now();
    final formattedTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    
    final newMessage = ChatMessage(
      text: text,
      isMe: true,
      time: formattedTime,
      chatId: chatId,
    );
    
    chat.messages.add(newMessage);
    
    // Move this chat to the top of the list
    _chats.remove(chat);
    _chats.insert(0, chat);
    
    notifyListeners();
    
    // Add auto-reply after a delay
    Timer(const Duration(seconds: 2), () {
      _sendAutoReply(chatId, text);
    });
  }

  void _sendAutoReply(String chatId, String userMessage) {
    final now = DateTime.now();
    final formattedTime = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    
    // Generate auto-reply based on user message
    final String replyText = _generateAutoReply(userMessage);
    
    final newMessage = ChatMessage(
      text: replyText,
      isMe: false,
      time: formattedTime,
      chatId: chatId,
    );
    
    chat.messages.add(newMessage);
    chat.unreadCount += 1;
    
    notifyListeners();
  }

  String _generateAutoReply(String userMessage) {
    // Simple auto-reply logic based on keywords in the user's message
    final String lowerCaseMessage = userMessage.toLowerCase();
    
    if (lowerCaseMessage.contains('harga') || lowerCaseMessage.contains('biaya')) {
      return 'Untuk informasi biaya, kami memiliki beberapa paket mulai dari Rp 4.000/hari hingga Rp 8.250.000/tahun tergantung program yang dipilih. Apakah Anda ingin informasi lebih detail tentang paket tertentu?';
    } else if (lowerCaseMessage.contains('jadwal') || lowerCaseMessage.contains('waktu')) {
      return 'Jadwal bimbel kami fleksibel, tersedia sesi pagi (08.00-12.00), siang (13.00-17.00), dan malam (18.00-21.00). Anda dapat memilih sesuai kebutuhan.';
    } else if (lowerCaseMessage.contains('fasilitas') || lowerCaseMessage.contains('kelas')) {
      return 'Fasilitas kami meliputi ruang kelas ber-AC, papan tulis digital interaktif, perpustakaan, wifi gratis, dan ruang diskusi. Semua dirancang untuk memberikan kenyamanan belajar maksimal.';
    } else if (lowerCaseMessage.contains('guru') || lowerCaseMessage.contains('pengajar') || lowerCaseMessage.contains('tutor')) {
      return 'Pengajar kami adalah lulusan universitas terkemuka dengan pengalaman mengajar minimal 3 tahun. Mereka juga telah melalui seleksi ketat dan pelatihan metode pengajaran terbaik.';
    } else if (lowerCaseMessage.contains('terima kasih') || lowerCaseMessage.contains('makasih')) {
      return 'Sama-sama! Jika ada pertanyaan lain, jangan ragu untuk bertanya. Kami siap membantu Anda.';
    } else if (lowerCaseMessage.contains('daftar') || lowerCaseMessage.contains('registrasi')) {
      return 'Untuk pendaftaran, Anda dapat langsung datang ke kantor kami dengan membawa kartu identitas, foto terbaru, dan biaya pendaftaran. Atau Anda bisa mendaftar online melalui website kami.';
    } else {
      return 'Terima kasih atas pertanyaan Anda. Admin kami akan segera merespons. Untuk informasi lebih cepat, Anda juga dapat menghubungi kami di nomor 081234567890.';
    }
  }

  void markAsRead(String chatId) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    chat.unreadCount = 0;
    notifyListeners();
  }
}