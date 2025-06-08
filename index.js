var express = require('express');
var app = express();

app.get('/', function (req, res) {
  res.send('Hello from AWS EC2!');
});

app.listen(process.env.PORT || 3000, function () {
  console.log('Server running on port 3000');
});