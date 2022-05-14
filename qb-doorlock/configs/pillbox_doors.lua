

-- maindoor created by QuakeAcid
Config.DoorList['pillbox_doors-maindoor'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'main_door',
    distance = 2,
    locked = false,
    doors = {
        {objName = 661758796, objYaw = 249.98274230957, objCoords = vec3(300.030792, -583.726257, 42.284008)},
        {objName = -487908756, objYaw = 249.98274230957, objCoords = vec3(299.227844, -585.932312, 42.284008)}
    },
    doorRate = 1.0,
    doorType = 'doublesliding',
}

-- receptiondoor created by QuakeAcid
Config.DoorList['pillbox_doors-receptiondoor'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    distance = 1.6,
    locked = true,
    objYaw = 249.98275756836,
    objName = 854291622,
    doorRate = 1.0,
    objCoords = vec3(313.480072, -595.458313, 43.433910),
    fixText = false,
    doorType = 'door',
    doorLabel = 'receptiondoor',
}

-- staffdoor created by QuakeAcid
Config.DoorList['pillbox_doors-staffdoor'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    distance = 2,
    locked = true,
    objYaw = 160.00003051758,
    objName = 854291622,
    doorRate = 1.0,
    objCoords = vec3(309.133728, -597.751465, 43.433910),
    fixText = false,
    doorType = 'door',
    doorLabel = 'staffdoor',
}

-- lobbydouble1 created by QuakeAcid
Config.DoorList['pillbox_doors-lobbydouble1'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'lobbydouble1',
    distance = 2,
    locked = true,
    doors = {
        {objName = -434783486, objYaw = 340.00003051758, objCoords = vec3(324.236023, -589.226196, 43.433910)},
        {objName = -1700911976, objYaw = 340.00003051758, objCoords = vec3(326.654999, -590.106628, 43.433910)}
    },
    doorRate = 1.0,
    doorType = 'double',
}

-- bossdoor created by QuakeAcid
Config.DoorList['pillbox_doors-bossdoor'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    distance = 2,
    locked = true,
    objYaw = 340.00003051758,
    objName = 854291622,
    doorRate = 1.0,
    objCoords = vec3(339.004974, -586.703369, 43.433910),
    fixText = false,
    doorType = 'door',
    doorLabel = 'bossdoor',
}

-- wardadoor created by QuakeAcid
Config.DoorList['pillbox_doors-wardadoor'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'wardadoor',
    distance = 2,
    locked = true,
    doors = {
        {objName = -1700911976, objYaw = 249.98275756836, objCoords = vec3(325.669464, -580.459595, 43.433910)},
        {objName = -434783486, objYaw = 249.98275756836, objCoords = vec3(326.549896, -578.040649, 43.433910)}
    },
    doorRate = 1.0,
    doorType = 'double',
}

-- garagedouble created by QuakeAcid
Config.DoorList['pillbox_doors-garagedouble'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'garagedouble',
    distance = 2,
    locked = true,
    doors = {
        {objName = 1248599813, objYaw = 205.0061340332, objCoords = vec3(318.665619, -561.008606, 28.947239)},
        {objName = -1421582160, objYaw = 25.005989074707, objCoords = vec3(321.014832, -559.912720, 28.947239)}
    },
    doorRate = 1.0,
    doorType = 'double',
}

-- garagelobby created by QuakeAcid
Config.DoorList['pillbox_doors-garagelobby'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    doorLabel = 'garagelobby',
    distance = 2,
    locked = true,
    doors = {
        {objName = -1700911976, objYaw = 70.006050109863, objCoords = vec3(339.326599, -587.634521, 28.947092)},
        {objName = -434783486, objYaw = 70.006050109863, objCoords = vec3(338.446655, -590.052979, 28.947092)}
    },
    doorRate = 1.0,
    doorType = 'double',
}

-- garage1 created by QuakeAcid
Config.DoorList['pillbox_doors-garage1'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    distance = 5,
    locked = true,
    objYaw = 160.00607299805,
    objName = -820650556,
    doorRate = 1.0,
    objCoords = vec3(337.277679, -564.432007, 29.775291),
    fixText = false,
    doorType = 'garage',
    doorLabel = 'garage1',
    remoteTrigger = true,
}

-- garage2 created by QuakeAcid
Config.DoorList['pillbox_doors-garage2'] = {
    authorizedJobs = { ['ambulance'] = 0 },
    distance = 5,
    locked = true,
    objYaw = 160.00605773926,
    objName = -820650556,
    doorRate = 1.0,
    objCoords = vec3(330.134918, -561.833130, 29.775291),
    fixText = false,
    doorType = 'garage',
    doorLabel = 'garage2',
    remoteTrigger = true,
}