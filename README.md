# payday2-mod-spotter

Aim down sights and the game marks whatever is under your crosshair. A lazy person's spotter build. The mod.txt calls it "Weapon FOV Adjust", which marks nothing.

## what it actually does

While you are in iron sights, the mod raycasts down your camera every 0.2 seconds. Whatever unit that ray hits gets auto-highlighted for the whole team:

- marks enemies and civilians alike
- skips dead units and hostages, since marking those helps nobody
- if the ray hits an attachment or shield piece first, it climbs up to the parent unit and marks that instead
- each unit is marked once per heist, so it does not spam the highlight refresh
- range is 40000 units, which in practice is "anything you can see"

Small correction to the old readme: you do not need to ADS "for long enough" — the first raycast tick after 0.2s already marks the target. It is less a scan and more a laser pointer.

## install

1. install [SuperBLT](https://superblt.znix.xyz) first
2. drop the `Spotter` folder into your Payday 2 `mods` directory
3. aim at people. they become marked. that is it

## warnings

- it is a cheat mod, but the polite kind — marking is a real game mechanic, this just does it without a skill build
- no config file, no shared framework. the 0.2s interval and range live as two numbers at the top of the lua if you want to tune them by hand
- written mid-2026, not re-tested against later game updates

## files

- `Spotter/main.lua` — raycast loop and the markable() check
- `Spotter/mod.txt` — SuperBLT hook manifest
