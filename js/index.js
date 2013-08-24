/*jshint node:true*/

'use strict';

var qs = require('querystring');
var data, loading = false, onload, popstateAdded;

window.addEventListener('popstate', function(event) {
	console.log(event);
}, false);

require('domready')(function() {
	var timeout = null, q;

	document.querySelector('form.search').addEventListener('submit', function(event) {
		event.preventDefault();
		return false;
	}, false);

	document.querySelector('.q').addEventListener('keyup', function() {

		// Debounce
		if (null !== timeout) {
			clearTimeout(timeout);
		}

		timeout = setTimeout(function() {
			search(document.querySelector('.q').value, true);
		}, 1000);
	}, false);

	q = qs.parse(location.search.substr(1)).q;
	if (q) {
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

function unindicate(length) {
	var text;

	text = length + ' iniciativa';
	if (1 !== length) {
		text += 's';
	}

	document.querySelector('.total').textContent = text;
}

function filter(q, pushState) {
	var i, l, lis, li, initiative, total;

	q = q.trim();
	total = data.length;

	pushState = pushState && history.pushState;

	if (q.length < 3) {
		lis = document.querySelectorAll('nav.index > ul > li.hidden');
		for (i = 0, l = lis.length; i < l; i++) {
			lis[i].classList.remove('hidden');
		}

		if (pushState) {
			history.pushState(null, 'Iniciativas \u2014 La Nación', './');
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

		if (pushState) {
			history.pushState({
				q: q
			}, q + ' \u2014 Iniciativas \u2014 La Nación', './?q=' + encodeURIComponent(q));
		}
	}

	if (!popstateAdded) {
		window.addEventListener('popstate', function(event) {
			search((event.state && event.state.q) || '');
		}, false);

		popstateAdded = true;
	}

	unindicate(total);
}
