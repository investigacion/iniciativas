/*jshint node:true*/

'use strict';

var qs = require('querystring');
var data, loading = false, onload, neverFiltered = true;

require('domready')(function() {
	var timeout = null, q, form;

	window.addEventListener('load', function() {
		setTimeout(function() {
			window.addEventListener('popstate', function(event) {
				if (event.state) {
					search(event.state.q);
				} else if (!neverFiltered) {
					search('');
				}
			}, false);
		}, 0);
	}, false);

	form = document.querySelector('form.search');
	form.addEventListener('submit', function(event) {
		event.preventDefault();
		if (null !== timeout) {
			clearTimeout(timeout);
		}

		search(this.q.value, true);

		return false;
	}, false);

	form.q.addEventListener('keyup', function(event) {
		var q = this;

		// Disregard the enter key - will be handled by submit above.
		if (13 === event.keyCode) {
			return;
		}

		// Debounce.
		if (null !== timeout) {
			clearTimeout(timeout);
		}

		timeout = setTimeout(function() {
			search(q.value, true);
		}, 1000);
	}, false);

	q = qs.parse(location.search.substr(1)).q;
	if (q) {
		form.q.value = q;
		search(q);
	}
});

function search(q, pushState) {
	indicate();

	if (data) {
		return filter(q, pushState);
	}

	onload = function() {
		filter(q, pushState);
	};

	if (loading) {
		return;
	}

	loading = true;
	load(function() {
		loading = false;
		onload();
		onload = null;
	});
}

function load(cb) {
	var xhr;

	xhr = new XMLHttpRequest();
	xhr.open('GET', 'data/iniciativas.json', true);
	xhr.onload = function() {
		data = JSON.parse(xhr.responseText);
		cb();
	};

	xhr.send();
}

function indicate() {
	document.querySelector('.total').textContent = 'Buscando\u2026';
}

function unindicate(length, total) {
	var text, percentage;

	if (length && total) {
		percentage = (length / total) * 100;
		if (percentage < 1) {
			percentage = '< 1';
		} else {
			percentage = Math.round(percentage);
		}

		text = length + ' de ' + total + ' iniciativas (' + percentage + '%)';
	} else {
		text = length + ' iniciativa';
		if (1 !== length) {
			text += 's';
		}
	}

	document.querySelector('.total').textContent = text;
}

function filter(q, pushState) {
	var i, l, lis, li, initiative, total, title;

	neverFiltered = false;

	q = q.trim();
	total = data.length;

	pushState = pushState && history.pushState;

	if (q.length < 3) {
		lis = document.querySelectorAll('nav.index > ul > li.hidden');
		for (i = 0, l = lis.length; i < l; i++) {
			lis[i].classList.remove('hidden');
		}

		unindicate(total);

		title = 'Iniciativas \u2014 La Nación';
		if (pushState) {
			history.pushState(null, title, './');
		}
	} else {
		q = q.toLowerCase();
		lis = document.querySelectorAll('nav.index > ul > li');

		for (i = 0, l = lis.length; i < l; i++) {
			li = lis[i];
			initiative = data[i];

			if (-1 !== initiative.proponente.toLowerCase().indexOf(q) ||
				-1 !== initiative.asunto.toLowerCase().indexOf(q) ||
				-1 !== initiative.tipo.toLowerCase().indexOf(q) ||
				q == initiative['año']) {
				li.classList.remove('hidden');
			} else {
				total--;
				li.classList.add('hidden');
			}
		}

		unindicate(total, data.length);

		title = q + ' \u2014 Iniciativas \u2014 La Nación';
		if (pushState) {
			history.pushState({
				q: q
			}, title, './?q=' + encodeURIComponent(q));
		}
	}

	document.title = title;
}
