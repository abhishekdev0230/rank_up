import 'dart:convert';

class MessageReactProperties {
  const MessageReactProperties({
    required this.reacts,
  });
  final Map reacts;

  Map toJson() {
    return {
      "reacts": jsonEncode({}),
    };
  }

  factory MessageReactProperties.fromData() {
    return const MessageReactProperties(
      reacts: {},
    );
  }
}

class MessageActionReact {
  const MessageActionReact({
    required this.messageReactId,
    required this.reacts,
    required this.currentUserId,
    required this.chosenReactionId,
  });
  final String messageReactId;
  final Map reacts;
  final String chosenReactionId;
  final String currentUserId;

  Map get updatedReacts {
    reacts[currentUserId] = chosenReactionId;
    return {"reacts": jsonEncode(reacts)};
  }
}