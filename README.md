# uj-AImedic

AImedic is a roleplaying script for a gaming environment that simulates a medical system where players can request assistance from AI medics.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

## Features

- Allows players to request assistance from AI medics.
- AI medics perform a revival process with a progress bar.
- Configurable settings for EMS requirements, payment, and progress bar behavior.

## Requirements

- [QBCore Framework](https://github.com/qbcore-framework/qb-core)

## Installation

1. Get the repository:
- [uj-aimedic](https://github.com/unscalable/uj-aimedic)

2. Navigate to the resources folder and add it in your [standalone]:

3. Ensure required dependencies are installed.

4. Customize the configuration in `config.lua` to fit your server's needs.
```-- Example configuration
Config = {
    EMS = {
        DoctorMinRequirement = 1,
    },
    Payment = {
        Price = 1000,
        Method = "bank",
    },
    ProgressBar = {
        ReviveTime = 20000,
        Text = "The medic is treating you",
        DisableMovement = false,
        DisableCarMovement = false,
        DisableMouse = false,
        DisableCombat = true,
    },
    Command = {
        Name = "aimedic",
    },
}``

## Usage

Players can use the command `/aimedic` during their last stand to request assistance. AI medics will spawn, perform a revival process, and charge the player based on the configured payment settings.

```lua
-- Example usage
/aimedic
