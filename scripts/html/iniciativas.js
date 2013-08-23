/*jshint node:true*/

'use strict';

var fs = require('fs');
var hogan = require('hogan.js');

exports.render = function(data, outputDir) {
	var template;

	template = hogan.compile(require('fs').readFileSync('html/iniciativa.ms', {
		encoding: 'utf8'
	}));

	data.forEach(function(initiative) {
		fs.writeFileSync(outputDir + '/' + initiative['número'], template.render(initiative));
	});
};
