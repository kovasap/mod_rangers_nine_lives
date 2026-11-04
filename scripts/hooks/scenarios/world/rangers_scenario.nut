::mods_hookExactClass("scenarios/world/rangers_scenario", function( q )
{
    q.onBuildPerkTree = function( _background )
    {
        _background.addPerk(::Const.Perks.PerkDefs.NineLives);
    };
});
