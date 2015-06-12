# freeswitch-load-tester

Allows for load testing using FreeSWITCH.

The way this was designed was to be able to pass custom actions like passing DTMF or playing some audio after some specified amount of time.

It was designed to use the mod_conference function dial to be able to listen to what's going on in order to debug actions.  This is useful sometimes when passing through IVRs and getting down the timing of when to send DTMF.

This version is somewhat opinionated.  Meaning it will assume that you will be using the default dialplan and that the stock conferences exist.  It also assumes to use conference 3000 and use the PCMU codec.  All of this could be changed.

These scripts should be place in your script folder.  The referenced scripts paths are hardcoded and not relative.

To execute these scripts you can really use any method.  The way that we use utilize is via curl.

Example:
```shell
curl "http://<username>:<password@<host or ip>:8080/webapi/bgapi?lua summondialer.lua <sip-from> <sip-to> <actions>"
```
