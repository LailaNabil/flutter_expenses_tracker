import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTx;

  TransactionList(this.transactionsList, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).orientation.toString());
    print(MediaQuery.of(context).size.width.toString());
    return Container(
      child: transactionsList.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "No Transactions",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    //leading : widget at the beginning
                    //CircleAvatar
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('\$${transactionsList[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactionsList[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactionsList[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 450
                        ? FlatButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            onPressed: () => deleteTx(
                                  transactionsList[index].id,
                                                              ),
                       // color:  Theme.of(context).errorColor,
                      textColor: Theme.of(context).errorColor)
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () =>
                                deleteTx(transactionsList[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
