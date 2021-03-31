Common settings
====================

Language
"""""""""""""""

You can select between the German and English language.

API token
""""""""""""

The API token is shown on the server console. You can scan the QR code printed on the server console or type the API token manually.
To apply the API token, press the button with the arrow icons.

*Tip: If you don't want to use an API token, you could leave this field empty.*

Network settings
====================

Detect receipt server
""""""""""""""""""""""""""

This feature allows finding the receipt parser server. To identify the receipt parser server, the zeroconf protocol is used.
This feature works only if both (client and server) are connected to the same network and are in the same subnet.
If the receipt parser server appears, you can press on icon in order to automatically set the receipt parser server IP.

Specify server IP
"""""""""""""""""""""""
You can specify the receipt parser server IP using the server Widget. You could use both domain or IP address.

The client performs a connection test if the server address is applied. If the connection test fails, the address is not applied and appear to be the address specified before or not set.

Valid IPs are e. g. 192.168.0.101
Valid domain: receipt-parser.xyz

*Tip: If you use a domain name, please don't specify the protocol.*

Enable HTTPS
"""""""""""""""

By default, HTTPS is enabled but you could also disable HTTPS if you want to.

**Please note that this is not recommended but might be useful for testing.**

Camera Settings
====================

To improve the quality of the image and the receipt parser output you can set various parameters depending on your conditions.

Rotate image
"""""""""""""""

The client does not detect the rotation of the image by default.
By default, the image is taken horizontally and no rotation is required.
If you want to take an image vertically, enable rotation. This allows rotating the image by 90 degrees.

**Rotating detection is planned for the future.**

Grayscale image
""""""""""""""""""

This option is recommended to be set. Grayscaled images are easier to parse. However, if you have a bad
lighting conditions, you could disable this feature.

Gaussian blur
""""""""""""""""""

Enable if the image has a lot of noise.

Neuronal network parser
""""""""""""""""""""""""""

The neuronal network parser is more flexible, since it does not require a fixed rule set. Therefore,
is more suitable for bigger projects. However, the neuronal network parser is not implemented in the receipt
parser server at the moment.

At the moment the receipt legacy parser is always used since the trained German, English and French
receipt dataset was to small.

Legacy receipt parser
"""""""""""""""""""""""""

The receipt legacy parser uses a fixed rule set. You can define your store names in the receipt parser
configuration file.

If the store name is not present in the configuration file, the receipt parser could not determine
the store name, thus the receipt data and total (if present).

Send training data
""""""""""""""""""""""

The receipt training dataset is used to train the neuronal network parser. The neuronal network parser works good
on English receipts and on certain stores e.g. Starbucks. However, the parser performs bad on German receipts.

The receipt training dataset is not uploaded to any third-party service, it is uploaded to your receipt parser server.
You have full control over your receipt dataset.

Development
====================

Enable debug output
""""""""""""""""""""""
Enable debug output shows are more detailed error message e.g. the performed POST request.

Show articles (WIP)
""""""""""""""""""""""

Allow, to show the items on the receipt.

Detect edges (WIP)
""""""""""""""""""""""

Allows to detect the edges of your receipt and cut of non receipt content.

**Tip: increase the distance, if it does not work**

Open-source libraries
=======================

Show all open source libraries used in this client.