/*jshint node:true*/

'use strict';

var fs = require('fs');
var csv = require('dsv').csv;

exports.convert = function(csvPath, jsonPath) {
	fs.writeFileSync(jsonPath, JSON.stringify(csv.parse(fs.readFileSync(csvPath, {
		encoding: 'utf8'
	})).reduce(function(p, c, i) {
		var d;

		d = {
			'número': parseInt(c['Número de Iniciativa'], 10),
			proponente: c.Proponente,
			tipo: c['Tipo de Iniciativa'],
			asunto: c.Asunto,
			tema: c.Tema,
			subtema: c.Subtema,
			'año': parseInt(c['Año de recibido'], 10),
			'trámite': c['Trámite efectuado']
		};

		if (c['URL ley de república']) {
			d.url = c['URL ley de república'];
		}

		p.push(d);

		return p;
	}, []), null, '\t'));
};
