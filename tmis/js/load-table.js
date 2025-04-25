const fetchData = fetch('https://wpt.servo.org/scores-last-run.json')

const AREA_SCORE_OFFSET = 3

function removeChildren (parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild)
    }
    return parent
}

function update_table (scores) {
    const score_table = document.getElementById('score-table-body')
    removeChildren(score_table)

    for (const [idx, area] of scores.area_keys.entries()) {
        const area_score = scores.scores_last_run[idx + AREA_SCORE_OFFSET]
        const score = Math.floor(1000 * area_score.total_score / area_score.total_tests) / 10
        const subtests = Math.floor(1000 * area_score.total_subtests_passed / area_score.total_subtests) / 10
        score_table.insertAdjacentHTML(
            'beforeend',
            `<tr class="${idx % 2 ? 'odd' : 'even'}">
                <td>${scores.focus_areas[area]}</td>
                <td class="score">${String(score).padEnd(4, '.0')}%</td>
                <td class="score">(${new Intl.NumberFormat().format(area_score.total_subtests_passed)}/${new Intl.NumberFormat().format(area_score.total_subtests)}) ${String(subtests).padEnd(4, '.0')}%</td>
            </tr>`
        )
    }
}

fetchData
  .then(resp => resp.json())
  .then(scores => {
    update_table(scores)
  })

