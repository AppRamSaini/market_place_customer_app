class DialogController {
  static bool isDialogOpen = false;

  static void openDialog() {
    isDialogOpen = true;
  }

  static void closeDialog() {
    isDialogOpen = false;
  }
}
