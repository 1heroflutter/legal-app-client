import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:client/features/consultation/models/message_model.dart';
import 'package:client/data/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final chatService = ChatService();
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  var messages = <MessageModel>[].obs;
  var isLoading = false.obs;
  
  // Pagination & Layout states
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;
  var showScrollToBottomBtn = false.obs;
  DocumentSnapshot? lastDocument;

  @override
  void onInit() {
    super.onInit();
    // Listen to scroll to show/hide FAB and load more
    scrollController.addListener(() {
      if (scrollController.offset > 200) {
        showScrollToBottomBtn.value = true;
      } else {
        showScrollToBottomBtn.value = false;
      }

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent &&
          !isLoadingMore.value &&
          hasMoreData.value) {
        loadMoreMessages();
      }
    });

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        lastDocument = null;
        hasMoreData.value = true;
        loadChatHistory();
      } else {
        messages.clear();
        lastDocument = null;
        hasMoreData.value = true;
      }
    });
  }

  // Load History from Firestore (Initial Load)
  void loadChatHistory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        messages.clear();
        return;
      }

      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('chats')
          .orderBy('timestamp', descending: true)
          .limit(15)
          .get();

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
        messages.assignAll(
          snapshot.docs.map((doc) => MessageModel.fromJson(doc.data())).toList(),
        );
        if (snapshot.docs.length < 15) {
          hasMoreData.value = false;
        } else {
          hasMoreData.value = true;
        }
      } else {
        messages.clear();
        hasMoreData.value = false;
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải lịch sử chat');
    } finally {
      isLoading.value = false;
    }
  }

  // Load More History
  void loadMoreMessages() async {
    if (lastDocument == null) return;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      isLoadingMore.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('chats')
          .orderBy('timestamp', descending: true)
          .startAfterDocument(lastDocument!)
          .limit(15)
          .get();

      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
        messages.addAll(
          snapshot.docs.map((doc) => MessageModel.fromJson(doc.data())).toList(),
        );
        if (snapshot.docs.length < 15) {
          hasMoreData.value = false;
        }
      } else {
        hasMoreData.value = false;
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tải thêm lịch sử chat');
    } finally {
      isLoadingMore.value = false;
    }
  }

  void sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    final timestamp = DateTime.now();

    // 1. Add User Message
    final userMessage = MessageModel(
      text: text,
      isMe: true,
      timestamp: timestamp,
    );
    // Insert at 0 because ListView is reverse:true
    messages.insert(0, userMessage);
    messageController.clear();
    scrollToBottom();

    // Save User Message to Firestore
    if (user != null) {
      _saveMessageToFirestore(userMessage);
    }

    // 2. Show Loading
    isLoading.value = true;

    // 3. Get AI Response
    try {
      final responseText = await chatService.sendMessage(text);
      final aiMessage = MessageModel(
        text: responseText,
        isMe: false,
        timestamp: DateTime.now(),
      );
      messages.insert(0, aiMessage);

      // Save AI Response to Firestore
      if (user != null) {
        _saveMessageToFirestore(aiMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get response');
    } finally {
      isLoading.value = false;
      scrollToBottom();
    }
  }

  void _saveMessageToFirestore(MessageModel message) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('chats')
        .add(message.toJson());
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
