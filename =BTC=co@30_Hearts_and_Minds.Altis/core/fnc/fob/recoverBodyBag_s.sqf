
/* ----------------------------------------------------------------------------
Function: btc_fob_fnc_recoverBodyBag_s

Description:
    Add respawn tickets when a body bag is provided.

Parameters:
    _bodyBag - [Object]

Returns:

Examples:
    (begin example)
        [cursorObject] call btc_fob_fnc_recoverBodyBag_s;
    (end)

Author:
    Vdauphin

---------------------------------------------------------------------------- */

params [
    ["_bodyBag", objNull, [objNull]]
];

private _ticket = 0;
if (_bodyBag getVariable ["btc_isDeadPlayer", false]) then {
    _ticket = btc_fob_ticketPlayerBodyBag;
} else {
    btc_respawn_ticketDecimal = btc_respawn_ticketDecimal + btc_fob_ticketAIBodyBag;
};
private _ticketValue = [btc_player_side, _ticket + btc_respawn_ticketDecimal] call BIS_fnc_respawnTickets;
btc_respawn_ticketDecimal = btc_respawn_ticketDecimal - floor btc_respawn_ticketDecimal;
publicVariable "btc_respawn_ticketDecimal";

deleteVehicle _bodyBag;

[22, _ticketValue + btc_respawn_ticketDecimal] remoteExecCall ["btc_fnc_show_hint", remoteExecutedOwner];
