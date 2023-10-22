local test = {
  test = "test"
}

Websocket:listen("Socket Started") -- This will print "Socket Started" in the console

-- You can Reach this with http://localhost:30120/[YOURRESOURCENAME]/[URL]
-- Websocket:Get("[URL]", function(request, response)
--   response.send("Hello World")
-- end)

Websocket:Get("/test", function(request, response)
  response.send(tostring(json.encode(test))) -- You need to JSON Object in a String otherwise it will not work
end)

Websocket:Get("/test5", function(request, response)
  response.send("Hello Wor5ld")
end)

Websocket:Post("/test2", function(request, response)
  response.send("Hello World2")
end)