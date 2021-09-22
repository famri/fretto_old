import 'package:flutter/material.dart';
import 'package:fretto/app/app.locator.dart';
import 'package:fretto/l10n/locale/app_localizations.dart';
import 'package:stacked/stacked.dart';

import 'discussions_viewmodel.dart';

class DiscussionsView extends StatelessWidget {
  const DiscussionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscussionsViewModel>.reactive(
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.discussionsAppBarTitle),
            actions: [],
          ),
          body: SafeArea(
            child: model.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : model.discussions.length == 0
                    ? Center(child: Text('You have no discussions yet.'))
                    : ListView.builder(
                        itemCount: model.discussions.length,
                        controller: model.scrollController,
                        itemBuilder: (ctx, index) {
                          return Card(
                            child: ListTile(
                              onTap: () =>
                                  model.navigateToMessages(model.discussions[index]),
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(model.isClient
                                    ? model
                                        .discussions[index].transporter.photoUrl
                                    : model.discussions[index].client.photoUrl),
                                backgroundColor: Colors.transparent,
                              ),
                              trailing:
                                  model.discussions[index].latestMessage.isRead
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.circle,
                                          color: Colors.blue,
                                          size: 20,
                                        ),
                              title: Text(
                                model.isClient
                                    ? model.discussions[index].transporter.name
                                    : model.discussions[index].client.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: ((model.isClient &&
                                          model.discussions[index].latestMessage
                                                  .authorId ==
                                              model.discussions[index]
                                                  .transporter.id) ||
                                      (!model.isClient &&
                                          model.discussions[index].latestMessage
                                                  .authorId ==
                                              model.discussions[index].client
                                                  .id))
                                  ? Text(
                                      model.discussions[index].latestMessage
                                          .content,
                                      style: TextStyle(
                                          fontWeight: !model.discussions[index]
                                                  .latestMessage.isRead
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: Colors.lightBlue))
                                  : Text(
                                      "Vous: ${model.discussions[index].latestMessage.content}"),
                            ),
                          );
                        }),
          )),
      viewModelBuilder: () => locator<DiscussionsViewModel>(),
    );
  }
}
