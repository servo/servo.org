---
layout: default.html
title: WPT Pass Rates
---
<style>
  .odd {
      background-color: #f0efef;
  }

  #selected-area {
      padding: 10px;
  }

  #selected-period {
      padding: 10px;
  }

  #score-table-container {
      overflow-x: auto;
  }

  #score-table {
      width: 100%;
  }

  #score-table th {
      border-bottom: 1px solid black;
      text-transform: uppercase;
  }

  #score-table th, td {
      padding: 5px 10px;
  }

  #score-table th {
      text-align: right;
  }
  #score-table th:nth-child(1) {
      text-align: left;
  }

  #score-table-body .score {
      text-align: right;
      font-family: "Fira Mono", monospace;
  }

  #score-explanation {
      padding: 10px;
      margin-top: 20px;
      margin-bottom: 40px;
  }

  #servo-chart, .chart-filter-bar, .chart-filter, #score-table {
      max-width: 48rem;
  }

  .chart-filter-bar {
    display: flex;
    flex-wrap: wrap;
    column-gap: 40px;
    row-gap: 20px;
    place-content: center;
  }

  .chart-filter {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
  }
</style>
<div class="inner-container wpt-score-page">
  <h1>{{ title }}</h1>
  <p class="subtitle">

The chart below tracks our pass rates in several *focus areas* of the [Web Platform Tests](http://web-platform-tests.org/), as well as the whole CSS and WPT test suites. To drill down the pass rates under a focus area, see the [Servo results on wpt.fyi](https://wpt.fyi/results/?product=servo).

  </p>
  <br>
    <div class="chart-filter-bar">
      <div class="chart-filter">
          <label for="selected-area">Test suite:</label>
          <select id="selected-area" name="selected-area"></select>
      </div>
      <div class="chart-filter">
          <label for="selected-period">period:</label>
          <select id="selected-period" name="selected-period"></select>
      </div>
    </div>
    <div id="servo-chart"></div>
    <figure id="score-table-container">
        <table id="score-table">
            <thead id="score-table-header"><tr><th>Test Suite</th><th>Score</th><th>Subtests</th></tr></thead>
            <tbody id="score-table-body"></tbody>
        </table>
    </figure>
    <p id="score-explanation">
        The results are calculated as percentages of total <b>enabled</b> tests within the suite that pass.<br>
        <b>Scores</b> are computed as follows: a passing test with no subtests gets a score of 1
        while a test with subtests gets a score between 0 and 1 representing the fraction of passing subtests within that test.<br>
        <b>Subtests</b> are calculated by giving equal weight to both top-level tests and subtests.
    </p>
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="module" src="{{ '/js/load-chart-and-table.js' | url }}"></script>