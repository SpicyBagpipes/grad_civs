#include "..\..\component.hpp"

_this params [
    ["_trigger", objNull]
];

if (isNull _trigger) exitWith {
    ERROR("got NULL instead of a trigger as parameter");
};

GVAR(EXCLUSION_ZONES) pushBack _trigger;

INFO_2("added exclusion zone %1 at %2", triggerArea _trigger, getPos _trigger);
