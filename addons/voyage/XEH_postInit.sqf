#include "script_component.hpp"

if (!([QEGVAR(main,enabled)] call CBA_settings_fnc_get)) exitWith {
    INFO("GRAD civs is disabled. Good bye!");
};

[
    QEGVAR(legacy,spawnAllowed),
    {
        private _maxCivsInVehicles = [QGVAR(maxCivsInVehicles)] call CBA_settings_fnc_get;
        if ((count (["voyage"] call EFUNC(legacy,getGlobalCivs))) < _maxCivsInVehicles) then {
            [ALL_HUMAN_PLAYERS] call FUNC(addCarCrew);
        };
    }
] call CBA_fnc_addEventHandler;

private _spawnDistances = parseSimpleArray ([QGVAR(spawnDistancesInVehicles)] call CBA_settings_fnc_get);
[
    "voyage",
    _spawnDistances#1 * 1.5
] call EFUNC(common,registerCivTaskType);

["business", ["bus_mountUp"], FUNC(sm_business)] call EFUNC(common,augmentStateMachine);

[] call FUNC(setupZeusModules);