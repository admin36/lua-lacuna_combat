local game = require(select('1', ...):match(".-game%.")..'init')

--
-- Define class
--
local ServerLobby = game.lib.upperclass:define("ServerLobby", game.classes.Gamestate)

--
-- Holds a reference to our runtime which we need for various sub-systems
-- the runtime object is obtained through the enter() method
--
property : runtime {
    nil;
    get='public';
    set='private';
}

--
-- Holds the network manager callbacks registered during state enter() so they can 
-- be unregistered if needed
property : networkManagerCallbacks {
    nil;
    get='public';
    set='private';
    type='any';
}

--
-- Holds our lobby debug lines
--
property : debugLines { {} ; get='public' ; set='private' }

--
-- Class Constructor
--
function private:__construct()
    self.networkManagerCallbacks = {onConnectCB = nil, onDisconnectCB = nil, onRecieveCB = nil}
end

--
-- Gamestate enter callback
--
function public:enter(RUNTIME)
    table.insert(self.debugLines, "Server Lobby")
    self.runtime = RUNTIME
    
    self.networkManagerCallbacks.onConnectCB    = {self, "onNetworkConnect"}
    self.networkManagerCallbacks.onDisconnectCB = {self, "onNetworkDisconnect"}
    self.networkManagerCallbacks.onRecieveCB    = {self, "onNetworkRecieve"}
    
    self.runtime.networkManager:registerCallback("connect",     self.networkManagerCallbacks.onConnectCB)
    self.runtime.networkManager:registerCallback("disconnect",  self.networkManagerCallbacks.onDisconnectCB)
    self.runtime.networkManager:registerCallback("recieve",     self.networkManagerCallbacks.onRecieveCB)
    
    self.runtime.networkManager:serve("*", 6000, 16)
end

function public:update(DT)
end

function public:draw()
    local bottom = love.graphics.getHeight()
    for a=1, #self.debugLines do
        love.graphics.print(self.debugLines[a], 0, a * 15)
    end
end

function public:onNetworkConnect(EVENT)
    table.insert(self.debugLines, "CONNECT: "..tostring(EVENT.peer))
end

function public:onNetworkDisconnect(EVENT_DATA, EVENT_PEER)
    table.insert(self.debugLines, "DISCONNECT:"..tostring(EVENT_PEER))
end

function public:onNetworkRecieve(EVENT_DATA, EVENT_PEER)
    table.insert(self.debugLines, "RECIEVE:"..tostring(EVENT_PEER))
end

--
-- Compile Class
--
return game.lib.upperclass:compile(ServerLobby)