---
layout: default.html
title: Made With Servo
---

<style type="text/css">

.made-with-container {
  gap: 20px;
  display: flex;
  flex-wrap: wrap;
  justify-content: start;
  margin-bottom: 32px;
}

.made-with-item {
  display: block;
  width: 400px;
  flex: 0 0 400px;
  border: 2px solid #333;
  cursor: pointer;
  color: inherit;
  text-decoration: inherit;
}

.made-with-item:hover {
  background-color: rgba(27, 131, 129, 0.5);
  background-color: #EAEAEA;
}

.made-with-text {
  padding: 20px;
}

.made-with-text > p {
  padding: 0;
}

.made-with-image {
  aspect-ratio: 2;
  object-fit: cover;
  object-position: top left;
  background-color: transparent;
}

</style>

<div class="inner-container">

<h1>{{ title }}</h1>
<p class="subtitle" style="margin-bottom: 32px">
  This page showcases projects that are built with Servo or Servo components.
</p>

{% for group in madewith %}

### {{group.name}}

<div class="made-with-container">

  {% for project in group.projects %}

  <a class="made-with-item" href="{{project.link}}" target="_blank">
    {% if project.img %}
      <img src="{{ project.img | url }}" class="made-with-image" alt=" " />
    {% else %}
      <!--<img src="{{ project.img | url }}" class="made-with-image" alt=" " /> -->
    {% endif %}
    <div class="made-with-text">
      <h4>{{ project.name }}</h4>
      <p>{{ project.description }}</p>
    </div>
  </a>

  {% endfor %}
</div>

{% endfor %}


</div>