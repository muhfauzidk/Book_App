import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;
  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
        centerTitle: true,
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
          child: bookController!.bookList == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.bookList!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return Container(
                      // padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: index == 0
                            ? const Border() // This will create no border for the first item
                            : Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Theme.of(context)
                                        .primaryColor)), // This will create top borders for the rest
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailBookPage(
                                isbn: currentBook.isbn13!,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    // Text(currentBook.subtitle!),
                                    const SizedBox(height: 15),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          currentBook.price!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
