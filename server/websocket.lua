Websocket = {}
Websocket.__index = Websocket
Websocket.Debug = GetConvar("websocket_debug", "false") == "true"

function Websocket:listen(message)
  local self = setmetatable({}, Websocket)

  self:init(message)

  return self
end

local getRequests = {}
function Websocket:Get(url, callback)
  if Websocket.Debug then
    print(">> Websocket Registerd (GET) Path: " .. url)
  end
  getRequests[url] = callback
end

local postRequests = {}
function Websocket:Post(url, callback)
  if Websocket.Debug then
    print(">> Websocket Registerd (POST) Path: " .. url)
  end
  postRequests[url] = callback
end

function Websocket:HandleRequest(request, response)
  local url = request.path
  local method = request.method
  local callback = nil

  if method == "GET" then
    callback = getRequests[url]
  elseif method == "POST" then
    callback = postRequests[url]
  end

  if Websocket.Debug then
    print(callback and ">> Websocket Request (" .. request.method .. ") " .. request.path .. " (200)" or ">> Websocket Request (" .. request.method .. ") " .. request.path .. " (404)")
  end

  if callback ~= nil then
    callback(request, response)
  else
    response.writeHead(404)
    response.send("404 Not Found")
  end
end

function Websocket:init(message)
  print(message)
  SetHttpHandler(function(request, response)
    self:HandleRequest(request, response)
  end)
end