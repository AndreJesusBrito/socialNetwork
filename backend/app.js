const express = require('express');
const server = express();
const bodyParser = require('body-parser')



const { Client } = require('pg');
const client = new Client({
  user: 'andre',
  host: 'localhost',
  database: 'filmes',
  password: 'andre',
  port: 5432,
});

client.connect();


server.set("view engine", "ejs");
server.use(express.static("public"));

server.use(bodyParser.urlencoded({ extended: false }));
server.use(bodyParser.json());




//--------------------------------------------
// Routes
//--------------------------------------------




server.get("/", function(req, res) {
    res.render("search");
    // console.log(req.query.ola);
    // let out = "";
    // client.query('SELECT * FROM filmes ORDER BY nome', (err, dbRes) => {
    //     dbRes.rows.forEach(e => {
    //         out += `<li>${e.nome}</li>`;
    //     });
    //     res.send(`<html><title>Names of filmes</title><ul>${out}</ul></html>`);
    // });
    // res.render("homepage");
    // res.render("home");
    // client.end();
});

server.get("/login", function(req, res) {
    res.render("authentication");
});

server.get("/user/:id", function(req, res) {

});

server.get("/group/:id", function(req, res) {

});

server.get("/search", function(req, res) {

});

server.get("*", function(req, res) {
    res.send("404");
});


//--------------------------------------------
// Action Routes
//--------------------------------------------

server.post("/post", function(req, res) {
    // logic
    // console.log(req.params);
    // console.log(req.body);
    // console.log(req.query);

    let out = "";
    const query = `SELECT * FROM filmes WHERE nomeestudio='${req.body.search}' ORDER BY nome`;
    console.log("query:", query);
    client.query(query, (err, dbRes) => {
        dbRes.rows.forEach(e => {
            out += `<li>${e.nome}</li>`;
        });
        res.send(`<html><title>Names of filmes</title><ul>${out}</ul></html>`);
    });

    // console.log("posted");
    // res.send("you posted");
});
server.delete("/post", function(req, res) {
    // logic
    console.log("posted");
    res.send("you posted");
    // res.send(JSON.stringify(res) + "\n");
});

server.post("/react", function(req, res) {
    // logic
});
server.delete("/react", function(req, res) {
    // logic
});


server.post("/comment", function(req, res) {
    // logic
});
server.delete("/comment", function(req, res) {
    // logic
});

server.post("/share", function(req, res) {
    // logic
});






// start server
server.listen(8000, function() {
    console.log("server online!!!");
});
