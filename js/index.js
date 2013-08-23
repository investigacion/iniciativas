/*jshint node:true*/

'use strict';

var qs = require('querystring');
var data;

require('domready')(function() {
	var timeout = null, loading = false, q, onload;

	document.querySelector('form.search').addEventListener('submit', function(event) {
		event.preventDefault();
		return false;
	}, false);

	document.querySelector('.q').addEventListener('keyup', function() {
		var cb;

		onload = function() {
			search(document.querySelector('.q').value);
		};

		cb = function() {
			onload();
		};

		indicate();

		if (!data) {
			if (loading) {
				return;
			}

			loading = true;
			return load(cb);
		}

		// Debounce
		if (null !== timeout) {
			clearTimeout(timeout);
		}

		timeout = setTimeout(cb, 1000);
	}, false);

	q = qs.parse(location.search.substr(1)).q;
	if (q) {
		onload = function() {
			search(q);
		};

		load(function() {
			onload();
		});
	}
});

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

function search(q) {
	var i, l, lis, li, initiative, total;

	q = q.trim();
	total = data.length;

	if (q.length < 3) {
		lis = document.querySelectorAll('nav.index > ul > li.hidden');
		for (i = 0, l = lis.length; i < l; i++) {
			lis[i].classList.remove('hidden');
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
	}

	unindicate(total);
}
