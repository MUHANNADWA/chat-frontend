import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/shop/models/site_model.dart';
import 'package:chatbotstudy/features/shop/screens/address/widgets/address_box.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';

class AddressesListview extends StatelessWidget {
  const AddressesListview(
      {super.key, required this.addresses, this.activateChangeAddress});

  final List<Site> addresses;
  final bool? activateChangeAddress;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.sm),
      itemBuilder: (_, index) => AddressBox(
        address: addresses[index],
        activateChangeAddress: activateChangeAddress,
      ),
    );
  }
}
