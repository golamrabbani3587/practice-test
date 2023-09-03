const Express = require('express');
const app = Express();
require('dotenv').config()

app.get('/', (req, res)=>{
    res.send('App is running');
})
app.listen(process.env.PROD_PORT, ()=>{
    console.log('app port +', process.env.PROD_PORT);
})

