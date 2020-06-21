#include "..\script_component.hpp"

scopeName "checkPointer_main";


// NOTE: we need to use animationState, as !weaponLowered does *not* mean "weaponRaised"
if (
    (alive player) &&
    {!weaponLowered player} &&
    {vehicle player == player} &&
    {"sras" in (animationState player)}
) then {

    private _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];
    private _possibleCiv = driver cursorTarget;

    /* remove my marker on civ, if i dont target him anymore */
    if !((_currentCiv isEqualTo _possibleCiv) || (cursorTarget isEqualTo (_currentCiv call EFUNC(voyage,getGroupVehicle)))) then { // TODO resolve circular dependency // maybe use `vehicle _currentCiv` instead?
        if (!isNull _currentCiv) then {
            player setVariable ["GRAD_isPointingAtObj", objNull];
            if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then { hint format ["depointing %1", _currentCiv]; };
            [QEGVAR(common,pointed_at_dec), [_currentCiv], [_currentCiv]] call CBA_fnc_targetEvent;
        };
    } else {
        breakTo "checkPointer_main";
    };

    if (!(_possibleCiv isKindOf "Man") && {!(_possibleCiv isKindOf "Car")}) exitWith {};

    /* if civ is civ, alive and they perceive you as a threat, make them a target */
    if ((side _possibleCiv) == civilian && (alive _possibleCiv)) then {
        if ([player, _possibleCiv] call FUNC(checkWeaponOnCivilianPerception)) then {
            player setVariable ["GRAD_isPointingAtObj", _possibleCiv];
            if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then { hint format ["pointing at %1", _possibleCiv]; };
            [QEGVAR(common,pointed_at_inc), [_possibleCiv], [_possibleCiv]] call CBA_fnc_targetEvent;
        };
    };

} else {
    /* lowering weapon should remove civ pointer as well */
    private _currentCiv = player getVariable ["GRAD_isPointingAtObj", objNull];

    if (!isNull _currentCiv) then {
        player setVariable ["GRAD_isPointingAtObj", objNull];
        if (([QGVAR(debugCivState)] call CBA_settings_fnc_get)) then { hint format ["depointing %1", _currentCiv]; };
        [QEGVAR(common,pointed_at_dec), [_currentCiv], [_currentCiv]] call CBA_fnc_targetEvent;
    };
};
