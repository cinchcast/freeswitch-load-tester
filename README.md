# freeswitch-load-tester

Allows for load testing using FreeSWITCH at [Cinchcast|http://cinchcast.com/?refer=freeswitch-load-tester-github]

The way this was designed was to be able to pass custom actions like passing DTMF or playing some audio after some specified amount of time.

It was designed to use the mod_conference function dial to be able to listen to what's going on in order to debug actions.  This is useful sometimes when passing through IVRs and getting down the timing of when to send DTMF.

This version is somewhat opinionated.  Meaning it will assume that you will be using the default dialplan and that the stock conferences exist.  It also assumes to use conference 3000 and use the PCMU codec.  All of this could be changed.

These scripts should be place in your script folder.  The referenced scripts paths are hardcoded and not relative.

To execute these scripts you can really use any method.  The way that we use utilize is via curl.

In the example below `sip-from` is just a caller id string to be passed (it can be anything), and `sip-to` is the full sip-uri to dial.  

For `actions` you can specify several options.  They are parsed as key:value (which are separated by colons ":"), and pair sets are separated by a pipe character `|`.  

```shell
curl "http://<username>:<password@<host or ip>:8080/webapi/bgapi?lua summondialer.lua <sip-from> <sip-to> <actions>"
```

`sleep` - pause for n milliseconds
`dtmf` - send the specified dtmf to called destination
`speak` - transcode the specified text and play it back
`hangup` - hangs up the call

Everything after the question mark (the querystring parameters), but be URL encoded.  And example would be:

```shell
curl "http://freeswitch:works@127.0.0.1:8080/webapi/bgapi?lua summondialer.lua cinchcast-bot 15555551212@12.345.67.89 sleep:5000|dtmf:1234"
```

This gets url encoded as:
```shell
curl "http://freeswitch:works@127.0.0.1:8080/webapi/bgapi?lua%20summondialer.lua%20cinchcast-bot%2015555551212%4012.345.67.89%20sleep%3A5000%7Cdtmf%3A1234%22"
```

Last but not least we have a shell function installed that allows us to loop through this n times.  This is stored in .bash_profile, but could be used any way necessary.

```shell
function run() {
    	number=$1
    	shift
    	for i in `seq $number`; do
      		$@
    	done
}
```

Then you could simply run 100 times by doing the following:

```shell
run 100 curl "http://freeswitch:works@127.0.0.1:8080/webapi/bgapi?lua%20summondialer.lua%20cinchcast-bot%2015555551212%4012.345.67.89%20sleep%3A5000%7Cdtmf%3A1234%22"
``` 

