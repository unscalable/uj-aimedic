-- CONFIGURATION SETTINGS
Config = {}

-- EMS ONLINE SETTINGS
Config.Doctor = 1 -- Minimum Amount of EMS required to be online

-- PAYMENT SETTINGS
Config.Price = 1000 -- Default payment amount
Config.PaymentMethod = "bank" -- Default payment method ("cash", "bank", or any other method)

-- PROGRESSBAR SETTINGS
Config.ReviveTime = 20000 -- Time in milliseconds for the revive progressbar
Config.ProgressbarText = "The medic is treating you"
Config.ProgressbarDisableMovement = false
Config.ProgressbarDisableCarMovement = false
Config.ProgressbarDisableMouse = false
Config.ProgressbarDisableCombat = true

-- COMMAND SETTINGS
Config.CommandName = "aimedic" -- Example command name

--v1,1