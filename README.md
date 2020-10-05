# Receipt scanner
Keep track of your receipt is pretty hard. You need to update the shop names, 
receipt date and total of every receipt.

Why do we not use the digital advantage to our advantage? The receipt scanner solve multiple problems. 
You don't have to keep track of your receipts, you safe (a lot) of time but still see 
every important information in blink of a second.

## Features
- IOS and Android application
- fast and easy receipt parser
- store receipts online
- export receipt to json, xml and jpg
- receipt server

## Architecture
Parsing receipts is not only time consuming, it is moreover a very powerhungry task. Since mobile devices have a unacceptable performance, the parser uses a (traditional) client server architecture.

1. The User makes a foto of a receipt
2. The Application upload the receipt to the sever
3. The Sever parses the receipt and send the output back to the application
4. The Application store the form data at a database

### Privacy
A lot of companies store and sell your data. This is the main reason why I started this project. 
I want to control my private data. Since you are hosting your own server, your don't have to
worry about that.

## Getting started
You can decide if you want to trust the compiled binaries our if you want to build the application at your own.
1. Install Android Studio (with flutter support)
2. Import the project
3. Build the project
4. The binary is located at app/outputs/flutter/flutter-release.*
5. Start the server
6. Install the application and select the right sever adresse

For detailed server information, read the server docs.

## Sources
https://de.wikipedia.org/wiki/Datei:Logo_REWE.svg

