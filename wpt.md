---
layout: default.html
title: WPT Scores
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

  #score-table {
      width: 100%;
      margin-top: 30px;
  }

  #score-table th {
      border-bottom: 1px solid black;
      text-transform: uppercase;
  }

  #score-table th, td {
      padding: 5px 10px;
  }

  #score-table th:nth-child(1) {
      text-align: left;
  }

  #score-table-body .score {
      text-align: right;
  }

  #score-explanation {
      padding: 10px;
      margin-top: 20px;
      margin-bottom: 40px;
      font-size: 1rem;
  }

  .chart-filter-bar {
    display: flex;
    flex-wrap: wrap;
    column-gap: 40px;
    row-gap: 20px;
  }

  .chart-filter {
    display: flex;
    align-items: center;
    gap: 20px;
  }
</style>
<div class="inner-container wpt-score-page">
  <h1>{{ title }}</h1>
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
    <table id="score-table">
        <thead id="score-table-header"><tr><th>Test Suite</th><th>Score</th></tr></thead>
        <tbody id="score-table-body"></tbody>
    </table>
    <div id="score-explanation">
        Scores are calculated as percentages of total <b>enabled</b>
        tests within the suite that pass. A passing test with no
        subtests gets a score of 1 while a test with subtests gets a
        score between 0 and 1 representing the fraction of passing
        subtests within that test. This is different from the
        percentages on wpt.fyi which is calculated by giving equal
        weight to both top-level tests and subtests.
    </div>
</div>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="{{ '/js/load-chart.js' | url }}"></script>