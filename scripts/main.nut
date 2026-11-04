::mods_registerMod("mod_rangers_nine_lives", 1.0, "Rangers Nine Lives Scenario");

// Queueing after "mod_hardened" guarantees your hook runs after Hardened's hook
::mods_queue("mod_rangers_nine_lives", "mod_reforged, mod_hardened", function()
{
    // Load the scenario hook after dependencies are resolved
    ::include("scripts/hooks/scenarios/world/rangers_scenario.nut");
});
