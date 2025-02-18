function fetchJSON(url, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            callback(JSON.parse(xhr.responseText));
        }
    };
    xhr.open('GET', url, true);
    xhr.send();
}

function createExperimentElement(info) {
    var article = document.createElement('article');
    article.className = 'experiment-preview';

    var h4 = document.createElement('h4');
    h4.textContent = info.name;

    var link = document.createElement('a');
    link.href = info.href ? "https://demo.servo.org/" + info.href : "https://youtu.be/" + info.youtube_id;
    link.appendChild(h4);

    article.appendChild(link);

    var image = document.createElement('img');
    if (info.href) {
        image.src = "https://demo.servo.org/" + info.href + 'thumb.png';
    } else {
        image.src = 'https://img.youtube.com/vi/' + info.youtube_id + '/0.jpg';
    }
    image.width = 256;
    image.height = 256;
    link.appendChild(image);

    var desc = document.createElement('div');
    desc.className = 'experiment-desc';
    
    var shortDesc = document.createElement('div');
    shortDesc.innerHTML = info.desc;
    desc.appendChild(shortDesc);

    if (info.long_description) {
        var longDesc = document.createElement('div');
        longDesc.innerHTML = info.long_description;
        longDesc.style.display = 'none';
        desc.appendChild(longDesc);

        var toggle = document.createElement('a');
        toggle.textContent = 'Read More';
        toggle.style.display = 'block';
        toggle.style.marginTop = '10px';
        toggle.style.color = 'blue';
        toggle.style.cursor = 'pointer';
        desc.appendChild(toggle);

        toggle.onclick = function() {
            if (longDesc.style.display === 'none') {
                longDesc.style.display = 'block';
                toggle.textContent = 'Read Less';
            } else {
                longDesc.style.display = 'none';
                toggle.textContent = 'Read More';
            }
        };
    }

    article.appendChild(desc);
    return article;
}

function addExperiments(containerId, experiments) {
    var container = document.getElementById(containerId);
    experiments.forEach(function(experiment) {
        container.appendChild(createExperimentElement(experiment));
    });
}

window.onload = function() {
    fetchJSON('https://demo.servo.org/experiments.json', function(data) {
        addExperiments('other-experiments', data.experiments);
        addExperiments('technical-tests', data.tests);
        addExperiments('videos', data.videos);
    });
};