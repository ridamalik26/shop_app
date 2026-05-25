import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/controllers/auth_controller.dart';

import '../../../../provider/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;



  @override

  void initState(){
    super.initState();
    //read the current user data from the provider
    final user = ref.read(userProvider);

    //Initialize the controllers with the current data if available
    //if user data is not available, initialize with an empty String
    _stateController = TextEditingController(text: user?.state?? "" );
    _cityController = TextEditingController(text: user?.city?? "" );
    _localityController = TextEditingController(text: user?.locality?? "" );
  }

  Widget build(BuildContext context) {
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.96),
        elevation: 0,
        title: Text(
          'Delivery',
              style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            letterSpacing: 1.7,
            fontSize: 17
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Where will your order\n be shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  controller: _stateController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter state";
                    }else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _cityController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter city";
                    }else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _localityController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter locality";
                    }else{
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Locality',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await _authController.updateUserLocation(
                  context: context,
                  ref: ref,
                  id: ref.read(userProvider)!.id,
                  state: _stateController.text,
                  city: _stateController.text,
                  locality: _localityController.text,
              )
                  .whenComplete((){
                    updateUser.recreateUserState(
                        state: _stateController.text, city: _stateController.text, locality: _localityController.text);

                    Navigator.pop(context);
              });

            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(
                0xFF3854EE
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Save',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
