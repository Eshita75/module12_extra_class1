import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Unit Price',
                    labelText: 'Unit Price'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product unit price';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product quantity';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product total price';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _imageTEController,
                  decoration: InputDecoration(
                      hintText: 'Image',
                      labelText: 'Image'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Enter your image';
                    }
                    return null;
                  },

                ),

                SizedBox(
                  height: 16,
                ),

                ElevatedButton(onPressed: (){
                  if(_formState.currentState!.validate()){

                  }
                },
                    style: ElevatedButton.styleFrom(
                    ),
                    child: Text('Update'))
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
