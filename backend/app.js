const express = require('express');
const server = express();
// const bodyParser = require('body-parser')

server.set("view engine", "ejs");
// server.use(bodyParser);
server.use(express.static("public"));

//--------------------------------------------
// Routes
//--------------------------------------------

server.get("/", function(req, res) {
    res.render("homepage");
    // res.render("home");
});

server.get("/user/*", function(req, res) {

});

server.get("/group/*", function(req, res) {

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
    console.log("posted");
    res.send("you posted");
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
