-- This controls when a vehicle will be impounded
-- calling the cleanup function (in hours; so 24 * 7 = one week)
cleanUpThresholdTime = 24 * 7
-- this controls the distance at which vehicles will spawn to the closest player 
-- (in meters)
spawnDistance = 200.0
-- set this to false if you do not want entities render as scorched when they 
-- are completely broken
renderScorched = true
CustomFont = nil --[nil]: use system default font - or ['name of your custom font']: You need your_custum_font.gfx EX: CustomFont = 'Oswald'
Garages = {
    --Public Garage:
	['garage1'] = {
        label = 'Alta Street Parkla',
        spawnPoint = {
			vector4(-285.63, -887.42, 30.58, 167.42),
			vector4(-289.26, -886.77, 30.58, 167.82),
			vector4(-292.87, -885.89, 30.58, 168.04),
			vector4(-296.51, -885.18, 30.58, 168.64),
			vector4(-300.09, -884.62, 30.58, 167.68),
			vector4(-303.65, -883.59, 30.58, 167.7),
			vector4(-307.46, -882.84, 30.58, 168.26),
			vector4(-310.97, -881.98, 30.58, 168.32),
			vector4(-314.54, -881.39, 30.58, 168.47),
			vector4(-318.18, -880.56, 30.58, 168.63),
			vector4(-321.83, -879.69, 30.57, 167.46),
			vector4(-325.44, -878.98, 30.57, 167.98),
			vector4(-329.04, -878.3, 30.57, 168.62),
			vector4(-332.79, -877.42, 30.57, 169.35),
			vector4(-336.31, -876.62, 30.57, 169.31),
			vector4(-339.89, -875.88, 30.57, 167.38),
			vector4(-343.59, -874.98, 30.57, 166.89),
			vector4(-298.45, -900.06, 30.58, 348.53),
			vector4(-302.28, -899.31, 30.58, 347.61),
			vector4(-305.79, -898.63, 30.58, 348.7),
			vector4(-309.33, -897.29, 30.58, 347.61),
			vector4(-313.05, -897.14, 30.57, 346.85),
			vector4(-316.77, -896.26, 30.57, 348.83),
			vector4(-320.31, -895.01, 30.57, 347.97),
			vector4(-323.92, -894.7, 30.57, 347.1),
			vector4(-327.51, -893.18, 30.57, 347.06),
			vector4(-331.26, -893.34, 30.57, 346.86),
			vector4(-334.58, -891.68, 30.57, 346.23),
			vector4(-338.58, -891.86, 30.57, 346.98),
			vector4(-278.68, -904.58, 30.58, 69.4),
			vector4(-280.46, -907.94, 30.58, 69.35),
			vector4(-281.68, -911.54, 30.58, 70.35),
			vector4(-282.28, -915.08, 30.58, 68.77),
			vector4(-283.51, -918.59, 30.58, 69.06),
			vector4(-285.04, -922.0, 30.58, 69.21),
			vector4(-308.09, -908.72, 30.57, 167.91),
			vector4(-311.73, -907.87, 30.57, 167.65),
			vector4(-315.28, -907.27, 30.57, 167.58),
			vector4(-318.87, -906.68, 30.57, 167.08),
			vector4(-322.57, -905.75, 30.57, 168.37),
			vector4(-326.2, -904.84, 30.57, 167.69),
			vector4(-329.9, -904.41, 30.57, 168.81),
			vector4(-333.38, -903.27, 30.57, 168.42),
			vector4(-337.02, -902.49, 30.57, 167.44),
			vector4(-340.64, -901.94, 30.57, 167.77),
			vector4(-360.67, -889.52, 30.57, 269.16),
			vector4(-360.92, -893.16, 30.57, 269.95),
			vector4(-360.81, -896.99, 30.57, 268.82),
			vector4(-360.78, -900.64, 30.57, 269.85),
			vector4(-361.05, -904.25, 30.57, 269.73),
			vector4(-361.18, -907.93, 30.58, 269.99),
			vector4(-360.82, -911.68, 30.58, 269.71),
			vector4(-360.94, -915.38, 30.58, 268.82),
			vector4(-360.59, -918.94, 30.58, 270.57),
			vector4(-360.56, -922.67, 30.58, 270.39),
			vector4(-360.91, -926.55, 30.58, 269.91),
			vector4(-360.89, -930.15, 30.58, 269.87),
			vector4(-361.04, -933.94, 30.58, 269.7),
			vector4(-360.84, -937.75, 30.58, 269.76),
			vector4(-360.83, -941.29, 30.58, 269.35),
			vector4(-361.08, -945.1, 30.58, 269.89),
			vector4(-360.88, -948.71, 30.58, 269.76),
			vector4(-361.09, -952.47, 30.58, 270.02),
			vector4(-361.07, -956.19, 30.58, 269.17),
			vector4(-341.96, -921.43, 30.58, 250.09),
			vector4(-343.14, -924.89, 30.58, 250.16),
			vector4(-344.51, -928.47, 30.58, 249.3),
			vector4(-345.75, -931.99, 30.58, 249.62),
			vector4(-326.76, -924.54, 30.58, 70.23),
			vector4(-328.79, -927.96, 30.58, 69.52),
			vector4(-329.51, -931.65, 30.58, 69.25),
			vector4(-331.34, -934.79, 30.58, 70.29),
			vector4(-332.08, -938.42, 30.58, 70.47),
			vector4(-333.42, -942.04, 30.58, 69.11),
			vector4(-335.1, -945.31, 30.58, 69.15),
			vector4(-335.65, -949.04, 30.58, 69.56),
			vector4(-337.17, -952.51, 30.58, 69.69),
			vector4(-327.13, -956.11, 30.58, 249.96),
			vector4(-325.9, -952.63, 30.58, 249.94),
			vector4(-324.4, -949.11, 30.58, 249.77),
			vector4(-323.44, -945.59, 30.58, 249.75),
			vector4(-321.58, -942.21, 30.58, 248.69),
			vector4(-321.08, -938.61, 30.58, 248.93),
			vector4(-319.68, -935.15, 30.58, 249.57),
			vector4(-318.2, -931.72, 30.58, 249.07),
			vector4(-317.09, -928.21, 30.58, 248.46),
			vector4(-301.59, -933.56, 30.58, 69.52),
			vector4(-302.96, -937.1, 30.58, 69.64),
			vector4(-304.0, -940.69, 30.58, 69.35),
			vector4(-305.4, -944.11, 30.58, 68.95),
			vector4(-306.93, -947.44, 30.58, 70.04),
			vector4(-308.03, -951.08, 30.58, 68.83),
			vector4(-309.61, -954.41, 30.58, 70.59),
			vector4(-310.9, -957.93, 30.58, 70.45),
			vector4(-312.13, -961.36, 30.58, 69.02),
			vector4(-313.24, -964.93, 30.58, 68.57),
			vector4(-343.13, -974.24, 30.58, 338.77),
			vector4(-339.55, -975.47, 30.58, 339.48),
			vector4(-336.18, -976.83, 30.58, 339.32),
			vector4(-332.71, -978.15, 30.58, 340.41),
			vector4(-329.25, -979.38, 30.58, 340.7),
			vector4(-325.82, -980.76, 30.58, 339.05),
			vector4(-321.96, -981.4, 30.58, 339.23),
			vector4(-318.64, -983.11, 30.58, 340.0),
			vector4(-315.07, -983.88, 30.67, 341.15),
			vector4(-311.73, -985.37, 30.67, 340.05),
			vector4(-308.13, -986.84, 30.67, 341.25),
			vector4(-304.66, -987.8, 30.67, 339.22),
			vector4(-301.37, -989.19, 30.67, 340.01),
			vector4(-297.86, -990.38, 30.67, 339.59),
		},
		blippoint = vector3(-279.12, -888.78, 31.08),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(-277.81, -886.02),
			vector2(-350.82, -870.54),
			vector2(-350.93, -876.85),
			vector2(-364.04, -876.83),
			vector2(-364.02, -960.54),
			vector2(-344.49, -970.1),
			vector2(-346.89, -976.18),
			vector2(-296.06, -994.68),
			vector2(-289.88, -977.25),
			vector2(-311.05, -969.75),
			vector2(-297.59, -932.39),
			vector2(-303.34, -930.45),
			vector2(-298.82, -919.58),
			vector2(-282.72, -925.09),
			vector2(-271.78, -894.83),
			vector2(-280.08, -891.88),
        },
        minz = 30.02,
        maxz = 39.92,
    },
	['garage2'] = {
        label = 'Paleto Bay Parkla',
        spawnPoint = {
			vector4(-20.04, 6322.43, 30.81, 214.79),
			vector4(-17.21, 6324.74, 30.81, 213.2),
			vector4(-14.3, 6327.79, 30.81, 211.19),
			vector4(-11.81, 6330.79, 30.81, 211.78),
			vector4(-8.74, 6333.25, 30.81, 211.04),
			vector4(-6.01, 6336.02, 30.81, 212.07),
			vector4(-3.01, 6338.49, 30.81, 212.77),
			vector4(-0.52, 6341.45, 30.81, 210.88),
			vector4(8.8, 6350.16, 30.8, 213.23),
			vector4(11.52, 6352.45, 30.81, 214.61),
			vector4(14.18, 6355.34, 30.81, 213.35),
			vector4(16.53, 6358.71, 30.81, 213.31),
			vector4(19.5, 6361.34, 30.81, 213.25),
			vector4(22.09, 6364.25, 30.81, 214.15),
			vector4(24.99, 6366.8, 30.81, 215.71),
			vector4(27.46, 6369.72, 30.8, 216.77),
			vector4(36.92, 6379.72, 30.8, 215.88),
			vector4(39.69, 6382.28, 30.8, 213.24),
			vector4(42.52, 6385.25, 30.8, 213.78),
			vector4(45.32, 6388.02, 30.8, 215.21),
			vector4(47.8, 6391.25, 30.8, 215.29),
			vector4(50.5, 6393.8, 30.8, 215.5),
			vector4(59.07, 6400.85, 30.8, 212.88),
			vector4(61.98, 6403.78, 30.8, 214.6),
			vector4(64.5, 6406.48, 30.8, 213.96),
			vector4(72.3, 6404.26, 30.8, 134.14),
			vector4(75.49, 6401.53, 30.8, 133.19),
			vector4(78.47, 6398.85, 30.8, 133.51),
			vector4(81.06, 6396.21, 30.8, 132.19),
			vector4(25.01, 6345.88, 30.82, 29.45),
			vector4(28.1, 6348.46, 30.82, 30.08),
			vector4(31.09, 6351.15, 30.82, 29.55),
			vector4(33.67, 6354.02, 30.82, 28.94),
			vector4(36.56, 6356.59, 30.82, 32.53),
			vector4(39.54, 6358.8, 30.82, 29.31),
			vector4(48.51, 6362.22, 30.82, 215.32),
			vector4(51.56, 6364.81, 30.82, 215.08),
			vector4(54.12, 6368.01, 30.82, 213.84),
			vector4(60.27, 6375.1, 30.82, 33.01),
			vector4(63.1, 6377.56, 30.82, 34.14),
			vector4(66.05, 6380.09, 30.82, 34.37),
			vector4(101.81, 6376.57, 30.8, 13.32),
			vector4(98.43, 6374.35, 30.8, 12.63),
			vector4(94.82, 6373.16, 30.8, 12.64),
			vector4(80.78, 6366.19, 30.81, 13.2),
			vector4(77.31, 6364.31, 30.81, 14.06),
			vector4(73.71, 6362.83, 30.81, 15.21),
			vector4(70.43, 6361.11, 30.81, 12.35),
			vector4(38.04, 6336.57, 30.81, 15.65),
			vector4(34.78, 6334.79, 30.81, 17.61),
			vector4(31.39, 6333.34, 30.81, 16.81),
			vector4(28.05, 6330.96, 30.81, 17.75),
			vector4(24.56, 6329.15, 30.81, 17.15),
			vector4(21.08, 6327.48, 30.81, 17.07),
			vector4(17.77, 6325.31, 30.81, 20.94),
			vector4(14.2, 6323.68, 30.81, 19.47),
			vector4(10.94, 6321.42, 30.81, 17.95),
			vector4(7.68, 6319.52, 30.81, 16.96),
		},
		blippoint = vector3(31.03, 6344.35, 31.24),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(-25.48, 6326.9),
			vector2(66.53, 6418.76),
			vector2(116.84, 6372.94),
			vector2(-12.46, 6300.82),
			vector2(-25.88, 6316.64),
        },
        minz = 30.02,
        maxz = 39.92,
    },
	['garage3'] = {
        label = 'Del Perro Beach Parkla',
        spawnPoint = {
			vector4(-2051.56, -449.07, 10.7, 138.06),
			vector4(-2048.95, -450.91, 10.99, 140.17),
			vector4(-2046.74, -453.11, 10.99, 140.07),
			vector4(-2044.43, -455.14, 10.99, 140.21),
			vector4(-2041.97, -456.94, 10.99, 139.14),
			vector4(-2039.65, -458.9, 10.99, 139.63),
			vector4(-2037.23, -460.97, 10.99, 139.94),
			vector4(-2024.05, -471.72, 11.0, 140.57),
			vector4(-2021.91, -473.91, 10.99, 140.19),
			vector4(-2019.39, -475.83, 10.99, 138.86),
			vector4(-2017.03, -477.92, 10.99, 139.09),
			vector4(-2014.77, -480.08, 10.99, 140.76),
			vector4(-2012.35, -481.74, 11.0, 140.24),
			vector4(-2009.88, -483.67, 11.0, 139.83),
			vector4(-2007.55, -485.62, 11.0, 139.12),
			vector4(-2005.09, -487.59, 11.0, 141.51),
			vector4(-2012.74, -496.75, 11.26, 319.58),
			vector4(-2015.28, -494.85, 11.29, 319.16),
			vector4(-2017.65, -492.86, 11.29, 320.25),
			vector4(-2023.92, -487.47, 11.29, 321.63),
			vector4(-2026.46, -485.77, 11.3, 320.46),
			vector4(-2028.76, -483.92, 11.3, 318.77),
			vector4(-2031.17, -481.71, 11.29, 319.29),
			vector4(-2033.57, -479.83, 11.28, 319.82),
			vector4(-2040.22, -474.21, 11.24, 320.26),
			vector4(-2042.61, -472.32, 11.25, 319.1),
			vector4(-2044.83, -470.15, 11.25, 316.9),
			vector4(-2047.07, -467.88, 11.23, 319.1),
			vector4(-2049.58, -465.95, 11.24, 320.25),
			vector4(-2057.0, -459.84, 11.25, 320.6),
			vector4(-2059.41, -458.08, 11.26, 320.18),
			vector4(-2061.93, -456.09, 11.27, 320.9),
			vector4(-2064.64, -453.61, 11.26, 319.91),
		},
		blippoint = vector3(-2032.14, -467.47, 11.38),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(-2006.61, -506.38),
			vector2(-1989.45, -482.25),
			vector2(-2053.05, -430.02),
			vector2(-2071.43, -451.53),
        },
        minz = 10.67,
        maxz = 16.92,
    },
	['garage4'] = {
        label = 'Downtown Vinewood Parkla',
        spawnPoint = {
			vector4(379.34, 264.98, 102.26, 338.33),
			vector4(375.43, 265.87, 102.6, 336.88),
			vector4(371.6, 267.38, 102.62, 338.23),
			vector4(367.89, 268.58, 102.64, 339.14),
			vector4(363.84, 269.95, 102.65, 339.13),
			vector4(359.71, 271.74, 102.68, 338.85),
			vector4(368.29, 277.12, 102.78, 159.49),
			vector4(371.92, 275.7, 102.72, 158.1),
			vector4(375.85, 274.34, 102.66, 160.18),
			vector4(388.21, 269.6, 102.59, 69.4),
			vector4(389.76, 273.15, 102.59, 68.56),
			vector4(390.76, 276.88, 102.58, 69.57),
			vector4(392.14, 280.67, 102.57, 68.74),
			vector4(374.89, 283.68, 102.77, 338.74),
			vector4(371.21, 285.01, 102.84, 339.78),
			vector4(386.82, 291.35, 102.64, 163.98),
			vector4(382.73, 292.35, 102.7, 163.98),
			vector4(378.91, 293.4, 102.78, 162.06),
			vector4(374.94, 294.68, 102.86, 163.23),
			vector4(361.2, 293.52, 103.09, 249.27),
			vector4(359.66, 289.96, 103.09, 247.6),
			vector4(358.06, 286.35, 103.08, 248.66),
			vector4(356.99, 282.5, 102.99, 248.11),
		},
		blippoint = vector3(374.71, 279.28, 103.32),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(388.57, 257.13),
			vector2(349.74, 271.67),
			vector2(352.75, 281.97),
			vector2(358.69, 302.3),
			vector2(390.11, 295.08),
			vector2(400.61, 291.21),
        },
        minz = 101.67,
        maxz = 106.92,
    },
	['garage5'] = {
        label = 'Route 68 Parkla',
        spawnPoint = {
			vector4(1098.3, 2662.84, 37.55, 359.33),
			vector4(1101.79, 2663.13, 37.55, 1.09),
			vector4(1105.48, 2663.18, 37.55, 359.96),
			vector4(1111.74, 2657.78, 37.57, 268.43),
			vector4(1111.39, 2654.39, 37.57, 271.09),
			vector4(1116.72, 2647.13, 37.57, 2.3),
			vector4(1120.57, 2647.21, 37.57, 359.62),
			vector4(1124.08, 2647.93, 37.57, 2.78),
			vector4(1127.44, 2647.92, 37.57, 359.19),
			vector4(1131.48, 2647.34, 37.57, 358.56),
		},
		blippoint = vector3(1123.56, 2656.63, 38.0),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(1091.8948974609, 2676.7536621094),
			vector2(1139.7840576172, 2675.5483398438),
			vector2(1140.6735839844, 2643.6525878906),
			vector2(1108.7120361328, 2644.1350097656),
			vector2(1108.6146240234, 2659.7451171875),
			vector2(1091.6341552734, 2659.46484375),
        },
  		minZ = 37.788307189941 - 1,
  		maxZ = 38.694061279297 + 1
    },
	['garage6'] = {
        label = 'Bolingbroke Parkla',
        spawnPoint = {
			vector4(1854.95, 2541.94, 45.25, 270.2),
			vector4(1854.51, 2545.66, 45.25, 270.9),
			vector4(1854.8, 2549.21, 45.25, 271.28),
			vector4(1855.22, 2553.11, 45.25, 272.68),
			vector4(1854.51, 2556.73, 45.25, 271.15),
			vector4(1854.83, 2560.3, 45.25, 267.25),
			vector4(1854.97, 2564.11, 45.25, 270.15),
			vector4(1854.78, 2567.48, 45.25, 271.98),
			vector4(1855.19, 2571.62, 45.25, 270.27),
			vector4(1854.84, 2575.07, 45.25, 268.1),
			vector4(1855.43, 2578.81, 45.25, 272.74),
		},
		blippoint = vector3(1862.46, 2565.43, 45.67),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(1852.3106689453, 2582.8100585938),
			vector2(1887.5792236328, 2582.9799804688),
			vector2(1887.5270996094, 2524.509765625),
			vector2(1852.1411132812, 2525.1655273438),
        },
  		minZ = 45.671352386475 - 1,
  		maxZ = 45.789905548096 + 1
    },
	['garage7'] = {
        label = 'Mirror Park Parkla',
        spawnPoint = {
			vector4(1046.7, -774.52, 57.38, 91.21),
			vector4(1046.74, -778.27, 57.37, 91.85),
			vector4(1046.71, -781.88, 57.36, 90.45),
			vector4(1046.67, -785.56, 57.35, 90.58),
			vector4(1041.76, -791.81, 57.35, 0.2),
			vector4(1038.06, -791.82, 57.31, 1.07),
			vector4(1029.96, -788.15, 57.23, 309.31),
			vector4(1027.58, -785.33, 57.23, 309.61),
			vector4(1025.12, -782.45, 57.23, 310.01),
			vector4(1022.78, -779.62, 57.23, 308.75),
			vector4(1020.52, -776.6, 57.24, 310.55),
			vector4(1018.09, -773.64, 57.25, 310.94),
			vector4(1015.69, -770.86, 57.26, 309.14),
			vector4(1014.47, -762.62, 57.25, 222.58),
			vector4(1017.26, -760.29, 57.33, 222.42),
			vector4(1019.84, -757.65, 57.35, 221.74),
			vector4(1022.68, -755.06, 57.32, 225.5),
			vector4(1029.68, -764.15, 57.35, 55.7),
			vector4(1028.28, -771.05, 57.4, 144.76),
			vector4(1031.31, -773.08, 57.42, 143.09),
		},
		blippoint = vector3(1034.12, -767.06, 58.0),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(1049.33, -769.52),
			vector2(1036.09, -763.23),
			vector2(1022.3, -751.89),
			vector2(1007.55, -764.91),
			vector2(1031.49, -794.63),
			vector2(1049.66, -794.53),
        },
  		minZ = 58.0 - 1,
  		maxZ = 59.0 + 1
    },
	['garage8'] = {
        label = 'LSIA Parkla',
        spawnPoint = {
			vector4(-989.51, -2706.6, 13.19, 332.34),
			vector4(-986.13, -2708.21, 13.19, 334.85),
			vector4(-983.12, -2709.5, 13.19, 341.02),
			vector4(-980.0, -2710.38, 13.2, 345.4),
			vector4(-976.77, -2710.82, 13.21, 352.8),
			vector4(-973.31, -2711.15, 13.21, 359.73),
			vector4(-970.1, -2711.29, 13.2, 4.04),
			vector4(-966.77, -2710.94, 13.19, 8.9),
			vector4(-963.57, -2710.48, 13.19, 11.09),
			vector4(-960.3, -2709.78, 13.19, 11.19),
			vector4(-961.63, -2699.2, 13.19, 150.02),
			vector4(-964.43, -2697.56, 13.19, 149.45),
			vector4(-967.31, -2695.86, 13.19, 150.54),
			vector4(-970.27, -2694.29, 13.19, 150.3),
			vector4(-973.25, -2692.56, 13.19, 149.14),
			vector4(-976.11, -2691.02, 13.19, 149.97),
			vector4(-979.19, -2689.08, 13.19, 150.53),
		},
		blippoint = vector3(-975.8, -2702.23, 13.87),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(-992.69, -2708.57),
			vector2(-979.4, -2685.03),
			vector2(-945.18, -2704.64),
			vector2(-949.4, -2708.8),
			vector2(-958.28, -2712.45),
			vector2(-968.05, -2714.23),
			vector2(-978.56, -2713.88),
        },
  		minZ = 13.19 - 1,
  		maxZ = 14.19 + 1
    },
	['garage9'] = {
        label = 'Signal Street Parkla',
        spawnPoint = {
			vector4(163.07, -3009.36, 5.32, 270.43),
			vector4(162.88, -3006.07, 5.32, 269.44),
			vector4(163.14, -3002.95, 5.32, 269.98),
			vector4(162.81, -2996.3, 5.32, 270.03),
			vector4(162.87, -2993.02, 5.31, 268.8),
			vector4(162.92, -2989.87, 5.3, 271.03),
		},
		blippoint = vector3(164.18, -2999.6, 5.92),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(168.32, -2987.28),
			vector2(168.39, -3010.82),
			vector2(159.17, -3010.94),
			vector2(159.22, -2987.69),
        },
  		minZ = 5.89 - 1,
  		maxZ = 6.89 + 1
  },
	['garage10'] = {
		label = 'Eclipse Blvd Parkla',
		spawnPoint = {
			vector4(-328.88, 274.24, 85.84, 93.58),
			vector4(-328.82, 277.74, 85.84, 95.68),
			vector4(-328.67, 281.46, 85.78, 94.21),
			vector4(-328.44, 285.28, 85.71, 95.9),
			vector4(-328.8, 289.0, 85.66, 95.44),
			vector4(-328.71, 292.54, 85.67, 95.48),
			vector4(-328.57, 295.92, 85.68, 94.37),
			vector4(-328.68, 299.17, 85.68, 95.73),
			vector4(-328.43, 302.4, 85.69, 95.83),
			vector4(-340.08, 300.27, 84.97, 93.86),
			vector4(-339.88, 297.07, 84.98, 94.88),
			vector4(-339.57, 293.82, 85.0, 95.78),
			vector4(-339.56, 290.52, 84.99, 96.87),
			vector4(-340.03, 286.79, 84.96, 94.33),
			vector4(-339.75, 283.26, 84.98, 94.89),
			vector4(-339.63, 279.33, 85.06, 97.18),
			vector4(-349.68, 272.47, 84.58, 270.72),
			vector4(-349.88, 275.9, 84.49, 271.8),
			vector4(-349.92, 279.16, 84.41, 271.89),
			vector4(-349.99, 282.64, 84.4, 273.62),
			vector4(-349.92, 286.23, 84.4, 271.42),
			vector4(-349.85, 289.79, 84.41, 273.18),
			vector4(-349.95, 293.2, 84.41, 271.63),
			vector4(-350.08, 296.71, 84.41, 270.82),
		},
		blippoint = vector3(-339.65, 281.97, 85.5),
		showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(-352.34, 267.12),
			vector2(-325.18, 272.0),
			vector2(-325.27, 308.84),
			vector2(-352.83, 301.48),
		},
		minZ = 84.79 - 1,
		maxZ = 84.79 + 3
	},
	['garage11'] = {
		label = 'Strawberry Avenue Parkla',
		spawnPoint = {
			vector4(33.08, -1623.25, 28.78, 320.48),
			vector4(35.48, -1625.35, 28.78, 320.33),
			vector4(37.9, -1627.11, 28.78, 320.08),
			vector4(40.32, -1628.97, 28.78, 320.89),
			vector4(42.78, -1630.87, 28.78, 320.13),
			vector4(56.32, -1616.86, 28.92, 140.51),
			vector4(54.13, -1615.36, 28.92, 140.91),
			vector4(51.72, -1613.53, 28.91, 140.51),
			vector4(49.56, -1611.34, 28.9, 139.95),
			vector4(47.1, -1609.34, 28.89, 140.04),
			vector4(44.8, -1607.25, 28.9, 140.76),
			vector4(38.71, -1594.31, 28.95, 50.95),
			vector4(40.63, -1592.02, 28.95, 50.63),
			vector4(42.45, -1589.49, 28.95, 50.37),
			vector4(44.58, -1587.29, 28.95, 51.18),
			vector4(46.51, -1584.88, 28.95, 51.45),
			vector4(48.42, -1582.44, 28.95, 51.17),
			vector4(50.5, -1580.17, 28.95, 51.46),
			vector4(52.55, -1577.87, 28.95, 50.59),
			vector4(54.44, -1575.45, 28.95, 51.84),
			vector4(56.57, -1573.21, 28.95, 49.96),
			vector4(58.52, -1570.83, 28.95, 50.35),
			vector4(60.58, -1568.51, 28.95, 51.47),
			vector4(62.33, -1566.01, 28.95, 50.32),
			vector4(64.55, -1563.83, 28.95, 51.19),
			vector4(66.4, -1561.49, 28.95, 49.94),
			vector4(68.28, -1558.96, 28.95, 50.86),
			vector4(70.33, -1556.62, 28.95, 49.4),
			vector4(72.32, -1554.25, 28.95, 50.8),
			vector4(74.32, -1551.97, 28.95, 50.48),
			vector4(76.23, -1549.71, 28.95, 51.37),
			vector4(78.3, -1547.34, 28.95, 50.49),
			vector4(80.34, -1544.91, 28.95, 51.38),
			vector4(82.29, -1542.61, 28.95, 50.0),
			vector4(71.42, -1532.95, 28.95, 230.35),
			vector4(69.21, -1535.35, 28.95, 229.86),
			vector4(67.27, -1537.68, 28.95, 229.61),
			vector4(65.1, -1539.97, 28.95, 230.02),
			vector4(63.11, -1542.34, 28.95, 229.91),
			vector4(61.15, -1544.74, 28.95, 230.98),
			vector4(59.16, -1547.01, 28.95, 230.45),
			vector4(57.38, -1549.49, 28.95, 231.29),
			vector4(55.24, -1551.81, 28.95, 230.18),
			vector4(53.22, -1554.39, 28.95, 231.65),
			vector4(41.23, -1568.26, 28.79, 229.86),
			vector4(39.18, -1570.7, 28.79, 228.46),
			vector4(37.44, -1573.24, 28.78, 229.42),
			vector4(35.52, -1575.57, 28.77, 230.13),
			vector4(33.22, -1577.69, 28.76, 229.95),
			vector4(31.35, -1580.2, 28.75, 229.65),
			vector4(29.3, -1582.38, 28.73, 230.94),
			vector4(27.53, -1584.99, 28.7, 230.84),
			vector4(25.75, -1587.07, 28.7, 230.64),
			vector4(23.66, -1589.11, 28.72, 230.13),
			vector4(21.67, -1591.34, 28.77, 232.15),
		},
		blippoint = vector3(42.85, -1585.02, 29.45),
		showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(42.01, -1636.19),
			vector2(59.12, -1615.86),
			vector2(40.06, -1598.16),
			vector2(86.14, -1542.83),
			vector2(69.86, -1529.49),
			vector2(18.25, -1590.98),
			vector2(30.91, -1601.67),
			vector2(18.42, -1616.48),
		},
		minZ = 29.29 - 1,
		maxZ = 29.29 + 2
	},
	['depot'] = {
        label = 'Impound',
        spawnPoint = {
			vector4(396.3, -1644.46, 28.79, 318.91),
			vector4(398.43, -1646.58, 28.79, 319.31),
			vector4(400.71, -1648.67, 28.79, 319.33),
			vector4(403.25, -1650.56, 28.79, 320.16),
			vector4(405.54, -1652.74, 28.79, 319.84),
			vector4(407.9, -1654.8, 28.79, 319.92),
			vector4(410.58, -1656.9, 28.79, 320.2),
			vector4(418.39, -1646.38, 28.79, 49.59),
			vector4(420.99, -1641.97, 28.79, 88.61),
			vector4(421.03, -1638.86, 28.79, 89.3),
			vector4(420.88, -1635.8, 28.79, 89.22),
			vector4(419.92, -1629.3, 28.79, 140.08),
			vector4(417.3, -1627.48, 28.79, 141.37),
		},
		blippoint = vector3(410.02, -1638.0, 29.29),
        showBlip = true,
		blipsprite = 68,
		blipscale = 0.7,
		blipcolour = 5,
		job = nil, -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 0, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = false,
		zones = {
            vector2(410.33, -1660.35),
			vector2(423.39, -1645.19),
			vector2(424.0, -1640.5),
			vector2(423.87, -1632.95),
			vector2(423.17, -1628.41),
			vector2(411.61, -1619.73),
			vector2(406.27, -1626.09),
			vector2(403.39, -1623.67),
			vector2(388.1, -1641.98),
        },
        minz = 28.02,
        maxz = 39.92,
    },
	--Job Garage:
	['mrpdgarage'] = {
        label = 'Politsei Parkla',
        spawnPoint = {
			vector4(445.92, -996.92, 24.96, 270.5),
			vector4(445.92, -994.25, 24.96, 270.33),
			vector4(446.08, -991.53, 24.96, 269.54),
			vector4(446.1, -988.8, 24.96, 271.8),
			vector4(445.96, -986.21, 24.96, 270.85),
			vector4(436.71, -986.18, 24.96, 90.59),
			vector4(437.24, -988.88, 24.96, 90.1),
			vector4(437.01, -991.53, 24.96, 90.52),
			vector4(436.69, -994.28, 24.96, 90.93),
			vector4(437.26, -996.98, 24.96, 89.1),
			vector4(425.79, -997.06, 24.96, 270.41),
			vector4(425.88, -994.43, 24.96, 270.01),
			vector4(426.06, -991.73, 24.96, 269.92),
			vector4(426.17, -989.05, 24.96, 269.0),
			vector4(425.91, -984.28, 24.96, 269.34),
			vector4(425.86, -981.6, 24.96, 269.16),
			vector4(425.93, -978.74, 24.96, 271.11),
			vector4(426.03, -976.17, 24.96, 270.27),
		},
		blippoint = vector3(441.64, -984.96, 25.7),
        showBlip = false,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = 'police', -- [nil: public garage] ['police: police garage'] ...
		fullfix = true, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(423.16, -1000.29),
			vector2(463.7, -1000.29),
			vector2(463.7, -973.04),
			vector2(423.16, -973.04),
        },
        minz = 24.66,
        maxz = 28.66,
    },
	['mrpdheligarage'] = {
        label = 'Politsei Helikopter',
        spawnPoint = {
			vector4(449.19, -981.28, 44.08, 91.06),
		},
		blippoint = vector3(441.64, -984.96, 25.7),
        showBlip = false,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = 'police', -- [nil: public garage] ['police: police garage'] ...
		fullfix = true, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = false,
		zones = {
            vector2(439.34, -971.23),
			vector2(439.34, -1001.21),
			vector2(463.93, -1001.21),
			vector2(463.93, -971.23),			
        },
        minz = 42.68,
        maxz = 47.08,
    },
	['hospital'] = {
        label = 'Haigla Parkla',
        spawnPoint = {
					vector4(316.36, -578.25, 28.56, 249.94),
					vector4(318.12, -573.95, 28.56, 249.93),
					vector4(319.84, -569.8, 28.56, 250.52),
					vector4(321.22, -565.5, 28.56, 249.66)
		},
		blippoint = vector3(320.54, -567.48, 28.56),
    showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = 'ambulance', -- [nil: public garage] ['police: police garage'] ...
		fullfix = true, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(326.06, -564.93),
			vector2(317.45, -562.03),
			vector2(311.59, -580.0),
			vector2(319.06, -582.65)
        },
        minz = 28.8 - 1,
        maxz = 28.8 + 2,
    },
	['hospitalheligarage'] = {
        label = 'Haigla Helikopter',
        spawnPoint = {
			vector4(351.45, -588.31, 74.55, 337.5),
		},
		blippoint = vector3(352.09, -587.98, 74.17),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = 'ambulance', -- [nil: public garage] ['police: police garage'] ...
		fullfix = true, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(347.87, -579.88),
			vector2(343.17, -592.33),
			vector2(355.91, -596.88),
			vector2(360.32, -583.83),

        },
        minz = 74.17 - 1,
        maxz = 75.17 + 1,
    },
	['mechanicgarage'] = {
		label = 'Mehaanikute Garaaz',
		spawnPoint = {
			vector4(166.33, -3044.52, 5.96, 271.03),
			vector4(166.08, -3050.09, 5.97, 271.14),
		},
		blippoint = vector3(167.03, -3046.25, 5.87),
		showBlip = false,
		blipsprite = 68,
		blipscale = 0.7,
		blipcolour = 5,
		job = 'mechanic', -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(158.92, -3039.48),
			vector2(159.13, -3054.13),
			vector2(172.28, -3054.25),
			vector2(172.75, -3039.27),
		},
		minz = 6.02 - 1,
		maxz = 6.02 + 3,
	},
	['reportergarage'] = {
		label = 'Weazel News Garaaz',
		spawnPoint = {
			vector4(-556.72, -925.5, 23.9, 270.2),
			vector4(-556.83, -929.4, 23.89, 271.41),
			vector4(-556.88, -933.28, 23.88, 270.19),
			vector4(-556.76, -937.86, 23.88, 268.59),
		},
		blippoint = vector3(-552.23, -924.98, 23.86),
		showBlip = false,
		blipsprite = 68,
		blipscale = 0.7,
		blipcolour = 5,
		job = 'news', -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(-554.0, -923.08),
			vector2(-559.62, -923.12),
			vector2(-559.78, -940.23),
			vector2(-554.11, -940.22),
		},
		minz = 23.84 - 1,
		maxz = 23.84 + 3,
	},
	['taxigarage'] = {
		label = 'Takso Garaaz',
		spawnPoint = {
			vector4(908.52, -183.34, 73.78, 56.14),
			vector4(906.71, -186.06, 73.64, 60.13),
			vector4(905.14, -188.94, 73.45, 58.58),
			vector4(903.24, -191.64, 73.42, 59.68),
			vector4(897.45, -183.82, 73.39, 238.49),
			vector4(899.23, -180.45, 73.45, 238.28),
		},
		blippoint = vector3(902.43, -182.12, 73.95),
		showBlip = false,
		blipsprite = 68,
		blipscale = 0.7,
		blipcolour = 5,
		job = 'taxi', -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
			vector2(911.84, -182.87),
			vector2(897.89, -174.51),
			vector2(890.59, -186.02),
			vector2(904.57, -194.27),
		},
		minz = 74.16 - 1,
		maxz = 74.16 + 3,
	},
	-- Police Impound
	['impound'] = {
        label = 'Politsei Impound',
        spawnPoint = {
			vector4(476.12, -1026.06, 27.36, 328.53),
			vector4(479.78, -1025.87, 27.29, 329.69),
			vector4(483.31, -1025.57, 27.27, 330.9),
		},
		blippoint = vector3(479.35, -1022.41, 28.01),
        showBlip = true,
		blipsprite = 68,
		blipscale = 0.7,
		blipcolour = 5,
		job = 'police', -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 2, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = false,
		zones = {
            vector2(467.61, -1030.42),
			vector2(467.17, -1020.57),
			vector2(471.96, -1020.44),
			vector2(471.83, -1017.66),
			vector2(488.37, -1017.52),
			vector2(488.13, -1027.95),
        },
        minz = 27.06,
        maxz = 31.06,
    },
	--Gang Garage:
	--[[['ballas'] = {
        label = 'Ballas Garage',
        spawnPoint = {
			vector4(101.17, -1947.86, 20.35, 52.47),
			vector4(104.58, -1939.74, 20.39, 51.97),
			vector4(109.98, -1932.75, 20.32, 73.93),
		},
		blippoint = vector3(102.69, -1938.39, 20.8),
        showBlip = true,
		blipsprite = 357,
		blipscale = 0.65,
		blipcolour = 3,
		job = 'ballas', -- [nil: public garage] ['police: police garage'] ...
		fullfix = false, -- [true: full fix when take out vehicle]
		garastate = 1, -- [0: Depot] [1: Garage] [2: Impound]
		isHouseGarage = false,
		canStoreVehicle = true,
		zones = {
            vector2(84.18, -1938.56),
			vector2(88.06, -1947.25),
			vector2(93.13, -1953.85),
			vector2(100.28, -1957.92),
			vector2(108.25, -1956.84),
			vector2(118.79, -1950.97),
			vector2(122.93, -1941.33),
			vector2(120.3, -1930.46),
			vector2(112.13, -1923.64),
			vector2(103.24, -1921.11),
			vector2(93.37, -1916.24),
        },
        minz = 19.36,
        maxz = 26.66,
    },]]	
}

--Job Vehicle:
JobVeh = {
	['mechanic'] = {
		['mechanicgarage'] = { --make sure the name is the same as the job garage name configured above(see line 646)
			vehicle = {
				[0] = { --recruit
					['flatbed'] = {
						name = 'Flatbed',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[1] = { --novice
					['flatbed'] = {
						name = 'Flatbed',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[2] = { --experienced
					['flatbed'] = {
						name = 'Flatbed',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[3] = { --advanced
					['flatbed'] = {
						name = 'Flatbed',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[4] = { --manager
					['flatbed'] = {
						name = 'Flatbed',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {

			},
			plate = 'MECH' -- the first four letters of the license plate
		},
	},
	['news'] = {
		['reportergarage'] = { --make sure the name is the same as the job garage name configured above(see line 646)
			vehicle = {
				[0] = { --recruit
					['rumpo'] = {
						name = 'Weazel News Rumpo',
						livery = 0,
						modType = nil,
						modIndex = nil,
					},
				},
				[1] = { --novice
					['rumpo'] = {
						name = 'Weazel News Rumpo',
						livery = 0,
						modType = nil,
						modIndex = nil,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {

			},
			plate = 'NEWS' -- the first four letters of the license plate
		},
	},
	['taxi'] = {
		['taxigarage'] = { --make sure the name is the same as the job garage name configured above(see line 646)
			vehicle = {
				[0] = {
					['taxi'] = {
						name = 'Takso',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['s500w222'] = {
						name = 'Mercedes-Benz S500',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[1] = {
					['taxi'] = {
						name = 'Takso',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['s500w222'] = {
						name = 'Mercedes-Benz S500',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[2] = {
					['taxi'] = {
						name = 'Takso',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['s500w222'] = {
						name = 'Mercedes-Benz S500',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[3] = {
					['taxi'] = {
						name = 'Takso',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['s500w222'] = {
						name = 'Mercedes-Benz S500',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[4] = {
					['taxi'] = {
						name = 'Takso',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['s500w222'] = {
						name = 'Mercedes-Benz S500',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {

			},
			plate = 'TAXI' -- the first four letters of the license plate
		},
	},
	['police'] = {
		['mrpdgarage'] = { --make sure the name is the same as the job garage name configured above(see line 516)
			vehicle = {
				[0] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[1] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[2] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[3] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[4] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[5] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[6] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[7] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtruck'] = {
						name = 'F-150',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[8] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtruck'] = {
						name = 'F-150',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[9] = {
					['pdcvpi'] = {
						name = 'Crown Vic',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtaurus'] = {
						name = 'Taurus',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdcharger'] = {
						name = 'Charger',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdfpiu'] = {
						name = 'Explorer',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtahoe'] = {
						name = 'Tahoe',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
					['pdtruck'] = {
						name = 'F-150',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {
				
			},
			plate = 'LSPD' -- the first four letters of the license plate
		},
		['mrpdheligarage'] = {
			vehicle = {
				[0] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[1] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[2] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[3] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[4] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[5] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[6] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[7] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[8] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
				[9] = {
					['POLMAV'] = {
						name = 'Politsei Helicopter',
						livery = 0,
						modType = 0,
						modIndex = 48,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {
				
			},
			plate = 'LSPD'
		},
	},
	['ambulance'] = {
		['hospital'] = { --make sure the name is the same as the job garage name configured above(see line: 597)
			vehicle = {
				[0] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[1] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[2] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[3] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[4] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
				[5] = {
					['emsnspeedo'] = {
						name = 'Ambulance',
						livery = nil,
						modType = nil,
						modIndex = nil,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {
				
			},
			plate = 'LSES' -- the first four letters of the license plate
		},
		['hospitalheligarage'] = {
			vehicle = {
				[0] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
				[1] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
				[2] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
				[3] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
				[4] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
				[5] = {
					['POLMAV'] = {
						name = 'Kiirabi Helicopter',
						livery = 1,
						modType = 0,
						modIndex = 48,
					},
				},
			},
			useJobspawnPoint = false, --[true: use the spawn point installed below] [false: use job garages spawn point]
			spawnPoint = {
					
			},
			plate = 'LSES'
		},
	},
}

--Items are available in the trunk of the vehicle for industries in the vehicle system for work:
VehJobItems = {
    ['police'] = {
		[1] = {
			name = 'empty_evidence_bag',
			amount = 10,
			info = {},
			type = 'item',
			slot = 1,
		},
	},
	['mechanic'] = {
		[1] = {
			name = 'repairkit',
			amount = 2,
			info = {},
			type = 'item',
			slot = 1,
		},
		[2] = {
			name = 'advancedrepairkit',
			amount = 2,
			info = {},
			type = 'item',
			slot = 2,
		},
		[3] = {
			name = 'cleaningkit',
			amount = 4,
			info = {},
			type = 'item',
			slot = 3,
		},
	},
	['ambulance'] = {
		[1] = {
			name = 'bandage',
			amount = 5,
			info = {},
			type = 'item',
			slot = 1,
		},
		[2] = {
			name = 'firstaid',
			amount = 2,
			info = {},
			type = 'item',
			slot = 2,
		},
		[3] = {
			name = 'painkillers',
			amount = 10,
			info = {},
			type = 'item',
			slot = 3,
		},
	},
	['news'] = {
		
	},
	['taxi'] = {
		
	},
}
