
import 'package:flutter/material.dart';
import 'package:markazapp/Constant/City.dart';
import 'package:markazapp/Models/retrive_customermodel.dart';
import 'package:markazapp/Screens/check_outscreeen.dart';
import 'package:markazapp/buttons/buttons.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:markazapp/Services/api_service.dart';
import 'package:nb_utils/nb_utils.dart';

class AddNewAddressTwo extends StatefulWidget {
  final Shipping? initShipping;
  final Billing? initBilling;
  const AddNewAddressTwo({super.key, this.initBilling, this.initShipping});

  @override
  State<AddNewAddressTwo> createState() => _AddNewAddressTwoState();
}

class _AddNewAddressTwoState extends State<AddNewAddressTwo> {
  late APIService apiService;
  RetrieveCustomer retrieveCustomer = RetrieveCustomer();
  Shipping shipping = Shipping();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool addressSwitch = false;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                         'Add New Address',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Form(
                      key: globalKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:
                                  'First Name',
                              hintText:
                                 'Enter your first name',
                            ),
                            initialValue: widget.initShipping?.firstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name cannot be empty';
                              } else if (value.length < 2) {
                                return 'First name cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.firstName = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:
                                 'Last Name',
                              hintText:
                                 'Enter your last name',
                            ),
                            initialValue: widget.initShipping?.lastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  'Last name cannot be empty';
                              } else if (value.length < 2) {
                                return  'Last name cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.lastName = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:'Add New Address 1',
                              hintText:'Enter Street address',
                            ),
                            initialValue: widget.initShipping?.address1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Street address cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.address1 = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Add New Address 2',
                              hintText:'Enter Street address',
                            ),
                            initialValue: widget.initShipping?.address2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return'Street address cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.address2 = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Town / City*',
                              hintText: 'Enter Town / City',
                            ),
                            initialValue: widget.initShipping?.city,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  'Town / City cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.city = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Postcode*',
                                    hintText:  'Enter a postcode',
                                  ),
                                  initialValue: widget.initShipping?.postcode,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Postcode cannot be empty';
                                    } else if (value.length < 4) {
                                      return 'Postcode cannot be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    shipping.postcode = value!;
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'State*',
                                    hintText: 'Enter a State',
                                  ),
                                  initialValue: widget.initShipping?.state,
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (value) {
                                    shipping.state = value!;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Phone Number',
                              hintText:  'Enter Your Phone Number',
                            ),
                            initialValue: widget.initBilling?.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              shipping.phone = value.toString();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Button1(
                        buttonText: 'Save',
                        buttonColor: Colors.orange,
                        onPressFunction: () {
                          if (validateAndSave()) {
                            EasyLoading.show(
                              status:'Updating...',
                            );
                            retrieveCustomer.billing = Billing(
                              firstName: shipping.firstName ?? '',
                              lastName: shipping.lastName ?? '',
                              company: ' ',
                              address1: shipping.address1 ?? '',
                              address2: shipping.address2 ?? '',
                              city: shipping.city ?? '',
                              postcode: shipping.postcode ?? '',
                              country: shipping.country ?? '',
                              phone: shipping.phone ?? '',
                              email: ' ',
                              state: shipping.state ?? '',
                            );

                            retrieveCustomer.shipping = Shipping(
                              firstName: shipping.firstName ?? '',
                              lastName: shipping.lastName ?? '',
                              company: ' ',
                              address1: shipping.address1 ?? '',
                              address2: shipping.address2 ?? '',
                              city: shipping.city ?? '',
                              postcode: shipping.postcode ?? '',
                              country: shipping.country ?? '',
                              state: shipping.state ?? '',
                            );
                            apiService
                                .updateShippingAddress(retrieveCustomer)
                                .then((ret) {
                              if (ret) {
                                const CheckOutScreen()
                                    .launch(context, isNewTask: true);
                                EasyLoading.showSuccess(
                                    'Successful');
                              } else {
                                EasyLoading.showError(
                                   'Failed with Error');
                              }
                            });
                          }
                        }),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    FormState form = globalKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
