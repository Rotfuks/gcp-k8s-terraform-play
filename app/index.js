const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Yeeeey, you\'ve done it, you\'re awesome!!!')

});

app.listen(port, () => {
  console.log(`Example app listening at Port:${port}`)
});