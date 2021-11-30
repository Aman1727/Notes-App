const express = require("express")
const mongoose = require("mongoose")
var app = express()
var Data = require('./noteSchema')

mongoose.connect("mongodb://localhost/newDB")

mongoose.connection.once("open", function(){
    console.log("Connected to Database!!")
}).on("error", function(error){
    console.log("Failed to connect " + error)
})


//Create a note :- Post Request
app.post("/create", (req,res)=> {
    var note = new Data ({
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    })

    note.save().then(() => {
        if(note.isNew == false){
            console.log("Saved Data!")
            res.send("Saved data!")
        }else {
            console.log("Failed to save data")
        }
    })
})


var server = app.listen(3000,"192.168.135.21", () => {
    console.log("Server is running!")
})

//Delete a note :- Post Request
app.post("/delete", (req,res)=>{
    Data.findOneAndRemove({
        _id: req.get("id")
    }, (err)=> {
        console.log("Failed " + err)
    })

    res.send("Deleted!")

})


// Update a note :- Post Request
app.post('/update',(req,res)=>{

    Data.findOneAndUpdate({
        _id: req.get("id")
    },{
        note: req.get("note"),
        title: req.get("title"),
        date: req.get("date")
    },(err)=>{
        console.log("Failed to update " + err)
    })

    res.send("Updated")

})



// Fetch all the notes :- Get Request
app.get('/fetch',(req,res)=>{
    Data.find({}).then((DBitems)=>{
        res.send(DBitems)
    })
})
