
import 'package:dropbox_integration/Classes/ALL.dart';
import 'package:dropbox_integration/Actions/ALL.dart';
import 'DropboxData/DropboxTypeFiles.dart';


class DropboxInstance extends DropboxFileTypes{

  final String tokenUser;

  DropboxInstance(this.tokenUser) {
    filesActions = FilesActions(tokenUser);
  }

  ///This is the class to perform actions on files uploaded to dropbox
  FilesActions filesActions;
  

}