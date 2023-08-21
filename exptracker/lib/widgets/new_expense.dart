import 'package:exptracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDateTime;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;

  @override
  Widget build(BuildContext context) {
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, bottomSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 64,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text("Amount"),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 64,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: ExpenseCategory.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value == null) {
                                  return;
                                }
                                _selectedCategory = value;
                              });
                            }),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDateTime == null
                                    ? "No date selected."
                                    : formatter.format(_selectedDateTime!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text("Amount"),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDateTime == null
                                    ? "No date selected."
                                    : formatter.format(_selectedDateTime!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: _selectedCategory,
                            items: ExpenseCategory.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value == null) {
                                  return;
                                }
                                _selectedCategory = value;
                              });
                            }),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save"),
                        ),
                      ],
                    )
                ],
              )),
        ),
      );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime.utc(1900),
      lastDate: now,
    );

    setState(() {
      _selectedDateTime = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDateTime == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input."),
                content: const Text(
                    "Please make sure a valid title, amount, date and category was entered."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okay"),
                  )
                ],
              ));
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        datetime: _selectedDateTime!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }
}
