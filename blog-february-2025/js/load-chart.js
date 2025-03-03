/* global google */

google.charts.load('current', { packages: ['corechart', 'line'] })
google.charts.setOnLoadCallback(setupChart)

const fetchData = fetch('https://wpt.servo.org/scores.json')
const embed = location.search === '?embed'
let dark_mode = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches

const periodRanges = {
    'last month': 1,
    'last 3 months': 3,
    'last 6 months': 6,
    'last year': 12,
    'since April 2023': null
}

if (embed) {
    document.documentElement.classList.add('embed')
}

function formatDate (date) {
    const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ]
    const year = date.getFullYear()
    const month = months[date.getMonth()]
    const day = date.getDate()
    return `${month} ${day}, ${year}`
}

function parseDateString (date) {
    const [y, m, d] = date.split('-')
    return new Date(y, m - 1, d)
}

function toolTip (date, wpt_sha, servo_version, score, engine) {
    return `
        <b>${formatDate(date)}</b></br>
        Score: <b>${score / 10}</b></br>
        WPT: ${wpt_sha}</br>
        Servo (${engine}): ${servo_version}
    `
}

function setupChart () {
    const maxDate = new Date()

    const options = {
        height: 350,
        fontSize: 16,
        fontName: "'Space Grotesk', sans-serif",
        legend: {
            position: 'top',
            ...(dark_mode
                ? {
                    textStyle: { color: '#f5f5f5' }
                }
                : {})
        },
        hAxis: {
            format: 'MMM-YYYY',
            viewWindow: {
                max: maxDate
            },
            ...(dark_mode
                ? {
                    textStyle: { color: '#f5f5f5' }
                }
                : {})
        },
        vAxis: {
            format: 'percent',
            viewWindow: {
                min: 0,
                max: 1
            },
            ...(dark_mode
                ? {
                    textStyle: { color: '#f5f5f5' }
                }
                : {})
        },
        explorer: {
            actions: ['dragToZoom', 'rightClickToReset'],
            axis: 'horizontal',
            keepInBounds: true,
            maxZoomIn: 4.0
        },
        tooltip: {
            // textStyle has no effect if isHtml is true
            isHtml: true,
            trigger: 'both'
        },
        ...(dark_mode
            ? {
                backgroundColor: '#121619'
            }
            : {})
    }

    const node = document.getElementById('servo-chart')
    const area_dropdown = document.getElementById('selected-area')
    const period_dropdown = document.getElementById('selected-period')
    const chart = new google.visualization.LineChart(node)
    const AREA_SCORE_OFFSET = 3
    let all_scores

    Object.keys(periodRanges).forEach(date => {
        const selector = document.createElement('option')
        selector.value = date
        selector.textContent = date
        period_dropdown.appendChild(selector)
    })

    function update_chart () {
        if (!all_scores) throw new Error('scores not loaded')
        const chosen_area = area_dropdown.value
        const chosen_period = period_dropdown.value
        const area_index = all_scores.area_keys.indexOf(chosen_area)
        const table = new google.visualization.DataTable()
        options.series = []
        const monthsToSubtract = periodRanges[chosen_period]
        const minDate = monthsToSubtract
            ? new Date(maxDate.getFullYear(), maxDate.getMonth() - monthsToSubtract, 1)
            : null

        table.addColumn('date', 'runOn')

        options.series.push({ color: dark_mode ? '#CC9933' : '#3366CC' })
        table.addColumn('number', 'Servo')
        table.addColumn({ type: 'string', role: 'tooltip', p: { html: true } })

        for (const scores_for_run of all_scores.scores) {
            const area_score = scores_for_run[area_index + AREA_SCORE_OFFSET]
            const [date_string, wpt_sha, browser_version] = scores_for_run
            const date = parseDateString(date_string)
            if (date < minDate) {
                continue
            }
            const row = [
                date,
                area_score / 1000,
                toolTip(date, wpt_sha, browser_version, area_score, 'Servo')
            ]
            table.addRow(row)
        }
        chart.draw(table, options)
    }

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
            const recent_score = scores.scores[scores.scores.length - 1]
            score_table.insertAdjacentHTML(
                'beforeend',
                `<tr class="${idx % 2 ? 'odd' : 'even'}">
                    <td>${scores.focus_areas[area]}</td>
                    <td class="score">${String(recent_score[idx + AREA_SCORE_OFFSET] / 10).padEnd(4, '.0')}%</td>
                </tr>`
            )
        }
    }

    fetchData
        .then(resp => resp.json())
        .then(scores => {
            all_scores = scores
            if (scores.scores.length < 60) {
                options.hAxis.format = 'dd MMM YYYY'
            } else {
                options.hAxis.format = 'MMM YYYY'
            }

            for (const area of scores.area_keys) {
                const selector = document.createElement('option')
                selector.value = area
                selector.textContent = scores.focus_areas[area]
                area_dropdown.appendChild(selector)
            }

            update_chart()

            area_dropdown.onchange = update_chart
            period_dropdown.onchange = update_chart
            addEventListener("resize", update_chart);
            if (window.matchMedia) {
                window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', ({ matches }) => {
                    dark_mode = matches
                    if (dark_mode) {
                        options.legend.textStyle = { color: '#f5f5f5' }
                        options.hAxis.textStyle = { color: '#f5f5f5' }
                        options.vAxis.textStyle = { color: '#f5f5f5' }
                        options.backgroundColor = '#121619'
                    } else {
                        options.legend.textStyle = { color: 'black' }
                        options.hAxis.textStyle = { color: 'black' }
                        options.vAxis.textStyle = { color: 'black' }
                        options.backgroundColor = 'white'
                    }
                    update_chart()
                })
            }
            area_dropdown.value = scores.area_keys[0]
            period_dropdown.value = Object.keys(periodRanges)[4]
            update_table(scores)
            update_chart()
        })
}
