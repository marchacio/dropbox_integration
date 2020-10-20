import 'package:dropbox_client/dropbox_client.dart' as dbx;
import 'package:http/http.dart' as http;

import 'package:dropbox_integration/Classes/ALL.dart';


class FilesActions {

  final String userToken;
  FilesActions(this.userToken);

  get json => null;


  ///Upload a file to your Dropbox storage
  ///
  ///`localPath` is the path of the local file (the file on the device).
  ///`dropboxPath` is the path to the folder where the file will be placed
  ///
  ///__Required Dropbox Scope: files.content.write__
  ///
  /// * `dropboxPath` should start with "/" (that's root folder)
  Future<void> uploadFile(String localPath, String dropboxPath) async 
    => await dbx.Dropbox.upload(localPath, dropboxPath);



  ///Download a file from Dropbox storage to local storage
  ///
  ///`localPath` is the path where you want to download the file on the device (needs `WRITE_EXTERNAL_STORAGE` permission, [check this to do it](https://stackoverflow.com/a/50571167/10148111)).
  ///`dropboxPath` is the dropobox path from which the file will be downloaded (it must also contain the file extension)
  ///
  /// __Required Dropbox Scope: files.content.read__
  Future<void> downloadFile(String dropboxPath, String localPath) async 
    => await dbx.Dropbox.download(dropboxPath, localPath);


  ///Delete a file from Dropbox storage
  ///
  ///`filePath` must be the Dropbox file path that you want to delete
  ///
  ///__Required Dropbox Scope: files.content.write__
  Future<void> deleteFile(String filePath) async {
    String body = json.encode({'path' : filePath});

    await http.post(
      'https://api.dropboxapi.com/2/files/delete_v2',
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
      },
      body: body
    );
  }



  ///Return a `List<DropboxFileTypes>` that contains user's files and directory
  Future<List<DropboxFileTypes>> getFilesList(String dropboxPath) async {
    List<DropboxFileTypes> _dbxFilesList = [];

    var list = await dbx.Dropbox.listFolder(dropboxPath);

    for (var rawFile in list) {
      if(rawFile.keys.length == 3){
        _dbxFilesList.add(DropboxDirectory.fromMap(rawFile));
      } else {
        _dbxFilesList.add(DropboxFile.fromMap(rawFile));
      }
    }

    return _dbxFilesList;
  }





}