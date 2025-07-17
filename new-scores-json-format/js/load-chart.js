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

function toolTip (date, wpt_sha, servo_version, score) {
    return `
        <b>${formatDate(date)}</b></br>
        Score: <b>${Math.floor(1000 * score.total_score / score.total_tests) / 10}%</b></br>
        Subtests: <b>${Math.floor(1000 * score.total_subtests_passed / score.total_subtests) / 10}%</b></br>
        WPT: ${wpt_sha}</br>
        Version: ${servo_version}
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
    let score_data

    Object.keys(periodRanges).forEach(date => {
        const selector = document.createElement('option')
        selector.value = date
        selector.textContent = date
        period_dropdown.appendChild(selector)
    })

    function update_chart () {
        if (!score_data) throw new Error('scores not loaded')
        const area_index = +area_dropdown.value
        const chosen_period = period_dropdown.value
        const table = new google.visualization.DataTable()
        options.series = []
        const monthsToSubtract = periodRanges[chosen_period]
        const minDate = monthsToSubtract
            ? new Date(maxDate.getFullYear(), maxDate.getMonth() - monthsToSubtract, 1)
            : null

        table.addColumn('date', 'runOn')

        options.series.push({ color: dark_mode ? '#CC9933' : '#3366CC' })
        table.addColumn('number', 'Score')
        table.addColumn({ type: 'string', role: 'tooltip', p: { html: true } })
        table.addColumn('number', 'Subtests')
        table.addColumn({ type: 'string', role: 'tooltip', p: { html: true } })

        for (const run of score_data.runs) {
            const area_score = run.scores[area_index]
            const date = parseDateString(run.date)
            if (date < minDate) {
                continue
            }
            const row = [
                date,
                area_score.total_score / area_score.total_tests,
                toolTip(date, run.wpt_revision, run.product_revision, area_score),
                area_score.total_subtests_passed / area_score.total_subtests,
                toolTip(date, run.wpt_revision, run.product_revision, area_score)
            ]
            table.addRow(row)
        }
        chart.draw(table, options)
    }

    fetchData
        .then(resp => resp.json())
        .then(data => {
            score_data = data
            if (score_data.runs.length < 60) {
                options.hAxis.format = 'dd MMM YYYY'
            } else {
                options.hAxis.format = 'MMM YYYY'
            }

            for (const [index, area] of score_data.focus_areas.entries()) {
                const selector = document.createElement('option')
                selector.value = index
                selector.textContent = area
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
            area_dropdown.value = 0
            period_dropdown.value = Object.keys(periodRanges)[4]
            update_chart()
        })
}
