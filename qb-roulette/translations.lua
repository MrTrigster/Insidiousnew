Translations = {}

function _(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub('^%l', string.upper))
end

Translations['en'] = {
    ['limit_exceed'] = 'Su panus on liiga suur või väike selle laua jaoks',
    ['invalid_bet'] = 'Vale panuse summa',
    ['chair_used'] = 'See tool on hõivatud',
    ['can_not_bet_because_started'] = 'Mäng on alanud, hetkel ei saa panust teha',
    ['not_enough_chips'] = 'Sul ei ole piisavalt raha, et panustada',
    ['input_place_bet'] = 'Kui palju soovid panustada?',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Play Roulette',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Stand up\n~INPUT_CONTEXT~ Change camera\n~INPUT_LOOK_LR~ Select number\n~INPUT_ATTACK~ Bet number\n~INPUT_CELLPHONE_UP~ Raise bet\n~INPUT_CELLPHONE_DOWN~ Reduce bet\n~INPUT_JUMP~ Custom bet amount',
    -- nui
    ['starting_soon'] = 'Mäng on algamas..',
    ['game_going_on'] = 'Mäng on pooleli..',
    ['seconds'] = 'sekundit.',
    -- formatted msg
    ['won_chips'] = 'Sa võitsid $%s. Multiplier: x%s',
    ['placed_bet'] = 'Tegid panuse $%s'
}

Translations['hu'] = {
    ['limit_exceed'] = 'Túl nagy vagy túl alacsony a téted.',
    ['invalid_bet'] = 'Érvénytelen tét érték.',
    ['chair_used'] = 'Ez a szék foglalt.',
    ['can_not_bet_because_started'] = 'Már elkezdődött a játszma, nem rakhatsz tétet.',
    ['not_enough_chips'] = 'Nincs elég chipsed hogy megtedd a tétet.',
    ['input_place_bet'] = 'Tét megadása',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Leülés a rulett asztalhoz.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Felállás\n~INPUT_CONTEXT~ Kameranézet váltás.\n~INPUT_LOOK_LR~ Szám kiválasztása\n~INPUT_ATTACK~ Szám megrakása\n~INPUT_CELLPHONE_UP~ Tét emelése\n~INPUT_CELLPHONE_DOWN~ Tét csökkentése\n~INPUT_JUMP~ Tét megadása',
    -- nui
    ['starting_soon'] = 'Játék hamarosan kezdődik..',
    ['game_going_on'] = 'Játék jelenleg folyamatban..',
    ['seconds'] = 'másodperc.',
    -- formatted msg
    ['won_chips'] = 'Nyertél %s chipset.\n(Szorzó x%s)',
    ['placed_bet'] = 'Tét megrakva %s chipssel.'
}
