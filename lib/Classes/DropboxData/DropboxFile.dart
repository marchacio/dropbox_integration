import 'package:flutter/material.dart';

import 'package:dropbox_integration/Classes/DropboxData/DropboxTypeFiles.dart';


class DropboxFile extends DropboxFileTypes {
  
  ///The last time the user modified the file online
  final DateTime clientModified;

  ///The last time the server modified the file online (most of the time the two coincide)
  final DateTime serverModified;

  ///The size of the file (bytes)
  ///
  ///If you want to show the weight of the file as a human-understandable string, [look here](https://gist.github.com/zzpmaster/ec51afdbbfa5b2bf6ced13374ff891d9)
  final int size;



  ///This is the class for online files
  ///
  ///For folders class, there is the `DropboxDirectory` class
  DropboxFile({
    @required String path,
    @required String name,
    @required this.clientModified,
    @required this.serverModified,
    @required this.size,
    @required String pathLower,
  }) : super(name: name, path: path, pathLower: pathLower);


  ///Return a `DropboxFile` from a map (json)
  static DropboxFile fromMap(Map map) => DropboxFile(
    path: map['pathDisplay'],
    name: map['name'],
    clientModified: DateTime(
      int.parse(map['clientModified'].replaceRange(4, null, '')),
      int.parse((map['clientModified'][4] + map['clientModified'][5])),
      int.parse((map['clientModified'][6] + map['clientModified'][7])),
      int.parse((map['clientModified'][9] + map['clientModified'][10])),
      int.parse((map['clientModified'][11] + map['clientModified'][12])),
      int.parse((map['clientModified'][13] + map['clientModified'][14])),
    ),
    serverModified: DateTime(
      int.parse(map['serverModified'].replaceRange(4, null, '')),
      int.parse((map['serverModified'][4] + map['serverModified'][5])),
      int.parse((map['serverModified'][6] + map['serverModified'][7])),
      int.parse((map['serverModified'][9] + map['serverModified'][10])),
      int.parse((map['serverModified'][11] + map['serverModified'][12])),
      int.parse((map['serverModified'][13] + map['serverModified'][14])),
    ),
    size: map['filesize'],
    pathLower: map['pathLower'],
  );

}