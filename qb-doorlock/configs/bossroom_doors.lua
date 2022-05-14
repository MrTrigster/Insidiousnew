

-- garage created by QuakeAcid
Config.DoorList['bossroom_doors-garage'] = {
    authorizedJobs = { ['senate'] = 0 },
    distance = 3,
    locked = true,
    objYaw = 59.000011444092,
    objName = 531616259,
    doorRate = 1.0,
    objCoords = vec3(577.874390, -2804.135986, 7.084585),
    fixText = false,
    doorType = 'garage',
    doorLabel = 'garage',
}

-- secret created by QuakeAcid
Config.DoorList['bossroom_doors-secret'] = {
    authorizedJobs = { ['senate'] = 0 },
    doorLabel = 'secret',
    distance = 2,
    locked = true,
    doors = {
        {objName = -1854394974, objYaw = 239.0, objCoords = vec3(562.660828, -2794.104736, 6.440019)},
        {objName = 2059796542, objYaw = 239.0, objCoords = vec3(563.549011, -2792.628418, 6.437999)}
    },
    doorRate = 1.0,
    doorType = 'double',
}