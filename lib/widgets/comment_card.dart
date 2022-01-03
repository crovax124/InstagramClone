import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  final snap;
  final postId;

  const CommentCard({Key? key, required this.snap, this.postId}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    bool isLikeAnimating = false;
    final User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.snap.data()['profilePic'],
            ),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.snap.data()['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                          text: ' ${widget.snap.data()['text']}',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Text(
                          DateFormat.yMMMd().format(
                            widget.snap.data()['datePublished'].toDate(),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Text(' '),
                        Text(
                            '${widget.snap['likes'].length} likes',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,),
                          ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () async {
                FirestoreMethods()
                    .likeComment(widget.postId, widget.snap['commentId'], user.uid, widget.snap['likes']);
              },
              icon: widget.snap['likes'].contains(user.uid)
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
