#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "2) basics"];

[
    QGVAR(civClass),
    "EDITBOX",
    "Unit class to use for spawning civilians",
    _settingsGroup,
    "C_Man_1",
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(debugCivState),
    "CHECKBOX",
    "Toggle civ behavior debugging mode.",
    _settingsGroup,
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(debugFps),
    "CHECKBOX",
    "Toggles fps debugging mode",
    _settingsGroup,
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(minCivUpdateTime),
    "SLIDER",
    "Keep civ reaction times under [s]",
    _settingsGroup,
    [0.1, 10, 3, 1],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(minFps),
    "SLIDER",
    "Keep civ owner fps over [1/s]",
    _settingsGroup,
    [10, 50, 35, 0],
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(panicCooldown),
    "EDITBOX",
    "Time for panic to wear off [lowest, median, highest]",
    _settingsGroup,
    QUOTE([ARR_3(15,120,240)]),
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(cleanupCorpses),
    "CHECKBOX",
    "Clean up corpses (requires corpseManagerMode set!)",
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(spawnOnlyWithPlayers),
    "CHECKBOX",
    "Spawn civilians only when players on server",
    _settingsGroup,
    true,
    true,
    {},
    false
] call CBA_fnc_addSetting;
