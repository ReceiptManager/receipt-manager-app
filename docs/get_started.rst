Get started
======================================================

At the moment, there are precompiled releases available on our `Github release page <https://github.com/ReceiptManager/receipt-manager-app/releases/>`_
or in the `FDROID <https://android.izzysoft.de/repo/apk/org.receipt_manager>`_ repository.

After, the installation you can add, insert and manage receipts. However, a small configuration is required for OCR.

OCR support
"""""""""""""""

Before you can use OCR to extract the key information out of your receipt a `receipt server <https://github.com/ReceiptManager/receipt-parser-server>`_ **is required.**
For more information, please read the receipt parser server `documentation <https://receipt-parser-server.readthedocs.io/en/master/>`_.

After, executing the receipt parser server. The `API-TOKEN` is shown on the server console.
The receipt server IP is the IP of your server, the receipt parser server is executed on.

**Now, you have to specify following information:**

1. Server Address
2. API token

**For that go to :**

* `SettingsWidget/API token` and specify the API token.

* `SettingsWidget/Server` and specify the receipt parser server domain or IP address.

For more information, please read the settings documentation.