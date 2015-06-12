function sleep(uuid, duration)
	freeswitch.msleep(duration);
end

function dtmf(uuid, digits)
        freeswitch.consoleLog("info", "sending dtmf");
	api:executeString("uuid_send_dtmf " .. uuid .. " " .. digits);
end

function speak(uuid, words)
	api:executeString("uuid_displace " .. uuid .. " start shout://translate.google.com/translate_tts?tl=en&q=" .. words .. " 0 m");
end

function hangup(uuid, payload)
	api:executeString("uuid_kill " .. uuid);
end

function transfer(uuid, destination)
	api:executeString("uuid_transfer " .. uuid .. " " .. destination)
end
