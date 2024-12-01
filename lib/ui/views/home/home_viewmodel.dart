import 'dart:async';
import 'dart:developer';

import 'package:contacts_proj/app/app.locator.dart';
import 'package:contacts_proj/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  List<Contact> contacts = [];
  List<Contact> filteringContacts = [];
  final TextEditingController searchController = TextEditingController();

  String get keyProcessing => "processing_contacts";

  Timer? _debounce;

  // Debounce duration
  final Duration _debouceDuration = const Duration(milliseconds: 500);

  Future<void> getContacts() async {
    setBusy(true);
    if (!await FlutterContacts.requestPermission()) {
      contacts = [];
    } else {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true, withAccounts: true);
    }
    filteringContacts = contacts;
    setBusy(false);
  }

  void clearSearchContent() {
    searchController.clear();
    filteringContacts = contacts;
    rebuildUi();
  }

  Future<void> onSearchChanged(String value) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(_debouceDuration, () {
      filteringContacts = contacts.where(
        (contact) {
          final phones = contact.phones
              .map((phone) => phone.number
                  .replaceAll(' ', '')
                  .trim()) // delete spaces
              .toList();

          return contact.displayName
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              phones.any(
                (phone) => phone.contains(value),
              ) ||
              contact.name.first.toLowerCase().contains(value.toLowerCase()) ||
              contact.name.last.toLowerCase().contains(value.toLowerCase());
        },
      ).toList();
      rebuildUi();
    });
  }

  String extractNumberFrom10Digits(String phone) {
    if (phone.startsWith("+229")) {
      return phone.substring(6);
    } else if (phone.startsWith("00229")) {
      return phone.substring(7);
    } else {
      return phone.substring(2);
    }
  }

  String extractNumberFrom8Digits(String phone) {
    if (phone.startsWith("+229")) {
      return phone.substring(4);
    } else if (phone.startsWith("00229")) {
      return phone.substring(5);
    } else {
      return phone;
    }
  }

  bool isContactNoSafe(Contact contact) {
    try {
      // Regex
      final regex8Digits = RegExp(r'^(?:\+229|00229)?\d{8}$'); // 8 digits
      final regex10Digits = RegExp(r'^(?:\+229|00229)?\d{10}$'); // 10 digits

      List<String> cleanedNumbers = contact.phones
          .map((phone) =>
              phone.number.replaceAll(' ', '').trim()) // delete spaces
          .toList();

      Set<String> numbersWith8Digits = {};
      Set<String> numbersWith10Digits = {};

      for (final number in cleanedNumbers) {
        final match10Digit = regex10Digits.firstMatch(number);
        if (match10Digit != null) {
          numbersWith10Digits.add(extractNumberFrom10Digits(number));
          continue;
        }

        final match8Digit = regex8Digits.firstMatch(number);
        if (match8Digit != null) {
          numbersWith8Digits.add(extractNumberFrom8Digits(number));
        }
      }

      // Verify corresponding
      for (final num8 in numbersWith8Digits) {
        if (!numbersWith10Digits.contains(num8)) {
          return true; // Remains version of 10 digits for this number
        }
      }

      for (final num10 in numbersWith10Digits) {
        if (!numbersWith8Digits.contains(num10)) {
          return true; //Remains version of 8 digits for this number
        }
      }
      return false;
    } catch (error) {
      log("An error occured : ${error.toString()}");
      return false;
    }
  }

  List<Contact> filterBenineseContacts(List<Contact> contacts) {
    final regex = RegExp(r'^(\+229|00229)(\d{8})$');
    return contacts.where((contact) {
      return contact.phones.any((phone) =>
          regex.hasMatch(phone.number.replaceAll(' ', '').trim()) ||
          RegExp(r'^\d{8}$').hasMatch(phone.number.replaceAll(' ', '').trim()));
    }).toList();
  }

  List<Contact> filterNotSafeContacts() {
    return contacts
        .where(
          (contact) => isContactNoSafe(contact),
        )
        .toList();
  }

  Future<void> updateContacts(List<Contact> contacts) async {
    for (var contact in contacts) {
      for (var phone in List.from(contact.phones)) {
        //clean number by removing spaces
        var cleanedNumber = phone.number.replaceAll(' ', '').trim();

        //if number is exactly 8 or 10 digits without prefix then add prefix "+229"
        if (RegExp(r'^\d{8}$').hasMatch(cleanedNumber)) {
          cleanedNumber = '+229$cleanedNumber';
        } else if (RegExp(r'^\d{10}$').hasMatch(cleanedNumber)) {
          cleanedNumber = '+229$cleanedNumber';
        }

        //Verify if number is beninese with 8 digits 
        String? newNumber = "";
        final regex8Digits = RegExp(r'^(\+229|00229)(\d{8})$');
        final regex10Digits = RegExp(r'^(\+229|00229)(\d{10})$');
        final match8Digits = regex8Digits.firstMatch(cleanedNumber);
        final match10Digits = regex10Digits.firstMatch(cleanedNumber);

        if (match8Digits != null) {
          newNumber = '+22901${match8Digits.group(2)}';
        } else if (match10Digits != null) {
          newNumber = '+229${match10Digits.group(2)?.substring(2)}';
        }

        //Verify if same number already exists
        if (newNumber.isNotEmpty &&
            !contact.phones
                .any((p) => p.number.replaceAll(' ', '').trim() == newNumber)) {
          //Add new phone number 
          contact.phones
              .add(Phone(newNumber, customLabel: contact.displayName));
        }
      }

      // Enregistre les modifications
      await contact.update();
    }
  }

  Future<void> processContacts() async {
    final response = await _dialogService.showConfirmationDialog(
        title: "Contacts",
        description: "Procéder à la mise à jour de vos contacts ?",
        confirmationTitle: "Oui",
        cancelTitle: "Non",
        confirmationTitleColor: kcAccentColor);

    if (response?.confirmed == true) {
      try {
        setBusyForObject(keyProcessing, true);
        _snackbarService.showSnackbar(
            message:
                "Veuillez patienter. L'opération peut prendre quelques instants");
        final benineseNotSafeContacts = filterNotSafeContacts();
        await updateContacts(benineseNotSafeContacts);
        _snackbarService.showSnackbar(
            message: "Mise à jour effectuée avec succès");
      } catch (e) {
        _snackbarService.showSnackbar(message: e.toString());
      } finally {
        setBusyForObject(keyProcessing, false);
      }
    }
  }
}
