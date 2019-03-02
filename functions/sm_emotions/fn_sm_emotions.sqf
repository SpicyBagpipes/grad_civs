
private _emotions = [{GRAD_CIVS_ONFOOTUNITS + GRAD_CIVS_INVEHICLESUNITS}, true] call CBA_statemachine_fnc_create;

        // STATES

private _emo_relaxed = [
    _emotions,
    {
    },
    {
        _this setVariable ["grad_civs_emo_state_time", CBA_missionTime];
    },
    {
    },
    "emo_relaxed"
] call CBA_statemachine_fnc_addState;

private _emo_wary = [
    _emotions,
    {
    },
    {
        _this setVariable ["grad_civs_emo_state_time", CBA_missionTime];
    },
    {
    },
    "emo_wary"
] call CBA_statemachine_fnc_addState;

private _emo_panic = [
    _emotions,
    {},
    {
        _this setVariable ["grad_civs_emo_state_time", CBA_missionTime];
        ["grad_civ_panicking", [_this]] call CBA_fnc_localEvent;
    },
    {
        ["grad_civ_panicking_end", [_this]] call CBA_fnc_localEvent;
    },
    "emo_panic"
] call CBA_statemachine_fnc_addState;


    // TRANSITIONS


assert ([
    _emotions,
    _emo_panic, _emo_wary,
    {
        private _cooldown = _this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60];
        private _timeUntilCooldown = (_this getVariable ["grad_civs_emo_state_time", 0]) + _cooldown - CBA_missionTime;

        [_this, format["%1 seconds until cooldown", round _timeUntilCooldown]] call grad_civs_fnc_setCurrentlyThinking;
        _timeUntilCooldown <= 0
    },
    {},
    _emo_panic + _emo_wary
] call CBA_statemachine_fnc_addTransition);


assert ([
    _emotions,
    _emo_wary, _emo_relaxed,
    {
        private _cooldown = _this getVariable["GRAD_CIVS_PANICCOOLDOWN", 60];
        private _timeUntilCooldown = (_this getVariable ["grad_civs_emo_state_time", 0]) + _cooldown - CBA_missionTime;

        [_this, format["%1 seconds until cooldown", round _timeUntilCooldown]] call grad_civs_fnc_setCurrentlyThinking;
        _timeUntilCooldown <= 0
    },
    {},
    _emo_wary + _emo_relaxed
] call CBA_statemachine_fnc_addTransition);

assert ([
    _emotions,
    _emo_relaxed, _emo_panic,
    ["fired_near"],
    {true},
    {},
    _emo_relaxed + _emo_panic
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _emotions,
    _emo_wary, _emo_panic,
    ["fired_near"],
    {true},
    {},
    _emo_wary + _emo_panic
] call CBA_statemachine_fnc_addEventTransition);

assert ([
    _emotions,
    _emo_relaxed, _emo_wary,
    ["fired_far"],
    {true},
    {},
    _emo_relaxed + _emo_wary
] call CBA_statemachine_fnc_addEventTransition);

GRAD_CIVS_STATE_EMOTIONS = _emotions;