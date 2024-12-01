import 'package:contacts_proj/ui/common/app_colors.dart';
import 'package:contacts_proj/ui/common/app_style.dart';
import 'package:contacts_proj/ui/common/ui_helpers.dart';
import 'package:contacts_proj/ui/views/home/widgets/contact_item.dart';
import 'package:contacts_proj/ui/widgets/custom_progress.dart';
import 'package:contacts_proj/ui/widgets/hint_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Mes contacts",
                    style: kcTitleBoldStyle.copyWith(fontSize: 24),
                  ),
                ),
                verticalSpaceSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: HintInputWidget(
                      label: "Rechercher un contact",
                      textInputAction: TextInputAction.search,
                      controller: viewModel.searchController,
                      onChange: viewModel.onSearchChanged,
                      keyboardType: TextInputType.text,
                      suffixIcon: viewModel.searchController.text.isEmpty
                          ? null
                          : InkWell(
                              onTap: () {
                                viewModel.clearSearchContent();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                      identifier: ""),
                ),
                Expanded(
                    child: viewModel.isBusy
                        ? Center(
                            child: CustomProgress(
                              color: Colors.black,
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 60, top: 20),
                            itemBuilder: (context, index) {
                              final contact =
                                  viewModel.filteringContacts[index];
                              return ContactItem(
                                contact: contact,
                                isNotSafe: viewModel.isContactNoSafe(contact),
                              );
                            },
                            itemCount: viewModel.filteringContacts.length,
                          ))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 100.w,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(
                  child: MaterialButton(
                    minWidth: 100.w,
                    height: 45,
                    onPressed: (viewModel.isBusy ||
                            viewModel.busy(viewModel.keyProcessing))
                        ? null
                        : () {
                            viewModel.processContacts();
                          },
                    color: kcAccentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: viewModel.busy(viewModel.keyProcessing)
                        ? CustomProgress(
                            color: Colors.white,
                          )
                        : Text(
                            "Corriger les contacts",
                            style: kcTitleBoldWhiteStyle,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.getContacts();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
