#include "..\script_component.hpp"

INFO("initConfig running...");

private _settingsGroup = ["GRAD Civs", "a) diagnostics"];

[
    QGVAR(showFps),
    "CHECKBOX",
    "Show server & HC fps",
    _settingsGroup,
    false,
    true,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showOnMap),
    "CHECKBOX",
    "Show civs on map",
    _settingsGroup,
    false,
    true,
    FUNC(showOnMap),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showInfoLine),
    "CHECKBOX",
    "Show info line",
    _settingsGroup,
    false,
    true,
    FUNC(showInfoLine),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showPinkArrows),
    "CHECKBOX",
    "Create 3D arrows over civ heads",
    _settingsGroup,
    false,
    true,
    FUNC(showPinkArrows),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showPaths),
    "SLIDER",
    "Show up to N paths",
    _settingsGroup,
    [0, 20, 0, 0],
    true,
    FUNC(showOnMap),
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showMisc),
    "CHECKBOX",
    "Miscellaneous stuff",
    _settingsGroup,
    false,
    true,
    FUNC(showHonkAtArea),
    false
] call CBA_fnc_addSetting;
