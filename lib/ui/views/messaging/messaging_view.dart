import 'package:flutter/material.dart';
import 'package:fretto/models/interlocutor.dart';
import 'package:stacked/stacked.dart';

import 'messaging_viewmodel.dart';

class MessagingView extends StatelessWidget {
  final Interlocutor interlocutor;
  final int discussionId;
  const MessagingView(
      {Key? key, required this.interlocutor, required this.discussionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final messageWidth = mediaQuery.size.width / 2;

    return ViewModelBuilder<MessagingViewModel>.reactive(
      onModelReady: (model) => model.initialize(discussionId),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            //
            title: Row(children: <Widget>[
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(interlocutor.photoUrl),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                interlocutor.name,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ]),
            actions: [],
          ),
          body: SafeArea(
              child: model.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RefreshIndicator(
                                      triggerMode:
                                          RefreshIndicatorTriggerMode.anywhere,
                                      onRefresh: () =>
                                          model.fetchDiscussionMessagesResult(),
                                      child: ListView.builder(
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          controller: model.scrollController,
                                          shrinkWrap: false,
                                          //reverse: true,
                                          itemCount: model.messages.length,
                                          itemBuilder: (ctx, index) {
                                            int reversedIndex =
                                                model.messages.length -
                                                    1 -
                                                    index;
                                            bool isInterlocutorMessage = model
                                                    .messages[reversedIndex]
                                                    .authorId ==
                                                interlocutor.id;

                                            return isInterlocutorMessage
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                        Column(
                                                            children: <Widget>[
                                                              if (model.showMessageDateTimeIndex ==
                                                                  reversedIndex)
                                                                Text(
                                                                    model.dateTimeFormat!.format(model
                                                                        .messages[
                                                                            reversedIndex]
                                                                        .dateTime),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  CircleAvatar(
                                                                    radius:
                                                                        15.0,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            interlocutor.photoUrl),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          5.0),
                                                                  GestureDetector(
                                                                      onTap: () =>
                                                                          model.switchShowMessageDateTime(
                                                                              reversedIndex),
                                                                      child: Container(
                                                                          decoration: BoxDecoration(
                                                                              color: isInterlocutorMessage ? Colors.grey[300] : Colors.blue,
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: const Radius.circular(8.0),
                                                                                topRight: const Radius.circular(8.0),
                                                                                bottomRight: const Radius.circular(8.0),
                                                                              )),
                                                                          child: Padding(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: SizedBox(
                                                                                  width: messageWidth,
                                                                                  child: Text(
                                                                                    model.messages[reversedIndex].content,
                                                                                    softWrap: true,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black,
                                                                                      fontSize: 24.0,
                                                                                    ),
                                                                                  )))))
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 10.0),
                                                            ]),
                                                      ])
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                        Column(
                                                            children: <Widget>[
                                                              if (model.showMessageDateTimeIndex ==
                                                                  reversedIndex)
                                                                Text(
                                                                    model.dateTimeFormat!.format(model
                                                                        .messages[
                                                                            reversedIndex]
                                                                        .dateTime),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey)),
                                                              GestureDetector(
                                                                  onTap:
                                                                      () => {
                                                                            model.switchShowMessageDateTime(reversedIndex)
                                                                          },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.blue,
                                                                          borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(8.0),
                                                                            topRight:
                                                                                const Radius.circular(8.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(8.0),
                                                                          )),
                                                                      child: Padding(
                                                                          padding: EdgeInsets.all(5.0),
                                                                          child: SizedBox(
                                                                              width: messageWidth,
                                                                              child: Text(
                                                                                model.messages[reversedIndex].content,
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 24.0,
                                                                                ),
                                                                              ))))),
                                                              SizedBox(
                                                                  height: 10.0)
                                                            ]),
                                                        if (reversedIndex == 0)
                                                          model.messages[index]
                                                                  .isRead
                                                              ? Icon(
                                                                  Icons
                                                                      .check_circle_outline,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 16,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .check_circle_outline,
                                                                  color: Colors
                                                                      .grey,
                                                                  size: 16,
                                                                )
                                                      ]);
                                          }))),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(children: <Widget>[
                              Expanded(
                                  child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      controller: model.messageTextController,
                                      minLines: 1,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        border: new OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(5.0),
                                          ),
                                        ),
                                        hintText: 'Aa',
                                      ))),
                              IconButton(
                                  icon: Icon(Icons.send_rounded,
                                      color: Colors.blue),
                                  onPressed: () => model.sendMessage())
                            ])
                          ])))),
      viewModelBuilder: () => MessagingViewModel(),
    );
  }
}
