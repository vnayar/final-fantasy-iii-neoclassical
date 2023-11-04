# Final Fantasy III Neo-Classical Patch

## Purpose

Inspired by [Final Fantasy Restored](https://www.romhacking.net/hacks/1631/), it is clear that the
original spirit of a game is not fully realized due to bugs, hasty deadlines, and other
circumstances, and that game experience can be considerably improved by more closely adhering to the
original intent of the authors.

This patch of [Final Fantasy III](https://www.romhacking.net/games/127/) aims to alter the game to
better realize the intent, as is inferred from the game's code and design decisions.

## Acknowledgements

This work would not have been possible without:
- Data Crystal  https://datacrystal.romhacking.net/wiki/Final_Fantasy_III:ROM_map
- everything8215 https://github.com/everything8215/ff3/

## Installation

Applying a patch will depend on the tools employed and the emulator used. Using
[Fceux](https://fceux.com/web/home.html), IPS patches will be applied automatically if the IPS patch
has a file name matching the ROM name exactly, plus the additional extension of ".ips".

For example, if you have a ROM called "happy.nes", then copying the IPS patch to a file named
"happy.nes.ips" will cause Fceux to apply it automatically.

Rename the patch file included in this project according to the ROM file you have for Final Fantasy III.

## Change Summary

The full details of all changes made can be found in:
[neoclassical-patch-notes.org](https://github.com/vnayar/final-fantasy-iii-neoclassical/blob/master/neoclassical-patch-notes.org).

The original game's mechanics are well described at: https://gamefaqs.gamespot.com/pc/793808-final-fantasy-iii/faqs/29389

The changes are numerous, but a brief summary may be found below:
- Core Mechanics Changes
  - Right-hand melee base damage improved but most weapon damage values reduced in
    compensation. Using two weapons still does more damage, but the gap is less extreme.
  - Bow and arrow damages formulas have better scaling into the late game, serving as
    armor-penetrating weapons.
  - Int/Spi contributions to offensive spells increased from (int|spi)/2 to (int|spi).
    - Magic scales into the late-game.
    - Spell power of most spells reduced to compensate.
    - Enemy (int|spi) reduced by 1/6 to compensate.
  - Spi now contributes (Spi/2) per hit to healing effects, including items.
  - Vulnerability (from running) still doubles incoming damage, but no longer reduces defense and
    evade to 0.
  - Later-game jobs are still more powerful than earlier-game jobs, but the gap is narrower.
  - Boost/Jump Charges now double damage for 1 weapon attack before enemy defense, instead of
    multiplying 1 weapon attack after enemy defense.
  - Each job has a fixed critical strike chance and a bonus base damage for critical hits. Scholar
    and Bard have been modified to give them unique traits.
- Major Bug Fixes
  - Buffs from Haste, Cheer, or Safe are no longer lost upon viewing or using items.
  - Elemental boost effects, such as from Ice Rod, now function and add 33% more hits.
- Equipment Changes
  - Weapon damage values normalized allowing more jobs to be viable throughout the game.
  - Swords have respectable damage, and a high hit chance (90%).
  - Spers have good damage, and a good hit chnce (80%).
  - Axes have high damage, but a fair hit chance (70%).
  - Hammers have very high damage, but a low hit chance (60%).
  - Staves have moderate damage and a low hit chance (65%).
  - Rods have low damage, but a fair hit chance (75%). Often deal elemental damage.
  - Harps have low damage, but apply hexes upon enemies. Heal minor wounds when invoked.
  - Bells have moderate damage, and drain life.
- Job Changes
  - Skill experience needed to gain a skill level has been reduced from 100 to 60, permitting more
    job experimentation.
  - Attributes matter significantly more, permitting broader equipment access while keeping jobs
    distinct.
  - Lower tier jobs gain access to equipment throughout the game, keeping them viable.
  - Abilities that had questionable value were reworked, including Scare, Buildup, and Jump.
  - Steal has been completely re-written:
    - New thieves still have a reasonable chance to steal.
    - Most monsters have more interesting loot.
    - High thief skill allows one to steal rarer items.

## Melee Damage Formula Changes

General Damage Formula for Weapons:
1. Base Damage = (strength contribution) + (weapon power) + skill/4  (see formulas below)
2. Multiply Base Damage randomly by a number in (1 to 1.5).
3. Hit% = (weapon hit%) + agi/4 + skill/4
4. HitMultiplier = agi/16 + level/16 + 1
5. For each HitMultiplier, there's a Hit% chance of landing a hit.
6. Target Evade% = agi/4 + (sum of armor evade%)
7. Target EvadeMultiplier (with shield) = agi/16 + level/16 + (number of shields equipped)
8. Target EvadeMultiplier (without shield) = agi/32 + level/32
9. For each EvadeMultiplier, there's a Evade% chance of subtracting a hit.
10. Multiply the number of landed hits by: (Base Damage) - (Target Defense)

Fight Base Damage Formulas (Original):
- right_weapon_damage = weapon_power + str/4 + skill/4
- left_weapon_damage = weapon_power + str/4 + skill/4
- bow_arrow_damage = bow_power/2 + arrow_power + str/4 + skill/4
- left_unarmed_damage = str/4 + skill/4
- right_unarmed_damage = str/4 + skill/4
- left_martial_arts_damage = level*3/2 + str/4 + skill/4
- right_martial_arts_damage = level*3/2 + str/4 + skill/4

Fight Base Damage Formulas (Neoclassical):
- right_weapon_damage = weapon_power(reduced) + str/2 + skill/4
- left_weapon_damage = weapon_power(reduced) + str/4 + skill/4
- bow_arrow_damage = bow_power + arrow_power + str + skill/4
- left_unarmed_damage = str/4 + skill/4
- right_unarmed_damage = str/4 + skill/4
- left_martial_arts_damage = level*3/2 + str/2 + skill/4
- right_martial_arts_damage = level*3/2 + str/2 + skill/4

## Magic Damage Formula Changes

General Damage Formula for magic:
1. Base Damage = (int|spi contribution) + (spell power)
2. Multiply Base Damage randomly by a number in (1 to 1.5).
3. Hit% = (spell hit%) + (int|spi)/2
4. HitMultiplier = (int|spi)/16 + level/16 + 1
5. For each HitMultiplier, there's a Hit% chance of landing a hit.
6. Target M.Evade% = (int + spi)/2
7. Target M.EvadeMultiplier = (agi/32) + (int + spi)/32 + 1
9. For each M.EvadeMultiplier, there's a M.Evade% chance of subtracting a hit.
10. Multiply the number of landed hits by: (Base Damage) - (Target M.Defense)

Spell Base Damage Formulas (Original):
- black_magic_damage = spell_power + int/2
- white_magic_damage = spell_power + spi/2
- healing_power = spell_power

Spell Base Damage Formulas (Neoclassical):
- black_magic_damage = spell_power(reduced) + int
- white_magic_damage = spell_power(reduced) + spi
- healing_power = spell_power(reduced) + spi/2

## Job Changes

In Final Fantasy III, jobs are unlocked at various crystals. Each tier of jobs unlocked is more
powerful than the previous tiers by a considerable margin. The gap becomes very large, making usage
of these older jobs less viable. Furthermore, older jobs often stop gaining access to equipment as
well, further compounding an already difficult challenge.

The job tiers have been preserved, but their relative differences have been narrowed.

Job Tiers (Original):
| **Job Tier**  | **Level 1 Stat Total** | **Level 99 Stat Total** |
|---------------|------------------------|-------------------------|
| Wind Crystal  | ~30                    | ~250                    |
| Fire Crystal  | ~40                    | ~300                    |
| Water Crystal | ~55                    | ~300                    |
| Earth Crystal | ~70                    | ~350                    |
| Eureka        | ~100                   | ~400                    |

In this patch, the lower tier jobs are still inferior to the higher tier jobs, but the difference is
more akin to choosing your difficulty rather than not being an option at all.

Job Tiers (Neoclassical):
| **Job Tier**  | **Level 1 Stat Total** | **Level 99 Stat Total** |
|---------------|------------------------|-------------------------|
| Wind Crystal  | ~35                    | ~310                    |
| Fire Crystal  | ~50                    | ~330                    |
| Water Crystal | ~65                    | ~350                    |
| Earth Crystal | ~80                    | ~370                    |
| Eureka        | ~100                   | ~400                    |

The changes per class are summarized below:

### Onion Kid

Attributes (Original):
- Level  1: Str= 5, Agi= 5, Vit= 5, Int= 5, Spi= 5
- Level 99: Str=99, Agi=99, Vit=99, Int=99, Spi=99
- Crit%= 1, CritDmg=10, Run%=10, SleepParaRecovery%= 5
- SkillExp: Fight= 4, Defend= 4, Run= 4, Item= 4

No changes.

### Fighter / Warrior

A strong and durable arms-man focused on getting the job done. Utilizes available bladed weapons
such as swords, axes, and spears as well as other tools at his disposal to make sure his team is
victorious.

Attributes (Original):
- Level  1: Str=10, Agi=10, Vit= 5, Int= 2, Spi= 3
- Level 99: Str=75, Agi=75, Vit=50, Int=25, Spi=25
- Crit%= 2, CritDmg=20, Run%= 5, SleepParaRecovery%=10
- SkillExp: Fight=12, Defend= 8, Run= 0, Item= 8

Attributes Changes (Neoclassical):
- Level  1: Str=11, Agi=11, Vit= 7, Int= 4, Spi= 2
- Level 99: Str=85, Agi=85, Vit=75, Int=35, Spi=30

Equipment Changes:
- Armor: Gains access to diamond shield, mail, gloves, Reflect Mail, Aegis Shield.
- Weapons: Gains access to Holy Swords, all Spears, and all Axes

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Monk

Focused and strong of body, the monk's martial training allows him to deliver blows with his bare
fists that can humble the greatest of swordsmen. In addition to nunchucks, the monk is able to use
ritual weapons such as staves and bells.

Attributes (Original):
- Level  1: Str=10, Agi= 8, Vit= 7, Int= 1, Spi= 1
- Level 99: Str=98, Agi=75, Vit=73, Int= 1, Spi= 2
- Crit%= 3, CritDmg=30, Run%= 5, SleepParaRecovery%=10
- SkillExp: Fight=12, Defend= 8, Run= 0, Item= 8

Attributes Changes (Neoclassical):
- Level  1: Str=12, Agi=10, Vit=10, Int= 1, Spi= 2
- Level 99: Str=95, Agi=85, Vit=90, Int=15, Spi=25

Equipment Changes:
- Armor: Gains access to Gaia Vest
- Weapons: Gains access to Staves and Bells

Command Changes:
- Fight: Left and Right hand now receive str/2 instead of str/4 damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### WhiteMage / WhiteWiz.

Strong of spirit, the white mage is a healing specialist. While he has an oath against the usage of
bladed weapons, he can utilize staves and hammers. His holy healing powers may also be turned
against the undead.

Attributes (Original):
- Level  1: Str= 5, Agi= 6, Vit= 4, Int= 5, Spi=10
- Level 99: Str=50, Agi=50, Vit=50, Int=25, Spi=75
- Crit%= 0, CritDmg=10, Run%=15, SleepParaRecovery%= 0
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str= 6, Agi= 6, Vit= 5, Int= 6, Spi=12
- Level 99: Str=65, Agi=60, Vit=65, Int=35, Spi=85

Equipment Access:
- Armor: No changes.
- Weapons: Gains access to Eldest Staff and all Hammers (FF1)

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive spi damage instead of spi/2 damage. Healing spells receive spi/2
  healing instead of 0.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### BlackMage / BlackWiz.

While only carrying light armor and only able to utilize lighter weapons such as daggers, rods, and
claws, the black mage more than makes up for it with devastating elemental magic. Where raw damage
does not prevail, he can use debilitating curses and strip away enemy defenses.

Attributes (Original):
- Level  1: Str= 5, Agi= 7, Vit= 3, Int=10, Spi= 5
- Level 99: Str=50, Agi=50, Vit=49, Int=75, Spi=25
- Crit%= 1, CritDmg=20, Run%=15, SleepParaRecovery%= 0
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str= 5, Agi= 8, Vit= 4, Int=12, Spi= 6
- Level 99: Str=60, Agi=65, Vit=65, Int=85, Spi=35

Equipment Changes:
- Armor: No changes.
- Weapons: Gains access to Ultimate Rod and all Claws (FF1).

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive int damage instead of int/2 damage. Erase works on bosses if it lands 4 or more hits.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Red Mage / Red Wiz.

The red mage is a flexible spell caster, healer, and warrior. While he does not excel in any one
area, he can combine his abilities to help in an emergency in any role. However, he lacks the
durability in both health and magic power to hold out alone for long.

Attributes (Original):
- Level  1: Str= 6, Agi= 7, Vit= 5, Int= 6, Spi= 6
- Level 99: Str=50, Agi=70, Vit=30, Int=50, Spi=50
- Crit%= 2, CritDmg=30, Run%=10, SleepParaRecovery%= 5
- SkillExp: Fight= 8, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str= 7, Agi= 8, Vit= 6, Int= 7, Spi= 7
- Level 99: Str=65, Agi=70, Vit=45, Int=65, Spi=65

Equipment Changes:
- Armor: Gains access to Feather Hat, Diamond Shield
- Weapons: Gains access to Medium Swords (FF1), Break Sword converted into an end-game Light Sword.

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive (int|spi) damage instead of (int|spi)/2 damage. Erase works on
  bosses if it lands 4 or more hits. Healing spells receive spi/2 healing instead of 0. Gains access
  to all Level 5 White/Black spells. Gains access to most Level 6 White/Black spells. (FF1)
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Hunter

The hunter uses only a single weapon, bows, but he can utilize the strength of both hands to put a
tremendous amount of force behind each arrow. The hunter fares very well against highly armored
foes, and can them while maintaining a defensive position in the back row. His healing spells can
take pressure off another healer, buying them time to cast utility spells. When out of arrows, he
can don dragon scale armor and spear and fight enemies at close range.

Attributes (Original):
- Level  1: Str= 5, Agi=20, Vit= 5, Int= 5, Spi= 5
- Level 99: Str=75, Agi=98, Vit=75, Spi=25, Int=25
- Crit%= 4, CritDmg=50, Run%= 0, SleepParaRecovery%= 0
- SkillExp: Fight=12, Defend= 4, Magic= 8, Item= 4

Attributes (Neoclassical):
- Level  1: Str=10, Agi=20, Vit=10, Int= 5, Spi= 5
- Level 99: Str=81, Agi=98, Vit=81, Int=25, Spi=45
- Crit%= 4, CritDmg=50, Run%= 0, SleepParaRecovery%= 0
- SkillExp: Fight=12, Defend= 4, Magic= 8, Item= 4

Equipment Changes:
- Armor: Gains access to Dragon Helm and Armor.
- Weapons: Gains access to all Spears.

Command Changes:
- Fight: Bow and arrow formulas changed so that they are high-damage low hits, good for penetrating
  armor. Damage moved mostly to bow, permitting late-game choice of arrows. When out of arrows,
  spears may be used.
- Magic: Offensive spells receive spi damage instead of spi/2 damage. Healing spells receive spi/2
  healing instead of 0.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Knight

The knight is stalwart and reliable warrior that one can build a party around. He has high defense,
high attack, high accuracy, and most of all, reliability. Any enhancement spell cast on a knight is
never wasted. Furthermore, a knight will come to the aid of a party member who is low on health,
taking blows himself that otherwise may have been fatal.

Attributes (Original):
- Level  1: Str=10, Agi=10, Vit=10, Int= 3, Spi= 7
- Level 99: Str=84, Agi=84, Vit=80, Int=25, Spi=25
- Crit%= 3, CritDmg=15, Run%= 0, SleepParaRecovery%=15
- SkillExp: Fight=12, Defend= 8, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=12, Agi=12, Vit=12, Int= 4, Spi=10
- Level 99: Str=90, Agi=90, Vit=85, Int=30, Spi=35

Equipment Changes:
- Armor: None
- Weapons: Loses access to Full Moon (now a Thief weapon)

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Thief

Thieves can land a flurry of blows against an opponent, tiring them out and getting past their
evasive tricks. However, he struggles to penetrate thick armor. Once they become skilled, thieves
can "procure" valuable items from unwary foes, and their high intellect allows them to make
especially good use of offensive magical items.

Attributes (Original):
- Level  1: Str=10, Agi=15, Vit= 9, Int= 5, Spi= 1
- Level 99: Str=75, Agi=98, Vit=50, Int=75, Spi= 1
- Crit%= 2, CritDmg=10, Run%=50, SleepParaRecovery%= 0
- SkillExp: Fight= 8, Steal=12, Escape= 4, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=14, Agi=18, Vit=11, Int= 6, Spi= 1
- Level 99: Str=85, Agi=99, Vit=65, Int=80, Spi= 1

Equipment Changes:
- Armor: Gains access to Diamond Shield
- Weapons: Gains access to Full Moon and all Claws.

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Steal: (Original)
  - Can only steal first 4 item slots (out of 8) of enemy drop/steal table.
  - Success chance is (level+skill)/255 %
- Steal: (Neoclassical)
  - Item slots that can be stolen are from 0 to 255/(56-skill/4). At low skill,
    it's the first 4 item slots, and at high skill, it's all 8 item slots.
  - Success chance is (50 + level + skill)/255 %.
  - Most enemies have enemies have more varied loot.
  - Certain enemies are sources of very useful items. Try the following locations:
    - Crystal Tower
    - Underwater Hidden Cave
    - Earth Fang Cave
    - Bahamut's Cave
- Escape: Defense/Evasion no longer set to 0.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Scholar

When supporting his team, the scholar's unconventional techniques frequently seem less effective
than his more focused peers. However, the scholar frequently makes key insights about the enemy that
can turn the tide of battle.

Attributes (Original):
- Level  1: Str=10, Agi=10, Vit= 1, Int=15, Spi= 4
- Level 99: Str=75, Agi=75, Vit=15, Int=98, Spi=35
- Crit%= 1, CritDmg=20, Run%= 0, SleepParaRecovery%= 0
- SkillExp: Fight=12, Peep=12, Scan=12, Item=12

Attributes Changes (Neoclassical):
- Level  1: Str=12, Agi=12, Vit= 7, Int=15, Spi= 4
- Level 99: Str=80, Agi=80, Vit=35, Int=98, Spi=37
- Crit%=15, CritDmg=80, Run%= 0, SleepParaRecovery%= 0

Equipment Changes:
- Armor: No changes.
- Weapons: Many books now have spell effects when invoked.

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage. Critical strike chance
  changed from 1% to 15%. Critical strike bonus damage changed from 20 to 80.
- Peep: No changes.
- Scan: No changes.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Geomancer

While a geomancer lacks the versatility and strength of other specialized spellcasters, he makes up
for it in sheer endurance. He is able to unleash elemental magics upon his foes that change with the
terrain he stands upon. However, unskilled and inexperienced geomancers should be wary that if the
magic they unleash does not strike a foe, it will return and cause harm to himself! Using ritual
bells, the geomancer can sap the life energy of his foes into himself, and in turn use that energy
for earth magic yet again.

Attributes (Original):
- Level  1: Str=10, Agi=10, Vit=10, Int=20, Spi= 5
- Level 99: Str=50, Agi=75, Vit=50, Int=75, Spi=50
- Crit%= 1, CritDmg=30, Run%= 0, SleepParaRecovery%= 0
- SkillExp: Fight= 8, Terrain=12, Defend= 4, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=12, Agi=12, Vit=11, Int=20, Spi=10
- Level 99: Str=65, Agi=75, Vit=65, Int=85, Spi=60

Equipment Changes:
- Armor: No changes.
- Weapons: Bells now drain life.

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive int damage instead of int/2 damage. Air Slash hit% improved from
  30% to 60%.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Dragoon

Unlike the stable pillar of the knight, the dragoon takes chances in order to deal with otherwise
unbeatable foes. Leaping high into the air, the dragoon and focus his full force behind a weapon,
lending it a penetrating power that pierces even the strongest of armor. While in the air, other
party members must handle incoming attacks, however, the dragoon avoids taking damage from enemies
and does not take healing resources from others either.

Attributes (Original):
- Level  1: Str=20, Agi=10, Vit=10, Int= 5, Spi=10
- Level 99: Str=75, Agi=98, Vit=50, Int=25, Spi=50
- Crit%= 3, CritDmg=50, Run%= 0, SleepParaRecovery%=10
- SkillExp: Fight= 8, Jump=12, Defend= 8, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=23, Agi=12, Vit=12, Int=12, Spi= 6
- Level 99: Str=87, Agi=98, Vit=75, Int=60, Spi=30
- SkillExp: Fight=12, Jump=12, Defend= 8, Item= 4

Equipment Changes:
- Armor: None
- Weapons: Spears have improved damage, keeping pace with other weapons in the game.

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage. Skill experience gained per use
  increased from 8 to 12.
- Jump: (Original) Multiplies final damage of 1 weapon attack by 3. (Neoclassical) Adds 1 jump/boost
  charge, doubling 1 weapon attack's damage before enemy defense is applied. Jump is now more
  effective on average, and significantly more effective on high-armor enemies.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Viking

While none can deny a viking's stamina or bravery, he may appear clumsy using his heavy and unwieldy
hammers and axes in battle. With practice, his skills will improve and these lumbering innacurate
weapons can turn into devastatingly powerful attacks as accurate as any other warrior.

Attributes (Original):
- Level  1: Str=15, Agi=10, Vit=20, Int= 5, Spi= 5
- Level 99: Str=75, Agi=50, Vit=98, Int=25, Spi=50
- Crit%= 3, CritDmg=40, Run%=20, SleepParaRecovery%=20
- SkillExp: Fight=12, Defend= 8, Run= 0, Item= 8

Attributes Changes (Neoclassical):
- Level  1: Str=18, Agi=12, Vit=22, Int= 5, Spi= 8
- Level 99: Str=96, Agi=60, Vit=99, Int=30, Spi=65

Equipment Changes:
- Armor: None
- Weapons: Hammers and Axes have high damage, but a low hit chance.

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Karateka / BlackBelt

Unlike the Monk, the Karateka is focused on combat and defeating his foe. His strength, endurance,
and agility are unmatched by any other as his body is honed by training. While he is trained in the
use of claws, with training, he becomes even more proficient with his bare fists. When facing an
especially challenging opponent, he can take a moment to focus his energy into a fist (or two fists
if he focuses further), and unleash devestating blows that can penetrate even the strongest
defense. This strategy is risky, however, because the Karateka must lower his own defenses to focus.

Attributes (Original):
- Level  1: Str=23, Agi=10, Vit=20, Int= 1, Spi= 1
- Level 99: Str=98, Agi=98, Vit=98, Int= 1, Spi= 1
- Crit%= 5, CritDmg=50, Run%= 0, SleepParaRecovery%=10
- SkillExp: Fight=12, Buildup=12, Defend= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=26, Agi=13, Vit=24, Int= 1, Spi= 1
- Level 99: Str=99, Agi=99, Vit=99, Int=30, Spi=23

Equipment Changes:
- Armor: None
- Weapons: Claws have improved damage, keeping competitive with other weapons.

Command Changes:
- Fight: Right and left hands for martial arts now receive str/2 instead of str/4 damage.
- Buildup: (Original)
  - Multiplies final damage by 2 or 3, after enemy defense applies.
    - After one use: damage = [Right] (r.damage - defense) x 2 + [Left] (l.damage - defense)
    - After two uses: damage = [Right] (r.damage - defense) x 3 + [Left] (l.damage - defense)
  - Causes vulnerability, doubling incoming physical and magical damage, setting defense, evasion,
    and m.defense to 0.
- Buildup: (Neoclassical)
  - Grants 1 jump/buildup charge per use, doubling the damage of 1 hand attack per charge before
    enemy defense applies. Highly effective against high-armor enemies.
    - After one use: damage = [Right] (r.damage x 2 - defense) + [Left] (l.damage - defense)
    - After two uses: damage = [Right] (r.damage x 2 - defense) + [Left] (l.damage x 2 - defense)
  - Causes vulnerability, doubling incoming physical damage (before armor) but not magical damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### M.Knight / DarkKnight

Attributes (Original):
- Level  1: Str=20, Agi=20, Vit=10, Int= 2, Spi= 3
- Level 99: Str=75, Agi=75, Vit=50, Int=50, Spi=50
- Crit%= 2, CritDmg=40, Run%= 0, SleepParaRecovery%= 5
- SkillExp: Fight=12, Defend= 4, Magic= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=20, Agi=20, Vit=15, Int= 5, Spi= 5
- Level 99: Str=86, Agi=86, Vit=66, Int=56, Spi=56

Equipment Changes:
- Armor: None
- Weapons: None

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Defend: Defend still causes damage/defense to be recalculated, nullifying Cheer/Safe/Haste.
- Magic: Offensive spells receive spi damage instead of spi/2 damage. Healing spells receive spi/2
  healing instead of 0.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Conjurer / Evoker

Attributes (Original):
- Level  1: Str=10, Agi=10, Vit= 5, Int=15, Spi=15
- Level 99: Str=75, Agi=50, Vit=25, Int=75, Spi=75
- Crit%= 1, CritDmg=20, Run%=30, SleepParaRecovery%= 0
- SkillExp: Fight= 8, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=14, Agi=10, Vit= 7, Int=17, Spi=17
- Level 99: Str=80, Agi=65, Vit=45, Int=80, Spi=80

Equipment Changes:
- Armor: None
- Weapons: Gains access to Ultimate Rod.

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Magic: Damage and healing (Ifrit) scales greatly with attributes. The Conjurer summons a creature
  with Level=skill x 2, Int = Int x 2, Spi = Spi x 2, Skill = Skill. Intellect now contributes more
  strongly to magic damage than before, adding Int to base damage rather than Int/2, however, spell
  power of individual spells have been reduced in response.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Bard

Attributes (Original):
- Level  1: Str= 5, Agi=15, Vit=15, Int=10, Spi=10
- Level 99: Str=25, Agi=75, Vit=75, Int=50, Spi=75
- Crit%= 0, CritDmg= 1, Run%= 0, SleepParaRecovery%= 5
- SkillExp: Sing=12, Scare= 8, Cheer=12, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str= 7, Agi=17, Vit=17, Int=12, Spi=12
- Level 99: Str=35, Agi=85, Vit=85, Int=60, Spi=85
- Crit%= 4, CritDmg=200, Run%= 0, SleepParaRecovery%= 5
- SkillExp: Sing=12, Scare= 8, Cheer=12, Item= 8

Equipment Changes:
- Armor: None
- Weapons: Harps now inflict status effects on hit. When invoked, harps provide minor healing.

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage. Critical strike chance
  increased from 0% to 4%. Critical strike damage increased from 1 to 200.
- Cheer: Increase bonus base damage for each party member from 10 to 14.
- Scare: (Original)
  - Does not work on bosses.
  - Lowers enemy level by 3 (increasing changes of them fleeing).
- Scare: (Neoclassical)
  - Lowers enemy base damage by 14
  - Lowers enemy m.defense by 14
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Warlock

Attributes (Original):
- Level  1: Str=10, Agi=15, Vit=10, Int=30, Spi= 5
- Level 99: Str=25, Agi=75, Vit=98, Int=99, Spi=50
- Crit%= 1, CritDmg=30, Run%=30, SleepParaRecovery%= 0
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=11, Agi=13, Vit=16, Int=30, Spi=10
- Level 99: Str=40, Agi=80, Vit=95, Int=99, Spi=56

Equipment Changes:
- Armor: None
- Weapons: None

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive int damage instead of int/2 damage. Erase works on bosses if it lands 4 or more hits.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Shaman / Devout

Attributes (Original):
- Level  1: Str=15, Agi=10, Vit=15, Int= 5, Spi=25
- Level 99: Str=50, Agi=75, Vit=75, Int=50, Spi=99
- Crit%= 1, CritDmg=40, Run%=30, SleepParaRecovery%= 0
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=15, Agi=10, Vit=15, Int=10, Spi=30
- Level 99: Str=55, Agi=80, Vit=80, Int=56, Spi=99

Equipment Changes:
- Armor: None
- Weapons: None

Command Changes:
- Fight: Right hand receives str/2 instead of str/4 damage.
- Magic: Offensive spells receive spi damage instead of spi/2 damage. Healing spells receive spi/2
  healing instead of 0.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Summoner

Attributes (Original):
- Level  1: Str=20, Agi=15, Vit= 5, Int=15, Spi=15
- Level 99: Str=75, Agi=98, Vit=25, Int=75, Spi=75
- Crit%= 1, CritDmg=40, Run%=20, SleepParaRecovery%= 0
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

Attributes Changes (Neoclassical):
- Level  1: Str=16, Agi=20, Vit=10, Int=17, Spi=17
- Level 99: Str=75, Agi=90, Vit=45, Int=80, Spi=80

Equipment Chnages:
- Armor: None
- Weapons: None

Command Changes:
- Fight: Right-hand weapon now receives str/2 instead of str/4 damage.
- Magic: Damage and healing (Ifrit) scales greatly with attributes. The Summoner summons a creature
  with Level=skill x 2, Int = Int x 2, Spi = Spi x 2, Skill = Skill. Intellect now contributes more
  strongly to magic damage than before, adding Int to base damage rather than Int/2, however, spell
  power of individual spells have been reduced in response.
- Run: Defense/Evasion no longer set to 0. Still vulnerable.
- Item: Int contributes more strongly to offensive items, e.g. NorthWind. Spi now contributes to
  potions.

### Sage

Attributes (Original):
- Level  1: Str=15, Agi=20, Vit=15, Int=25, Spi=25
- Level 99: Str=50, Agi=75, Vit=75, Int=99, Spi=99
- Crit%= 2, CritDmg=30, Run%=40, SleepParaRecovery%=25
- SkillExp: Fight= 4, Magic=12, Run= 0, Item= 4

No changes.

### Ninja

Attributes (Original):
- Level  1: Str=25, Agi=25, Vit=20, Int=15, Spi=15
- Level 99: Str=99, Agi=99, Vit=98, Int=50, Spi=50
- Crit%= 5, CritDmg=100, Run%= 0, SleepParaRecovery%=25
- SkillExp: Fight= 8, Defend= 8, Run= 4, Item= 4

No changes.

## Equipment Changes

### End Game Weapon Rebalance

Eureka weapons were rebalanced to account for the increased damage from strength.
- FullMoon 160 -> 145 (now drains life, thief weapon)
- Masamune 160 -> 145
- Ragnarok 180 -> 165
- Excalibur 160 -> 145

Other weapons were changed to make them viable in the end-game:
- Holy Spear 100 -> 120
- GreatAxe (80%, 75) -> (70%, 125)
- Triton (80%, 85) -> (60%, 145)
- HellClaw 60 -> 90
- AirKnife 60 -> 90
- Ancient Sword 5 -> 120 (no longer paralyzes)
- Break Blade 120 -> 110 (Now red-mage weapon, enhanced fire,ice,bolt, +5 str,int,spi)

### Bows and Arrows

In order to preserve the ability to choose arrow types in the end-game, bows and arrows were
rebalanced to move most of the damage to the bow and the strength of the user rather than the arrow.

- YoichiBow 50 -> 110
- YoichiArrow 70 -> 30
- RuneBow 25 -> 50
- BoltArrow 30 -> 15
- FireArrow 30 -> 15
- IceArrow 30 -> 15
- KillerBow 15 -> 30
- IronArrow 17 -> 15
- GreatBow 8 -> 20
- MedusaArrow 20 -> 10
- HolyArrow 13 -> 10
- Bow 5 -> 10
- WoodenArrow 6 -> 3

### Scholar Books

Scholar books were modified to give the Scholar the ability to participate in the end game and to
provide additional utility.

- Inferno Book 65 -> 95 (invoke to cast Haste)
- Blizzard Book 65 -> 95 (invoke to cast Safe)
- Ilumina Book 65 -> 95 (invoke to cast Erase)

### Staves

Staves were re-worked to make it an option for a White Mage to attack with low accuracy, or as a
weapon alternative for Monks who no longer receive nunchuks later in the game.

- Eldest Staff (90%, 30) -> (65%, 95)
- Rune Staff (80%, 20) -> (65%, 75)
- Golem Staff (70%, 16) -> (65%, 42)
- Ice Staff 8 -> 20
- Light Staff 8 -> 20
- Fire Staff 8 -> 20

### Rods

Rods were given a small amount of damage, enough so that the spell caster isn't entirely useless
when they run out of magic.

- Ultimate Rod 20 -> 75 (Now enhances fire,ice,bolt, +5 int)
- Light Rod 12 -> 35 (enhance bolt is fixed)
- Ice Rod 12 -> 35 (enhance ice is fixed)
- Fire Rod 12 -> 35 (enhance fire is fixed)

### Bells

Bells serve two purposes now. A way for geomancers to recover health, so they are less of a burden
on healers. A weapon choice for monks, keeping them viable through the game.

- Rune Bell 40 -> 80 (drains life)
- Earthen Bell 30 (paralysis) -> 40 (drains life)
- Giyaman Bell 25 -> 35 (drains life)

### Spears

Spears had been poorly balanced, so they were made more equitable with swords found in similar parts
of the game, permitting the dragoon to be played consistently.

- Holy Spear 100 -> 120
- Blood Lance 70 -> 80
- Wind Spear 50 -> 55
- Thunder Spear 35 -> 45

### Axes

Axes have been repurposed into a higher damage but lower accuracy weapon. Less extreme than hammers.

- GreatAxe (80%, 75) -> (70%, 125)
- Tomahawk (80%, 60) -> (70%, 105)
- M.Star 50 -> 60
- Battle Axe (60%, 45) -> (70%, 50)

### Harps

In an effort to make bards not useless, in addition to their ability changes, their weapons were
improved not in damage, but in utility.

- Loki Harp 60 -> 60 (adds confusion, invoke for Cure4)
- Lamia Harp 0 -> 50 (adds paralysis, invoke for Cure3)
- Madora Harp 40 -> 40 (adds sleep, invoke for Cure2)

### Hammer

Hammers are now weapons that deal high damage, if you can hit. They reward high skill levels.

- Triton (80%, 85) -> (60%, 145)
- Thor Hammer (70%, 30) -> (60%, 75)
- Hammer 25 -> 25

## Item Changes

Items have a per-item defined number of hits that they apply. This is why items such as ChocoRage,
despite casting Flare, can be so weak, because the number of hits they land is low.

Due to the spell changes allowing spi/2 to contribute to healing, potions can be up to 100% more
effective in the hands of a character with 99 spirit. This gives high-spirit classes like Bards,
Vikings, Conjurers, and Geomancers a bit of extra utility.

Higher-intellect classes like Thieves, Scholars, Dragoons, and even the lowly Fighter can more
effectively use intellect-based offensive items.

The item multipliers for spirit-based items changed as follows:
- Potion (spi) 3 -> 2  (Recovery spell base healing improved from 30 -> 45)
- Hi-Potion (spi) 12 -> 8
- Imp's Yawn (spi) 3 -> 6
- WhiteScent (spi) 3 -> 9

The item multipliers for intellect-based items changed as follows:
- Bomb Shard (int) 2 -> 4
- SouthWind (int) 2 -> 4
- Zeus' Rage (int) 2 -> 4
- Bomb Arm (int) 3 -> 6
- NorthWind (int) 3 -> 6
- God's Rage (int) 3 -> 6
- EarthDrum (int) 3 -> 6
- BombHead (int) 3 -> 6
- ChocoRage (int) 3 -> 9

## Spell Changes

Due to heavy changes in the damage and healing formulas, the general feel of magic is changed in the
following ways:
- Differences in int/spi feel much more significant, e.g. BlackMage vs. RedMage vs. WhiteMage.
- Late-game, magic is still competitive with melee, it's a viable option.
- Most spell damage/healing has been reduced to account for the increased int/spi contributions,
  with higher level spells being reduced by more (because you have higher attributes by the time you
  get access to them).
- Lower level spells, such as Fire and Cure are not as powerful, but useful even in the late game.
- Erase has been modifed to almost as impactful to spellcasters as Haste is to melee characters:
  - Some monsters has universal elemental resistance, halving damage, no matter what. This has been removed.
  - Erase can remove elemental resistance from bosses, as long as you land at least 4 hits.
  - The color of the spell has been changed to indicate it is NOT related to Wall. Erase removes
    elemental resistances that halve incoming magic damage, it is not involved in spell reflection.
- Wall has been been modified:
  - Color changed to a brighter grey, making it visually distinct from Erase to avoid confusion.
  - Wall now reflects up to 3 spells (making it a viable alternative to Cure4).
- Cure4 no longer heals HP to max (the bytes were needed to add spi/2 to healing). However, in
  compensation, it has more spellpower than before. It is slightly weaker on a single target, but
  more powerful when used on the entire party.
- Drain now works on bosses, giving Black Mages a powerful spell they can use.
- The Bard is now a powerful ally of spellcasters, because he is the only job capable of lowering
  enemy magic defense, even against bosses.
