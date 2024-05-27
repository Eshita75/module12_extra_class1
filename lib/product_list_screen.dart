import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module12_extra_class1/add_product_screen.dart';
import 'package:module12_extra_class1/product.dart';
import 'package:module12_extra_class1/update_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getproductListInProgress = false;
  List<Product> productList = [];

  @override
  void initState() {
    _getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getproductListInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
              itemCount: productList.length,
              itemBuilder: (context, index){
                return _buildProductItem(productList[index]);
          },
            separatorBuilder: (BuildContext context, int index) => Divider()),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen()
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async{
    _getproductListInProgress = true;
    setState(() {});

    productList.clear();
    String ProductListURL = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(ProductListURL);
    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      //data decode
      final decodedData = jsonDecode(response.body);
      //get the list
      final jsonProductList = decodedData['data'];
      //loop over the list
      for(Map<String, dynamic> p in jsonProductList){
        Product product = Product(
            id: p['_id'] ?? '',
            productName: p['ProductName'] ?? '',
            productCode: p['ProductCode'] ?? '',
            image: p['Img'] ?? '',
            unitPrice: p['UnitPrice'] ?? '',
            quantity: p['Qty'] ?? '',
            totalPrice: p['TotalPrice'] ?? '');

        productList.add(product);
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Get product List failed try again'))
      );
    }

    _getproductListInProgress = false;
    setState(() {
    });
  }
  Widget _buildProductItem(Product product) {
    return ListTile(
            leading: Image.network(product.image,
              height: 100,
              width: 80,
            ),
            title: Text(product.productName),
            subtitle: Wrap(
              spacing: 16,
                children: [
                  Text(product.unitPrice),
                  Text(product.quantity),
                  Text(product.totalPrice)
                ]),
            trailing: Wrap(
              children: [
                IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UpdateProductScreen()),
              );
            },
            icon: Icon(Icons.edit),
          ),

          IconButton(onPressed: (){
            _showDeleteConfirmationDialog();
                }, icon: Icon(Icons.delete_outline_sharp)),
              ],
            ),
          );
  }

  _showDeleteConfirmationDialog(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Delete'),
        content: Text('Do you want to delete'),
        actions: [
          TextButton(onPressed: (){}, child: Text('cancel')),
          TextButton(onPressed: (){}, child: Text('delete')),
        ],
      );
    },
    );
  }

}

