const express = require("express");
const app = express();
const mysql = require('mysql');


const connection = mysql.createConnection({
  host     : 'tix-jpmc-east.cq3qfzsicvyi.us-east-2.rds.amazonaws.com',
  user     : 'tcuser',
  password : 'quality',
  database : 'jtixchange'
});

//connection.connect((err) => {
    //if(err) throw err;
    //console.log('Connected to MySQL Server!');
//});

app.get("/",(req,res) => {
    connection.query('SELECT * from jtixchange.PROFILE LIMIT 3', (err, rows) => {
    	res.statusCode = 200;
      	res.end();
        if(err) throw err;
        console.log('The data from users table are: \n', rows);
        //connection.end();
    });
});

app.listen(3100, () => {
    console.log('Server is running at port 3100');
});
