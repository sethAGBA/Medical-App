// // import 'dart:io';
// // import 'package:device_info_plus/device_info_plus.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class PermissionHandler {
// //   static Future<bool> requestImagePickerPermissions() async {
// //     if (Platform.isIOS || Platform.isAndroid) {
// //       final permissions = [
// //         Permission.camera,
// //         if (Platform.isAndroid && (await _getAndroidVersion()) >= 33)
// //           Permission.photos
// //         else
// //           Permission.storage,
// //       ];

// //       for (var permission in permissions) {
// //         if (!await _checkAndRequestPermission(permission)) {
// //           return false;
// //         }
// //       }
// //     }
// //     return true;
// //   }

// //   static Future<bool> _checkAndRequestPermission(Permission permission) async {
// //     final status = await permission.status;
// //     if (status.isGranted) return true;
// //     if (status.isPermanentlyDenied) {
// //       await openAppSettings();
// //       return false;
// //     }
// //     return await permission.request().isGranted;
// //   }

// //   static Future<int> _getAndroidVersion() async {
// //     if (Platform.isAndroid) {
// //       final deviceInfo = DeviceInfoPlugin();
// //       final androidInfo = await deviceInfo.androidInfo;
// //       return androidInfo.version.sdkInt;
// //     }
// //     return 0;
// //   }
// // }



// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';

// class PermissionManager {
//   static Future<bool> checkAndRequestPermissions({required BuildContext context}) async {
//     if (!Platform.isAndroid && !Platform.isIOS) {
//       debugPrint('Permissions not implemented for platform: ${Platform.operatingSystem}');
//       return true;
//     }

//     final permissions = <Permission>[Permission.camera];
//     if (Platform.isAndroid) {
//       final androidVersion = await _getAndroidVersion();
//       permissions.add(androidVersion >= 33 ? Permission.photos : Permission.storage);
//     } else if (Platform.isIOS) {
//       permissions.add(Permission.photos);
//       final photoStatus = await Permission.photos.status;
//       if (photoStatus.isLimited && context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//            SnackBar(
//             content: Text('Accès limité aux photos. Certaines images peuvent ne pas être disponibles.'),
//             action: SnackBarAction(
//               label: 'Paramètres',
//               onPressed: () => openAppSettings(),
//             ),
//           ),
//         );
//       }
//     }

//     final permissionsToRequest = <Permission>[];
//     for (var permission in permissions) {
//       if (await permission.status.isDenied || await permission.status.isPermanentlyDenied) {
//         permissionsToRequest.add(permission);
//       }
//     }
//     if (permissionsToRequest.isEmpty) return true;

//     Map<Permission, PermissionStatus> statuses;
//     try {
//       statuses = await permissionsToRequest.request();
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur lors de la demande de permissions: $e')),
//         );
//       }
//       return false;
//     }

//     final allGranted = statuses.values.every((status) => status.isGranted);
//     if (!allGranted && context.mounted) {
//       String getPermissionName(Permission permission) {
//         switch (permission) {
//           case Permission.camera:
//             return 'Caméra';
//           case Permission.photos:
//             return 'Photos';
//           case Permission.storage:
//             return 'Stockage';
//           default:
//             return permission.toString();
//         }
//       }

//       final missing = statuses.entries
//           .where((e) => !e.value.isGranted)
//           .map((e) => getPermissionName(e.key))
//           .join(', ');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Permissions nécessaires non accordées: $missing'),
//           action: SnackBarAction(
//             label: 'Paramètres',
//             onPressed: () => openAppSettings(),
//           ),
//         ),
//       );
//     }

//     return allGranted;
//   }

//   static Future<int> _getAndroidVersion() async {
//     if (!Platform.isAndroid) return 0;
//     final deviceInfo = DeviceInfoPlugin();
//     final androidInfo = await deviceInfo.androidInfo;
//     return androidInfo.version.sdkInt;
//   }
// }





import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionManager {
  static Future<bool> checkAndRequestPermissions({required BuildContext context}) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      debugPrint('Permissions not implemented for platform: ${Platform.operatingSystem}');
      return true;
    }

    final permissions = <Permission>[Permission.camera];
    if (Platform.isAndroid) {
      final androidVersion = await _getAndroidVersion();
      permissions.add(androidVersion >= 33 ? Permission.photos : Permission.storage);
    } else if (Platform.isIOS) {
      permissions.add(Permission.photos);
      final photoStatus = await Permission.photos.status;
      if (photoStatus.isLimited && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Accès limité aux photos. Certaines images peuvent ne pas être disponibles.'),
            action: SnackBarAction(
              label: 'Paramètres',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    }

    final permissionsToRequest = <Permission>[];
    for (var permission in permissions) {
      if (await permission.status.isDenied || await permission.status.isPermanentlyDenied) {
        permissionsToRequest.add(permission);
      }
    }
    if (permissionsToRequest.isEmpty) return true;

    Map<Permission, PermissionStatus> statuses;
    try {
      statuses = await permissionsToRequest.request();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la demande de permissions: $e')),
        );
      }
      return false;
    }

    final allGranted = statuses.values.every((status) => status.isGranted);
    if (!allGranted && context.mounted) {
      String getPermissionName(Permission permission) {
        switch (permission) {
          case Permission.camera:
            return 'Caméra';
          case Permission.photos:
            return 'Photos';
          case Permission.storage:
            return 'Stockage';
          default:
            return permission.toString();
        }
      }

      final missing = statuses.entries
          .where((e) => !e.value.isGranted)
          .map((e) => getPermissionName(e.key))
          .join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permissions nécessaires non accordées: $missing'),
          action: SnackBarAction(
            label: 'Paramètres',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }

    return allGranted;
  }

  static Future<bool> checkAndRequestStoragePermissions({required BuildContext context}) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      debugPrint('Permissions not implemented for platform: ${Platform.operatingSystem}');
      return true;
    }

    final permissions = <Permission>[];
    if (Platform.isAndroid) {
      final androidVersion = await _getAndroidVersion();
      permissions.add(androidVersion >= 33 ? Permission.photos : Permission.storage);
    } else if (Platform.isIOS) {
      permissions.add(Permission.photos);
    }

    final permissionsToRequest = <Permission>[];
    for (var permission in permissions) {
      if (await permission.status.isDenied || await permission.status.isPermanentlyDenied) {
        permissionsToRequest.add(permission);
      }
    }
    if (permissionsToRequest.isEmpty) return true;

    Map<Permission, PermissionStatus> statuses;
    try {
      statuses = await permissionsToRequest.request();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la demande de permissions: $e')),
        );
      }
      return false;
    }

    final allGranted = statuses.values.every((status) => status.isGranted);
    if (!allGranted && context.mounted) {
      String getPermissionName(Permission permission) {
        return permission == Permission.photos ? 'Photos' : 'Stockage';
      }
      final missing = statuses.entries
          .where((e) => !e.value.isGranted)
          .map((e) => getPermissionName(e.key))
          .join(', ');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permissions nécessaires non accordées: $missing'),
          action: SnackBarAction(
            label: 'Paramètres',
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    }
    return allGranted;
  }

  static Future<int> _getAndroidVersion() async {
    if (!Platform.isAndroid) return 0;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }
}