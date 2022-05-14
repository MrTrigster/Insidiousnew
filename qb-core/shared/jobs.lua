QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved

QBShared.Jobs = {
	['unemployed'] = {
		label = 'Vabakutseline',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Vabakutseline',
                label = 'Vabakutseline',
                payment = 120
            },
        },
	},
	['police'] = {
		label = 'Politsei',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'cadet',
                label = 'Kadett',
                payment = 200
            },
			['1'] = {
                name = 'officer',
                label = 'Ohvitser',
                payment = 215
            },
			['2'] = {
                name = 'seniorofficer',
                label = 'Vanem-Ohvitser',
                payment = 230
            },
			['3'] = {
                name = 'juniorsergeant',
                label = 'Noorem-Seersant',
                payment = 275
            },
			['4'] = {
                name = 'sergeant',
                label = 'Seersant',
                payment = 290
            },
			['5'] = {
                name = 'seniorsergeant',
                label = 'Vanem-Seersant',
                payment = 305
            },
			['6'] = {
                name = 'liutenant',
                label = 'Leitnant',
                payment = 325
            },
			['7'] = {
                name = 'captain',
                label = 'Kapten',
                payment = 350
            },
			['8'] = {
                name = 'assistantchief',
                label = 'Asedirektor',
                payment = 380
            },
			['9'] = {
                name = 'boss',
                label = 'Peadirektor',
				isboss = true,
                payment = 400
            },
        },
	},
	['ambulance'] = {
		label = 'Kiirabi',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'trainee',
                label = 'Trainee',
                payment = 210
            },
			['1'] = {
                name = 'emt',
                label = 'EMT',
                payment = 235
            },
			['2'] = {
                name = 'paramedic',
                label = 'Parameedik',
                payment = 265
            },
			['3'] = {
                name = 'lieutenant',
                label = 'Leitnant',
                payment = 290
            },
			['4'] = {
                name = 'captain',
                label = 'Kapten',
                payment = 350
            },
			['5'] = {
                name = 'boss',
                label = 'Peaarst',
				isboss = true,
                payment = 400
            },
        },
	},
    ['government'] = {
        label = 'Valitsus',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            ['0'] = {
                name = 'vicemayor',
                label = 'Aselinnapea',
                payment = 400
            },
            ['1'] = {
                name = 'mayor',
                label = 'Linnapea',
                payment = 500,
                isBoss = true
            },
        },
    },
    ['senate'] = {
        label = 'Senaat',
        defaultDuty = true,
        offDutyPay = true,
        grades = {
            ['0'] = {
                name = 'boss',
                label = 'Senaator',
                payment = 600,
                isBoss = true
            },
        },
    },
    ['casino'] = {
        label = 'Kasiino',
        defaultDuty = true,
        offDutyPay = true,
        grades = {
            ['0'] = {
                name = 'security',
                label = 'Turvamees',
                payment = 300,
            },
            ['1'] = {
                name = 'manager',
                label = 'Manager',
                payment = 400,
            },
            ['2'] = {
                name = 'ceo',
                label = 'CEO',
                payment = 450,
                isBoss = true
            },
        },
    },
	['taxi'] = {
		label = 'Takso',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Taksojuht',
                label = 'Taksojuht',
                payment = 180
            },
			['1'] = {
                name = 'Vanem-Taksojuht',
                label = 'Vanem-Taksojuht',
                payment = 200
            },
			['2'] = {
                name = 'Manager',
                label = 'Manager',
                payment = 200
            },
			['3'] = {
                name = 'ceo',
                label = 'CEO',
				isboss = true,
                payment = 200
            },
        },
	},
	['mechanic'] = {
		label = 'Mehaanik',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Praktikant',
                label = 'Praktikant',
                payment = 190
            },
			['1'] = {
                name = 'Algaja',
                label = 'Algaja',
                payment = 210
            },
			['2'] = {
                name = 'Mehaanik',
                label = 'Mehaanik',
                payment = 250
            },
			['3'] = {
                name = 'Ülem-Mehaanik',
                label = 'Ülem-Mehaanik',
                payment = 280
            },
			['4'] = {
                name = 'boss',
                label = 'Manager',
                payment = 320,
				isboss = true
            },
        },
	},
	['import'] = {
		label = 'Import',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Praktikant',
                label = 'Praktikant',
                payment = 190
            },
			['1'] = {
                name = 'Müügimees',
                label = 'Müügimees',
                payment = 220
            },
			['2'] = {
                name = 'Ülem-Müügimees',
                label = 'Ülem-Müügimees',
                payment = 250
            },
			['3'] = {
                name = 'Aseülemus',
                label = 'Aseülemus',
                payment = 275
            },
			['4'] = {
                name = 'ceo',
                label = 'CEO',
				isboss = true,
                payment = 325
            },
        },
	},
	["burgershot"] = {
		label = "Burgershot",
		defaultDuty = false,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = "Praktikant",
                label = 'Praktikant',
                payment = 180
            },
			['1'] = {
                name = "Kassapidaja",
                label = 'Kassapidaja',
                payment = 200
            },
			['2'] = {
                name = "Burger Flipper",
                label = 'Burger Flipper',
                payment = 220
            },
			['3'] = {
                name = "Manager",
                label = 'Manager',
                payment = 250
            },
			['4'] = {
                name = "ceo",
                label = 'CEO',
				isboss = true,
                payment = 320
            },
        },
	},
	['judge'] = {
		label = 'Kohtu',
		defaultDuty = true,
		offDutyPay = true,
		grades = {
            ['0'] = {
                name = 'judge',
                label = 'Kohtunik',
                payment = 350,
            },
            ['1'] = {
                name = 'chiefjudge',
                label = 'Peakohtunik',
                payment = 420,
                isBoss = true
            },
        },
	},
	['lawyer'] = {
		label = 'Advokaat',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Advokaat',
                label = 'Advokaat',
                payment = 280
            },
			['1'] = {
                name = 'boss',
                label = 'Ülem-Advokaat',
                payment = 320,
				isboss = true
            },
        },
	},
	['news'] = {
		label = 'Reporter',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Reporter',
                label = 'Reporter',
                payment = 250
            },
            ['1'] = {
                name = 'ceo',
                label = 'CEO',
                payment = 320,
                isBoss = true
            },
        },
	},
    ['rea'] = {
		label = 'Kinnisvara',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'junior',
                label = 'Juunior Maakler',
                payment = 200
            },
            ['1'] = {
                name = 'agent',
                label = 'Maakler',
                payment = 250
            },
            ['2'] = {
                name = 'boss',
                label = 'CEO',
                payment = 310,
                isboss = true
            },
        },
	},
}