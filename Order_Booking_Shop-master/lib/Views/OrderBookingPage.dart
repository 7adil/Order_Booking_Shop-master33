import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: OrderBookingPage(),
    ),
  ),
);

class OrderBookingPage extends StatefulWidget {
  OrderBookingPage();

  @override
  _OrderBookingPageState createState() => _OrderBookingPageState();
}

class _OrderBookingPageState extends State<OrderBookingPage> {
  TextEditingController _textField1Controller = TextEditingController();
  TextEditingController _textField2Controller = TextEditingController();
  TextEditingController _textField3Controller = TextEditingController();
  TextEditingController _textField4Controller = TextEditingController();

  Set<String> selectedDropdownValues = {};
  List<String> dropdownItems = [
    '1 hAIR  COLOR PCS 50',
    '2 hAIR  COLOR PCS 50',
    '3 hAIR  COLOR PCS 50',
    '4 hAIR  COLOR PCS 50',
  ];

  Map<String, int> itemQuantities = {};
  Map<String, TextEditingController?> dialogTextController1 = {};
  Map<String, TextEditingController?> dialogTextController2 = {};
  Map<String, TextEditingController> incrementController = {};
  Map<String, TextEditingController> decrementController = {};
  Map<String, TextEditingController> manualQuantityController = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Booking'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildTextField('Field 1', _textField1Controller),
            buildTextField('Field 2', _textField2Controller),
            buildTextField('Field 3', _textField3Controller),
            buildTextField('Field 4', _textField4Controller),
            buildCustomDropdown(selectedDropdownValues, dropdownItems),
            // Other widgets...
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the confirm button click
                },
                child: Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCustomDropdown(Set<String> selectedValues, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Dropdown',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDropdownList(selectedValues, items);
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectedValues.isEmpty
                              ? 'Select item(s)'
                              : selectedValues.join(', '),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Display text fields for selected items
        ListView.builder(
          shrinkWrap: true,
          itemCount: selectedValues.length,
          itemBuilder: (BuildContext context, int index) {
            final selectedValue = selectedValues.elementAt(index);
            return buildItemRow(
              selectedValue,
              dialogTextController1[selectedValue],
              dialogTextController2[selectedValue],
              incrementController[selectedValue] ?? TextEditingController(),
              decrementController[selectedValue] ?? TextEditingController(),
              manualQuantityController[selectedValue] ?? TextEditingController(),
            );
          },
        ),
      ],
    );
  }

  Widget buildItemRow(
      String item,
      TextEditingController? textController1,
      TextEditingController? textController2,
      TextEditingController incrementController,
      TextEditingController decrementController,
      TextEditingController manualQuantityController,
      ) {
    bool isSelected = (itemQuantities[item] ?? 0) > 0;

    void toggleSelection() {
      setState(() {
        if (isSelected) {
          // Deselect the item
          itemQuantities[item] = 0;
        } else {
          // Select the item
          itemQuantities[item] = 1;
        }
        isSelected = !isSelected;
      });
    }

    void handleRemoveItem() {
      if (isSelected) {
        // Deselect the item and remove it from the list
        itemQuantities[item] = 0;
        selectedDropdownValues.remove(item);
      }
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    int currentQuantity = itemQuantities[item] ?? 0;
                    if (currentQuantity > 0) {
                      setState(() {
                        itemQuantities[item] = currentQuantity - 1;
                      });
                    }
                  },
                ),
                TextFormField(
                  controller: manualQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'Quantity',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    int currentQuantity = itemQuantities[item] ?? 0;
                    setState(() {
                      itemQuantities[item] = currentQuantity + 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text("Label 1"),
            Text("Label 2"),
          ],
        ),
        Row(
          children: [
            Container(
              width: 100,
              child: TextFormField(
                controller: textController1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                controller: textController2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                controller: incrementController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Increment',
                ),
              ),
            ),
            Container(
              width: 100,
              child: TextFormField(
                controller: decrementController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'Decrement',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isSelected) {
                  handleRemoveItem();
                } else {
                  toggleSelection();
                }
              },
              child: Text(isSelected ? 'Remove' : 'Add'),
            ),
          ],
        ),
      ],
    );
  }

  void showDropdownList(Set<String> selectedValues, List<String> items) {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final List<String> filteredItems = items.where(
                  (item) {
                final query = searchController.text.toLowerCase();
                return item.toLowerCase().contains(query);
              },
            ).toList();

            return AlertDialog(
              title: Text('Select item(s)'),
              content: Container(
                width: 1000,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for items',
                      ),
                      onChanged: (query) {
                        setState(() {});
                      },
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        children: filteredItems.map((item) {
                          return ListTile(
                            title: Text(item),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    int currentQuantity = itemQuantities[item] ?? 0;
                                    if (currentQuantity > 0) {
                                      setState(() {
                                        itemQuantities[item] = currentQuantity - 1;
                                      });
                                    }
                                  },
                                ),
                                Text(itemQuantities[item]?.toString() ?? '0'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    int currentQuantity = itemQuantities[item] ?? 0;
                                    setState(() {
                                      itemQuantities[item] = currentQuantity + 1;
                                    });
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (!selectedValues.contains(item)) {
                                      selectedValues.add(item);
                                    } else {
                                      selectedValues.remove(item);
                                    }
                                  },
                                  child: Text(selectedValues.contains(item) ? 'Remove' : 'Add'),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
