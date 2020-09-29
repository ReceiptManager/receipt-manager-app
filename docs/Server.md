## Connect to the sever
Each foto is transmitted using a *POST* request.

```
var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.0.11:5000/api/upload");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
        
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
```

## Debug server
If the foto is not transmitted. You can craft a POST request using the `client.py`.

```
python src/test/client.py
```
You should see `POST` request in the server console.