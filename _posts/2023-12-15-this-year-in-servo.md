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
- 2023: 1042 = 41*25+17 https://github.com/servo/servo/pulls?page=42&q=is%3Apr+is%3Amerged+sort%3Aupdated-desc
- 2022: 223 https://www.azabani.com/talks/2023-06-05-servo-2023/#5

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

contributors
- excluding stylo backports
    - https://github.com/servo/servo/pulls?q=backport+several+style+changes+from+gecko
    - https://github.com/servo/servo/pull/30770.patch
    - https://github.com/servo/servo/pull/30748.patch
    - https://github.com/servo/servo/pull/30692.patch
    - https://github.com/servo/servo/pull/30681.patch
    - https://github.com/servo/servo/pull/30646.patch
    - https://github.com/servo/servo/pull/30421.patch
    - https://github.com/servo/servo/pull/30108.patch
    - https://github.com/servo/servo/pull/30104.patch - squashed
    - https://github.com/servo/servo/pull/30099.patch - squashed
    - https://github.com/servo/servo/pull/29848.patch - squashed
    - https://github.com/servo/servo/pull/29816.patch - squashed
    - https://github.com/servo/servo/pull/29772.patch - squashed
    - https://github.com/servo/servo/pull/29748.patch - squashed

$ set -- https://github.com/servo/servo/pull/30770.patch https://github.com/servo/servo/pull/30748.patch https://github.com/servo/servo/pull/30692.patch https://github.com/servo/servo/pull/30681.patch https://github.com/servo/servo/pull/30646.patch https://github.com/servo/servo/pull/30421.patch https://github.com/servo/servo/pull/30108.patch

## attempt 1

get commit hashes out of github mbox patch
$ ( set -euo pipefail; for i; do curl -fsSL "$i" | rg '^From [0-9a-f]{40} Mon Sep 17 00:00:00 2001$'; done | tee stylo | wc -l )
561

filter those hashes out of the 2023 commit history
$ git log --pretty=format:$'%H\t%cd\t%cE\t%aE\t%s' | rg ' 2023 ' | rg -v '^('"$(printf \%s "$(< stylo cut -d' ' -f2)" | tr \\n '|')"')\t' | wc -l
2485

unfortunately that didn’t do anything, because the commit hashes change when landed
$ git log --pretty=format:$'%H\t%cd\t%cE\t%aE\t%s' | rg ' 2023 ' | wc -l
2485

## attempt 2

download github mbox patches in advance
$ ( set -euo pipefail; for i; do printf \%s\\n "$i"; curl -fsSLO "$i"; done )

experimentally double-check what characters need to be escaped for ripgrep
$ echo \< | rg \<
$ echo \> | rg \>
$ echo \# | rg \#
$ echo \% | rg \%
$ echo \= | rg \=
$ echo \! | rg \!
$ ( set -euo pipefail; for i; do i=${i##*/}; i=${i%.patch}
    < $i.patch sed -En '/^Subject: \[PATCH [0-9]+\/[0-9]+\] (.*)$/{s//\1/;p;}' | tr -d 'a-zA-Z0-9 :,`'\''\n<>/_@"#%=!-'; done | sed 's/./&\n/g' | sort -u | tr -d \\n; echo )
()*+.[]{|}

find contiguous chunks of subject lines, checking that we have exactly one match each time
$ ( set -euo pipefail; for i; do i=${i##*/}; i=${i%.patch}
    pretty=format:$'%H\t%cd\t%cE\t%aE\t%s'
    pattern=$(< $i.patch sed -En '/^Subject: \[PATCH [0-9]+\/[0-9]+\] (.*)$/{s//\1/;s/[]()*+.\[{|}^$\\]/\\&/g;s/^/^([^\\t]+\\t){4}/;s/$/.*/;p;}' | tac | tee /dev/null; : /dev/stderr)
    printf '#%s = %s matches\n' $i "$(git log --pretty="$pretty" | rg -Uc -- "$pattern")"; done )
#30770 = 1 matches
#30748 = 1 matches
#30692 = 1 matches
#30681 = 1 matches
#30646 = 1 matches
#30421 = 1 matches
#30108 = 1 matches

find contiguous chunks of subject lines, saving the commit hashes to a file
$ ( set -euo pipefail; for i; do i=${i##*/}; i=${i%.patch}
    pretty=format:$'%H\t%cd\t%cE\t%aE\t%s'
    pattern=$(< $i.patch sed -En '/^Subject: \[PATCH [0-9]+\/[0-9]+\] (.*)$/{s//\1/;s/[]()*+.\[{|}^$\\]/\\&/g;s/^/^([^\\t]+\\t){4}/;s/$/.*/;p;}' | tac | tee /dev/null; : /dev/stderr)
    git log --pretty="$pretty" | rg -U -- "$pattern"; done ) > stylo

check that the total commit count is still 561
$ wc -l stylo
561

count unique author emails, filtering those hashes out of the 2023 commit history
$ git log --pretty=format:$'%H\t%cd\t%cE\t%aE' | rg ' 2023 ' | rg -v '^('"$(printf \%s "$(cat stylo)" | tr \\n '|')"')\t' | cut -f4 | sort | uniq -c | sort -rn
    424 infra@servo.org
    321 49699333+dependabot[bot]@users.noreply.github.com
    261 mrobinson@igalia.com
    189 obrufau@igalia.com
    141 emilio@crisal.io
     89 16504129+sagudev@users.noreply.github.com
     72 dazabani@igalia.com
     54 josh+wptsync@joshmatthews.net
     32 josh@joshmatthews.net
     23 pu.stshine@gmail.com
     23 56165400+michaelgrigoryan25@users.noreply.github.com
     22 mukilan@igalia.com
     22 me@mukilan.in
     22 alextouchet@outlook.com
     19 atbrakhi@igalia.com
     14 32481905+servo-wpt-sync@users.noreply.github.com
     13 boris.chiou@gmail.com
     13 98276492+2shiori17@users.noreply.github.com
     10 delan@azabani.com
     10 cyb.ai.815@gmail.com
      9 85590273+EnnuiL@users.noreply.github.com
      8 mats@mozilla.com
      7 yuweiwu@pm.me
      7 yutaro.ono.418@gmail.com
      7 fabrice@desre.org
      6 jkew@mozilla.com
      5 emcdonough@mozilla.com
      5 alanxiao211@gmail.com
      4 tmg@fastmail.com
      4 rego@igalia.com
      4 mrobinson@webkit.org
      4 mh+mozilla@glandium.org
      4 johnsonac.3300@gmail.com
      3 mukilanthiagarajan@gmail.com
      3 i@yvt.jp
      3 federico@gnome.org
      3 fabrice@capyloon.org
      3 canaltinova@gmail.com
      2 tlin@mozilla.com
      2 ss77995ss@gmail.com
      2 soniasingla.1812@gmail.com
      2 paricbat@email.cz
      2 mwoodrow@mozilla.com
      2 mukilan.thiagarajan@gmail.com
      2 moonset20@gmail.com
      2 michelle@masterwayz.nl
      2 iversmage@gmail.com
      2 atbrakhi@gmail.com
      2 andreu@andreubotella.com
      2 94557773+atbrakhi@users.noreply.github.com
      2 12537668+MendyBerger@users.noreply.github.com
      2 120558797+captainhaddock18@users.noreply.github.com
      1 you@example.com
      1 yashsajwan12345@gmail.com
      1 tamird@gmail.com
      1 stransky@redhat.com
      1 spohl.mozilla.bugs@gmail.com
      1 requestdg@gmail.com
      1 reidswan@outlook.com
      1 phil.git@eden.net.nz
      1 pcwalton@mimiga.net
      1 nsilva@mozilla.com
      1 nipung271@gmail.com
      1 nico@nicoburns.com
      1 neia@ikeran.org
      1 mreschenberg@mozilla.com
      1 me@upsuper.org
      1 lamoure6@msu.edu
      1 ivan.ukhov@gmail.com
      1 hwopenharmony@gmail.com
      1 dvt.tnhn.krlbs@icloud.com
      1 coreyf@rwell.org
      1 cadubentzen@gmail.com
      1 bfreist@soundhound.com
      1 barret@brennie.ca
      1 91363480+joshua-holmes@users.noreply.github.com
      1 9028220+bc-universe@users.noreply.github.com
      1 68819302+obsidianical@users.noreply.github.com
      1 6543@obermui.de
      1 62263315+tipowol@users.noreply.github.com
      1 2792687+gterzian@users.noreply.github.com
      1 15304293+thesecretmaster@users.noreply.github.com
      1 13811862+thechampagne@users.noreply.github.com
      1 1322294+shanehandley@users.noreply.github.com
      1 110025628+varundhand@users.noreply.github.com

before mid-july, we landed patches with homu (bors-servo <infra@servo.org>), so we need to extract authors some other way
-->
