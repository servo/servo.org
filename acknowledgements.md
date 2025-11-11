---
layout: default.html
title: Acknowledgements
---

<div class="inner-container subpage-content">
<h1>{{ title }}</h1>

<p>The Servo project is dependent on outside funding. Big thanks to the following organizations that have recently invested in Servo:</p>

<ul id="partners">
{% for partner in partners | sort(attribute="name") %}
  <li>
    <a href="{{ partner.url }}">
      <img src="{{ partner.img | url}}" alt="{{ partner.name }} logo" class="partner-img" />
    </a>
  </li>
{% endfor %}
</ul>

<p>We are very grateful to all the sponsors that contribute monetarily to support the project via <a href="https://opencollective.com/servo">Open Collective</a>, <a href="https://github.com/sponsors/servo">GitHub</a> and <a href="https://thanks.dev/">thanks.dev</a>.
</p>

<h2>Infrastructure Sponsors</h2>

<p>The Servo project also uses some free services provided by different companies:</p>

* Repositories and some CI infrastructure (<https://github.com/servo>) are hosted by [GitHub](https://github.com/).
* Chat tool (<https://servo.zulipchat.com/>) is provided by [Zulip](https://zulip.com/).
* [AWS Open Source](https://aws.amazon.com/opensource/) is providing promotional credits to cover our infrastructure costs.

</div>

<style>

ul#partners {
  list-style: none;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
}

.partner-img {
  max-width: 15rem;
  margin: 2rem;
}

</style>