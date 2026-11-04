::mods_hookExactClass("scenarios/world/rangers_scenario", function( q )
{
    // 1. Intercept create() to clean up or rewrite the description text injected by Reforged
    local create = q.create;
    q.create = function()
    {
        create();

        // Reforged appends: "\n[color=#bcad8c]Pathfinders:[/color] All recruits have access to the Pathfinder perk."
        // We look for Reforged's Pathfinders string and replace it with Nine Lives flavor text.
        local oldText = "\n[color=#bcad8c]Pathfinders:[/color] All recruits have access to the Pathfinder perk.";
        local newText = "\n[color=#bcad8c]Nine Lives:[/color] All recruits have access to the Nine Lives perk, cheating death when the wild strikes hardest.";

        // Replace string if found, otherwise append nicely
        local idx = this.m.Description.find(oldText);
        if (idx != null)
        {
            // Simple string replacement approach or rewrite
            this.m.Description = this.m.Description.slice(0, idx) + newText + this.m.Description.slice(idx + oldText.len());
        }
        else
        {
            // Fallback if text format changes
            this.m.Description += "\n[color=#bcad8c]Nine Lives:[/color] All recruits have access to the Nine Lives perk.";
        }
    };

    // 2. Intercept onBuildPerkTree to clear Pathfinder and add Nine Lives
    local onBuildPerkTree = q.onBuildPerkTree;
    q.onBuildPerkTree = function( _perkTree )
    {
        // Run original/Reforged perk tree building first
        onBuildPerkTree(_perkTree);

        // Remove Pathfinder if it was added by Reforged
        if (_perkTree.hasPerk("perk.pathfinder"))
        {
            _perkTree.removePerk("perk.pathfinder");
        }

        // Add Nine Lives instead (Reforged style string identifier or perk def constant)
        if (!_perkTree.hasPerk("perk.nine_lives"))
        {
            _perkTree.addPerk("perk.nine_lives");
        }
    };
});
