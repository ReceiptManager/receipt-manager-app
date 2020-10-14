<p align="center">
  <img src="https://i.imgur.com/wkWHO3u.png">
</p>


# Receipt manager
Keep track of your receipt is pretty hard. You need to update the shop names, 
receipt date and total of every receipt.

Why do we not use the digital advantage to our advantage? The receipt scanner solve multiple problems. 
You don't have to keep track of your receipts, you safe (a lot) of time but still see 
every important information in blink of a second.

## Features
- IOS and Android application
- fast and easy receipt parser
- store receipts permanently
- export receipt to json, xml and jpg
- minimal design

## Getting started
First, import the project in Android Studio. After you have to install the flutter plugins.
Now, you are able to build the flutter application using the android studio app.

1. Import project in android studio
2. Go to Build/Flutter/Build APK
3. Install the application

Now, you can insert and store receipts permanently. If you like to parse the receipt using OCR, you
have to do the following.

1. Read the server documentary
2. Clone the image server repository
3. Install the required python dependencies
4. Generate SSL certificates
5. Run the server

You can find the required information in the server documentary. Back to the application. Now,
change the server ip. In the application go to Settings/Server/ and edit the server ip.
If the server is running, the server ip is shown in the server console. That's it.

## Architecture
Parsing receipts is not only time consuming, it is moreover a very powerhungry task. 
Since mobile devices have a unacceptable performance, the parser uses a (traditional) client server architecture.

#### How it works
1. The User makes a photo of a receipt
2. The Application upload the receipt to the sever
3. The Sever parses the receipt and send the output back to the application
4. The Application store the form data at a SQL database

### Privacy
A lot of companies store and sell your data. This is the main reason why I started this project. 
I want to control my private data. Since you are hosting your own server, your don't have to
worry about that.

## Credits
I use free logos.
| Logo | Creator | Url |
| --- | --- | --- |
| Educator logo | Payungkead | https://www.flaticon.com/free-icon/global-education_3379636?term=education&page=1&position=28 |
| Grocery logo | Freepik | https://www.flaticon.com/free-icon/groceries_3050159?term=groceries&page=1&position=7 |
| Icon pack | unknown | https://www.flaticon.com/packs/retail-59?k=1602359120540 |
| Health icon |  Eucalypt | https://www.flaticon.com/free-icon/health-check_2463800?term=health&page=1&position=6 |
