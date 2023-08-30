const Express = require('express');
const app = Express();

app.get('/', (req, res)=>{
    res.send('App is running');
})

app.listen(2211, ()=>{
    console.log('app port 2211');
})

