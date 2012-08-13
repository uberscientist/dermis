connect = require "connect"
app = connect()
app.use connect.static __dirname + '/public/'
app.listen 8080
console.log "Server started"
