# freeswitch-load-tester

Allows for load testing using FreeSWITCH.

The way this was designed was to be able to pass custom actions like passing DTMF or playing some audio after some specified amount of time.

It was designed to use the mod_conference function dial to be able to listen to what's going on in order to debug actions.  This is useful sometimes when passing through IVRs and getting down the timing of when to send DTMF.

