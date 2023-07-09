require('dotenv').config()
const {SERVICE,VERSION} = process.env

const express = require('express')
const app = express()

app.get('/api/devices', function (req, res) {
  res.status(200).json({
    SERVICE,VERSION 
  })
})
const port = 8080 
app.listen(port,()=>console.log(`server ${SERVICE}, ver ${VERSION} is running on port ${port}`))