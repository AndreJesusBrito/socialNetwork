const express = require('express');
const app = express();

// const ROOT_PATH = "/andre/socialNetwork";
const ROOT_PATH = "";


// app.set("view engine", "ejs");
// app.use(express.static("public"));

//--------------------------------------------
// Routes
//--------------------------------------------


app.get(ROOT_PATH + "/", function(req, res) {
    console.log("get req at /");
    res.send("TEste my subserver");
    // res.render("home");
});

app.get(ROOT_PATH + "", function(req, res) {
    res.send("404");
});

// start server
app.listen(8000, function() {
    console.log("server online!!!");
});
