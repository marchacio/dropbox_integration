
import 'package:flutter/material.dart';
import 'package:path/path.dart' as pathOperations;


///This is the abstract parent class of the file-type-classes (files and folders)
///
///Derived classes are `DropboxFile` and `DropboxDirectory`
abstract class DropboxFileTypes {

  ///This is the Dropbox storage path
  final String path;

  ///This is the name of the file (with extension)
  ///
  ///This is the same as `path.split('/').last`
  final String name;

  ///The lower path
  final String pathLower;


  ///Returns `true` if this is a file.
  ///
  ///Returns `false` if this is a folder.
  bool get isFile {
    if(name.contains('.')) {
      try {
        pathOperations.extension(path);
        return true;
      } catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }


  ///Abstract class for Dropbox files and folders
  DropboxFileTypes({
    @required this.path,
    @required this.name,
    @required this.pathLower,
  });
  
}