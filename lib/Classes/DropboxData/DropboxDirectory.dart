
import 'package:dropbox_integration/Classes/DropboxData/DropboxTypeFiles.dart';
import 'package:flutter/material.dart';



class DropboxDirectory extends DropboxFileTypes {

  ///This is the class for online directory
  ///
  ///For files class, there is the `DropboxFile` class
  DropboxDirectory({
    @required String path,
    @required String name,
    @required String pathLower,
  }) : super(name: name, path: path, pathLower: pathLower);


  ///Return a `DropboxDirectory` from a map (json)
  static DropboxDirectory fromMap(Map map) => DropboxDirectory(
    path: map['pathDisplay'],
    name: map['name'],
    pathLower: map['pathLower'],
  );
}