const Express = require('express');
const app = Express();
app.get('/', (req, res)=>{
    res.send('App is running');
})

app.get('/sec', (req, res)=>{
    res.send('Second api');
})

app.listen(process.env.PROD_PORT, ()=>{
    console.log('app port+ ', process.env.PROD_PORT);
})

