// import 'package:chatview/chatview.dart';
// import 'package:flutter/material.dart';
//
// class DemoChatView extends StatefulWidget {
//   const DemoChatView({super.key});
//
//   @override
//   State<DemoChatView> createState() => _DemoChatViewState();
// }
//
// class _DemoChatViewState extends State<DemoChatView> {
//
//   final userTwo = ChatUser(
//     id: '3',
//     name: 'Jhon',
//   );
//   final userThree = ChatUser(
//     id: '4',
//     name: 'Mike',
//   );
//
//
//
//   final chatController = ChatController(
//     initialMessageList: [
//       Message(
//         id: '1',
//         message: "Hi!",
//         createdAt: DateTime.now(),
//
//         sentBy: '', // userId of who sends the message
//       ),
//       Message(
//         id: '2',
//         message: "Hi!",
//         createdAt: DateTime.now(),
//         sentBy: '',
//       ),
//       Message(
//         id: '3',
//         message: "Can we meet? I am free",
//         createdAt: DateTime.now(),
//         sentBy: '',
//       ),
//     ],
//     scrollController: ScrollController(),
//     otherUsers: [],
//     currentUser: currentUser,
//   );
//
//   final currentUser = ChatUser(
//     id: '1',
//     name: 'Simform',
//   );
//
//   onSendTap({required String message, required ReplyMessage replyMessage}) {
//     chatController.addMessage(
//       Message(
//         id: id.toString(), // This can be the next message-id if you need to add according to your usecase
//         createdAt: DateTime.now(),
//         message: message,
//         replyMessage: replyMessage,
//         sentBy: '',
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ChatView(
//         chatController: chatController,
//         chatViewState: ChatViewState.hasMessages,
//         onSendTap: onSendTap(message: , replyMessage: ),
//       ),
//     );
//   }
// }
//
// class ChatUser{
//   String id;
//   String name;
//
//
//   ChatUser({
//     required this.id,
//     required this.name,
//   });
// }
//
