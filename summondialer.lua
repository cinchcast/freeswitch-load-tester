dofile("/usr/local/freeswitch/scripts/functions.lua")
dofile("/usr/local/freeswitch/scripts/actions.lua")

--getting arguments
local sip_from = argv[1];
local sip_to = argv[2];
local id = argv[3];
local actions = argv[4];
local app = "[summon_dialer] ";

--intialize the api
api = freeswitch.API();

--create a uuid for the listening conference
local listenConference = api:executeString("create_uuid");

--establish the call
local reply = api:executeString("originate {sip_user_agent=utility::summondialer,absolute_codec_string=PCMU,origination_caller_id_name=" .. sip_from .. ",origination_caller_id_number=" .. sip_from .. "}sofia/external/" .. sip_to .. " utility_" .. id .. " xml default");
local s = freeswitch.Session();
s:consoleLog("info", app .. "Id: " .. id .. "\n");
s:consoleLog("info", app .. "Establishing Call From: " .. sip_from .. ", To: " .. sip_to .. "\n");

--move the actions to an array
local actionsArray = split(actions, "|");

--pulls out the GUID from the reply of the channel in the call
local uuid = reply:gsub("+OK ", "");
uuid = uuid:gsub("\n", "");
s:consoleLog("info", app .. "UUID: " .. uuid .. "\n")

--iterate and execute actions
for k, v in ipairs(actionsArray) do
	actionType = split(v, ":")[1];
	actionParam = split(v, ":")[2];
	s:consoleLog("info", app .. "Executing Command: " .. actionType .. "->" .. actionParam .. "\n")
	_G[actionType](uuid, actionParam);
end
