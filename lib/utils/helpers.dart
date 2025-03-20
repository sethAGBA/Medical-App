// Future<void> _pickImage() async {
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  //    Future<void> _pickImage() async {
  //   try {
  //     // Vérifier le statut actuel de la permission
  //     var status = await Permission.storage.status;
      
  //     // Si la permission est refusée définitivement
  //     if (status.isPermanentlyDenied) {
  //       // Afficher une boîte de dialogue personnalisée
  //       final shouldOpenSettings = await showDialog<bool>(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text('Permission requise'),
  //           content: const Text(
  //             'Pour sélectionner une photo de profil, l\'application a besoin d\'accéder à vos photos. '
  //             'Voulez-vous ouvrir les paramètres pour autoriser l\'accès ?'
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, false),
  //               child: const Text('Annuler'),
  //             ),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, true),
  //               child: const Text('Ouvrir les paramètres'),
  //             ),
  //           ],
  //         ),
  //       );
  
  //       if (shouldOpenSettings == true) {
  //         await openAppSettings();
  //         return;
  //       }
  //       return;
  //     }
  
  //     // Demander la permission si elle n'est pas encore accordée
  //     if (!status.isGranted) {
  //       status = await Permission.storage.request();
  //       if (!status.isGranted) {
  //         if (mounted) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Permission refusée. Impossible de sélectionner une image.'),
  //               action: SnackBarAction(
  //                 label: 'Paramètres',
  //                 onPressed: openAppSettings,
  //               ),
  //             ),
  //           );
  //         }
  //         return;
  //       }
  //     }
  
  //     // Si la permission est accordée, sélectionner l'image
  //     final XFile? pickedFile = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 50,
  //     );
  
  //     if (pickedFile != null) {
  //       setState(() {
  //         _image = File(pickedFile.path);
  //       });
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Erreur lors de la sélection de l\'image: $e'),
  //           duration: const Duration(seconds: 3),
  //         ),
  //       );
        
  //     }
  //   }
  // }