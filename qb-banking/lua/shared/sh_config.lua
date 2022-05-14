SimpleBanking = SimpleBanking or {} 
SimpleBanking.Config = SimpleBanking.Config or {}


SimpleBanking.Config["Days_Transaction_History"] = 7 -- How many days should the transaction history go back in the bank?

SimpleBanking.Config["business_ranks"] = { -- what ranks can see the society accounts in the menu, and deposit/withdraw/transfer from them?
    ["andrus"] = true,
}


SimpleBanking.Config["business_ranks_overrides"] = {
    -- jobs
    ["mechanic"] = { -- If you want a certain company to use custom job ranks, add them like below. otherwise, it defaults back to business_ranks
        ["boss"] = true,
    },
    ["import"] = {
        ["ceo"] = true,
    },
    ["police"] = {
        ["boss"] = true,
        ["assistantchief"] = true,
    },
    ["burgershot"] = {
        ["ceo"] = true,
    },
    ["ambulance"] = {
        ["boss"] = true,
    },
    ['government'] = {
        ['mayor'] = true,
    },
    ['senate'] = {
        ['boss'] = true,
    },
    ['casino'] = {
        ['ceo'] = true,
    },
    ['rea'] = {
        ['boss'] = true,
    },
    ['lawyer'] = {
        ['boss'] = true,
    },
    ['judge'] = {
        ['chiefjudge'] = true,
    },
    ['taxi'] = {
        ['ceo'] = true,
    },
    ['news'] = {
        ['ceo'] = true,
    },


    --gangs
    ["yakuza"] = {
        ["boss"] = true,
    },
}

SimpleBanking.ATMModels = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}