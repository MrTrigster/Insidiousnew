local weapons = {
    -- Melee
    [`weapon_unarmed`] = 0.1,
    [`weapon_dagger`] = 0.1,
    [`weapon_bat`] = 0.1,
    [`weapon_bottle`] = 0.1,
    [`weapon_crowbar`] = 0.1,
    [`weapon_flashlight`] = 0.1,
    [`weapon_golfclub`] = 0.1,
    [`weapon_hammer`] = 0.1,
    [`weapon_hatchet`] = 0.1,
    [`weapon_knuckle`] = 0.1,
    [`weapon_knife`] = 0.1,
    [`weapon_machete`] = 0.1,
    [`weapon_switchblade`] = 0.1,
    [`weapon_nightstick`] = 0.01,
    [`weapon_wrench`] = 0.1,
    [`weapon_battleaxe`] = 0.1,
    [`weapon_poolcue`] = 0.1,
    [`weapon_briefcase`] = 0.1,
    [`weapon_briefcase_02`] = 0.1,
    [`weapon_garbagebag`] = 0.1,
    [`weapon_handcuffs`] = 0.1,
    [`weapon_bread`] = 0.1,
    [`weapon_stone_hatchet`] = 0.1,

    -- Handguns
    [`weapon_pistol`] = 0.5,
    [`weapon_pistol_mk2`] = 0.5,
    [`weapon_combatpistol`] = 0.5,
    [`weapon_appistol`] = 0.5,
    [`weapon_stungun`] = 0.5,
    [`weapon_pistol50`] = 0.5,
    [`weapon_snspistol`] = 0.5,
    [`weapon_heavypistol`] = 0.5,
    [`weapon_vintagepistol`] = 0.5,
    [`weapon_flaregun`] = 0.5,
    [`weapon_marksmanpistol`] = 0.5,
    [`weapon_revolver`] = 0.5,
    [`weapon_revolver_mk2`] = 0.5,
    [`weapon_doubleaction`] = 0.5,
    [`weapon_snspistol_mk2`] = 0.5,
    [`weapon_raypistol`] = 0.5,
    [`weapon_ceramicpistol`] = 0.5,
    [`weapon_navyrevolver`] = 0.5,
    [`weapon_gadgetpistol`] = 0.5,

    -- Submachine Guns
    [`weapon_microsmg`] = 0.2,
    [`weapon_smg`] = 0.5,
    [`weapon_smg_mk2`] = 0.5,
    [`weapon_assaultsmg`] = 0.5,
    [`weapon_combatpdw`] = 0.5,
    [`weapon_machinepistol`] = 0.5,
    [`weapon_minismg`] = 0.5,
    [`weapon_raycarbine`] = 0.5,

    -- Shotguns
    [`weapon_pumpshotgun`] = 0.5,
    [`weapon_sawnoffshotgun`] = 0.5,
    [`weapon_assaultshotgun`] = 0.5,
    [`weapon_bullpupshotgun`] = 0.5,
    [`weapon_musket`] = 0.5,
    [`weapon_heavyshotgun`] = 0.5,
    [`weapon_dbshotgun`] = 0.5,
    [`weapon_autoshotgun`] = 0.5,
    [`weapon_pumpshotgun_mk2`] = 0.5,
    [`weapon_combatshotgun`] = 0.5,

    -- Assault Rifles
    [`weapon_assaultrifle`] = 0.3,
    [`weapon_assaultrifle_mk2`] = 0.3,
    [`weapon_carbinerifle`] = 0.3,
    [`weapon_carbinerifle_mk2`] = 0.3,
    [`weapon_advancedrifle`] = 0.3,
    [`weapon_specialcarbine`] = 0.3,
    [`weapon_bullpuprifle`] = 0.3,
    [`weapon_compactrifle`] = 0.3,
    [`weapon_specialcarbine_mk2`] = 0.3,
    [`weapon_bullpuprifle_mk2`] = 0.3,
    [`weapon_militaryrifle`] = 0.3,
    [`weapon_heavyrifle`] = 0.3,

    -- Light Machine Guns
    [`weapon_mg`] = 0.5,
    [`weapon_combatmg`] = 0.5,
    [`weapon_gusenberg`] = 0.5,
    [`weapon_combatmg_mk2`] = 0.5,

    -- Sniper Rifles
    [`weapon_sniperrifle`] = 0.5,
    [`weapon_heavysniper`] = 0.5,
    [`weapon_marksmanrifle`] = 0.5,
    [`weapon_remotesniper`] = 0.5,
    [`weapon_heavysniper_mk2`] = 0.5,
    [`weapon_marksmanrifle_mk2`] = 0.5,

    -- Heavy Weapons
    [`weapon_rpg`] = 0.5,
    [`weapon_grenadelauncher`] = 0.5,
    [`weapon_grenadelauncher_smoke`] = 0.5,
    [`weapon_minigun`] = 0.5,
    [`weapon_firework`] = 0.5,
    [`weapon_railgun`] = 0.5,
    [`weapon_hominglauncher`] = 0.5,
    [`weapon_compactlauncher`] = 0.5,
    [`weapon_rayminigun`] = 0.5,

    -- Throwables
    [`weapon_grenade`] = 0.5,
    [`weapon_bzgas`] = 0.5,
    [`weapon_molotov`] = 0.5,
    [`weapon_stickybomb`] = 0.5,
    [`weapon_proxmine`] = 0.5,
    [`weapon_snowball`] = 0.5,
    [`weapon_pipebomb`] = 0.5,
    [`weapon_ball`] = 0.5,
    [`weapon_smokegrenade`] = 0.5,
    [`weapon_flare`] = 0.5,

    -- Miscellaneous
    [`weapon_petrolcan`] = 0.5,
    [`weapon_fireextinguisher`] = 0.5,
    [`weapon_hazardcan`] = 0.5,
}

CreateThread(function()
    while true do
        for k, v in pairs(weapons) do
            SetWeaponDamageModifierThisFrame(k, v)
            Wait(0)
        end
    end
end)