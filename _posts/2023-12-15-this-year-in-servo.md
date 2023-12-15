---
layout:     post
tags:       blog
title:      "This year in Servo: and more!"
date:       2023-12-15
summary:    Summary goes here.
categories:
---

<!--
pull requests
- 2023: 1037 (see contributors section)
- 2022: 215 (see contributors section)

commits
- 2023: 2485 (git log --pretty=format:$'%h\t%cd' | rg ' 2023 ' | wc -l)
- 2022: 523 (git log --pretty=format:$'%h\t%cd' | rg ' 2022 ' | wc -l)

wpt
- oldest newest (newest legacy)
- 63.4 79.2 (83.2) CSS2 focus
- 80.3 94.6 (44.6) abspos
- 65.5 74.4 (81.1) box-display
- 17.5 82.2 (53.9) floats
- 18.1 73.3 (68.2) floats-clear
- 51.2 61.5 (86.4) linebox
- 67.5 80.7 (90.6) margin-padding-clear
- 71.7 78.1 (87.5) normal-flow
- 77.7 87.6 (81.1) positioning
- 49.2 62.3 (60.5) CSSOM
- 34.1 48.4 (44.0) CSS Position
- 39.2 49.5 (52.0) CSS Flexbox
- 51.2 62.0 (63.9) CSS
- 49.2 55.5 (58.0) WPT

oldest 2023	newest 2023	delta oldest	legacy layout	delta legacy	suite
17.5	82.2	64.7	53.9	28.3	floats
18.1	73.3	55.2	68.2	5.1	floats-clear
63.4	79.2	15.8	83.2	-4.0	CSS2 focus
80.3	94.6	14.3	44.6	50.0	abspos
34.1	48.4	14.3	44.0	4.4	CSS Position
67.5	80.7	13.2	90.6	-9.9	margin-padding-clear
49.2	62.3	13.1	60.5	1.8	CSSOM
51.2	62.0	10.8	63.9	-1.9	CSS
51.2	61.5	10.3	86.4	-24.9	linebox
39.2	49.5	10.3	52.0	-2.5	CSS Flexbox
77.7	87.6	9.9	81.1	6.5	positioning
65.5	74.4	8.9	81.1	-6.7	box-display
71.7	78.1	6.4	87.5	-9.4	normal-flow
49.2	55.5	6.3	58.0	-2.5	WPT

## contributors

list pull requests that merged in 2022 and 2023
$ tools/list-pull-request-contributors.sh servo/servo '2022-.*' | tee 2022.json
$ tools/list-pull-request-contributors.sh servo/servo '2023-.*' | tee 2023.json
$ < 2022.json jq -s length
215
$ < 2023.json jq -s length
1037

contributors in 2022
$ < 2022.json jq -r .user.login | sort -u | wc -l
22
$ < 2022.json jq -r .user.login | sort | uniq -c | sort -nr
    124 dependabot[bot]
     26 servo-wpt-sync
     23 jdm
      5 yvt
      5 striezel
      5 michaelgrigoryan25
      4 teymour-aldridge
      3 s-maurice
      3 CYBAI
      3 atouchet
      2 wusyong
      2 negator
      1 thomas992
      1 saschanaz
      1 sagudev
      1 rick68
      1 nlefler
      1 myersg86
      1 mrl5
      1 MichaelMcDonnell
      1 EnnuiL
      1 BurtonQin

contributors in 2023
$ < 2023.json jq -r .user.login | sort -u | wc -l
53
$ < 2023.json jq -r .user.login | sort | uniq -c | sort -nr
    321 dependabot[bot]
    260 mrobinson
     73 Loirooriol
     71 sagudev
     68 servo-wpt-sync
     47 mukilan
     45 delan
     23 atbrakhi
     22 atouchet
     10 fabricedesre
      9 stshine
      9 EnnuiL
      8 wusyong
      7 ohno418
      7 jdm
      5 CYBAI
      4 mrego
      4 michaelgrigoryan25
      3 emilio
      3 2shiori17
      2 yvt
      2 switchpiggy
      2 ss77995ss
      2 paricbat
      2 chansuke
      1 Yash-Sajwan24
      1 varundhand
      1 tipowol
      1 thesecretmaster
      1 thechampagne
      1 tamird
      1 shanehandley
      1 seasonmac
      1 schrottkatze
      1 reidswan
      1 nipunG314
      1 nicoburns
      1 Mifom
      1 MendyBerger
      1 joshua-holmes
      1 IvanUkhov
      1 gterzian
      1 frewsxcv
      1 federicomenaquintero
      1 dvtkrlbs
      1 captainhaddock18
      1 cadubentzen
      1 ben-freist
      1 bc-universe
      1 atomgardner
      1 AnthonyJ3
      1 andreubotella
      1 6543
-->
