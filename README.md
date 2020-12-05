<p align="center">
<img src="https://miro.medium.com/max/700/1*VfeXSnc08x6BTCbPNPCfIg.jpeg">
</p>

# Receipt manager
[![Codemagic build status](https://api.codemagic.io/apps/5fcbc24c59d78f5801f494d8/5fcbc24c59d78f5801f494d7/status_badge.svg)](https://codemagic.io/apps/5fcbc24c59d78f5801f494d8/5fcbc24c59d78f5801f494d7/latest_build) 

Keep track of your receipt is pretty hard. You need to update the shop names, receipt date and a total of every receipt.

Why do we not use the digital advantage to our advantage? The receipt scanner solves multiple problems.  You don't have to keep track of your receipts, you safe (a lot) of time but still, see every important information in a blink of a second.

--- 

## Features
- Android application
- fast and easy receipt parser using OCR
- store receipts permanently in a SQL database
- minimal design
- no other services required

---

## Getting started

### For consumers
Download the precombiled binary. Now, install the precompiled binaries at the release page. 

Now, you can insert, add and store receipts permanently. If you like to parse the receipt using OCR, you
have to do the following.

1. Read the server documentary
2. Clone the image server repository
3. Install the required python dependencies
4. Generate SSL certificates
5. Run the server

#### In detail
Build and run the image server. You will find instructions in the server repository, or click [here](https://github.com/ReceiptManager/Server).
Now, change the server ip. In the application go to `Settings/Server/` and edit the server ip.
<p align="center">
  <img src="https://i.imgur.com/nob0QFz.png">
</p>

---

## Architecture
Parsing receipts is not only time consuming, it is moreover a very powerful task. 
Since mobile devices have a unacceptable performance, the parser uses a (traditional) client server architecture.

#### How it works
1. The User makes a photo of a receipt
2. The Application upload the receipt to the sever
3. The Sever parses the receipt and send the output (as json response) back to the application
4. The Application store the receipt in a SQL database

---

### Privacy
A lot of companies store and sell your data. This is the main reason why I started this project. 
I want to control my private data. Since you are hosting your own server, your don't have to
worry about that. No third party services are used. 

---

### Screenshots
<p align="left">
  <img src="https://raw.githubusercontent.com/ReceiptParser/Application/master/docs/assets/dashboard_app.png">
  
  <img src="https://raw.githubusercontent.com/ReceiptParser/Application/master/docs/assets/history_app.png">
  
  <img src="https://raw.githubusercontent.com/ReceiptParser/Application/master/docs/assets/edit_app.png">
  
  <img src="https://raw.githubusercontent.com/ReceiptParser/Application/master/docs/assets/settings_app.png">
  
  <img src="https://raw.githubusercontent.com/ReceiptManager/Application/master/docs/assets/stats_app.png">

</p>

---

### Releases
[<img src="https://i.imgur.com/DTbi7LK.png" width="150">](https://apt.izzysoft.de/fdroid/index/apk/org.receipt_manager)

You can find precompiled applications on the github release page.

---

## Credits
Thank you for providing these free logos.
| Logo | Creator | Url |
| --- | --- | --- |
| Educator logo | Payungkead | https://www.flaticon.com/free-icon/global-education_3379636?term=education&page=1&position=28 |
| Grocery logo | Freepik | https://www.flaticon.com/free-icon/groceries_3050159?term=groceries&page=1&position=7 |
| Icon pack | unknown | https://www.flaticon.com/packs/retail-59?k=1602359120540 |
| Health icon |  Eucalypt | https://www.flaticon.com/free-icon/health-check_2463800?term=health&page=1&position=6 |
| Entertainment icon | Photo3_Idea_studio | https://www.flaticon.com/free-icon/popcorn_3163478?term=entertainment&page=1&position=9 |
