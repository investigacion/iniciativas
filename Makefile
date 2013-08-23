INICIATIVAS := $(shell \
		cat data/iniciativas.csv | \
		grep -oE "^[0-9]+")

pages: gh-pages/img gh-pages/iniciativas/index.html $(INICIATIVAS:%=gh-pages/iniciativas/%.html) gh-pages/css/iniciativa.css gh-pages/css/iniciativas.css gh-pages/js/iniciativas.js gh-pages/data/iniciativas.json

gh-pages/iniciativas/index.html: node_modules gh-pages/iniciativas html/iniciativas.ms
	node \
		-e "console.log(require('hogan.js') \
			.compile(require('fs').readFileSync('html/iniciativas.ms', {encoding: 'utf8'})) \
			.render({ \
				initiatives: require('./data/iniciativas.json') \
			}))" \
		> $@

$(INICIATIVAS:%=gh-pages/iniciativas/%.html): node_modules html/iniciativa.ms
	node \
		-e "var initiative; \
			require('./data/iniciativas.json').some(function(c) { \
				if ($(patsubst %.html,%,$(@F)) === c['número']) { \
					initiative = c; \
					return true; \
				} \
			}); \
			console.log(require('hogan.js') \
				.compile(require('fs').readFileSync('html/iniciativa.ms', {encoding: 'utf8'})) \
				.render(initiative))" \
		> $@

gh-pages/data/iniciativas.json: gh-pages/data data/iniciativas.json
	node \
		-e "console.log(JSON.stringify(require('./data/iniciativas.json')))" \
		> $@

gh-pages/js/%.js: node_modules gh-pages/js js/%.js
	./node_modules/browserify/bin/cmd.js \
		js/$(@F) \
		--outfile $@ \
		--entry js/$(@F)

gh-pages/css/%.css: gh-pages/css css/%.scss css/shared/*.scss
	compass compile \
		css/$(@F:.css=.scss) \
		--sass-dir css \
		--css-dir gh-pages/css \
		--output-style compressed \
		--force

data/iniciativas.json: node_modules data/iniciativas.csv scripts/data/iniciativas.js
	node \
		-e "require('./scripts/data/iniciativas').convert('data/iniciativas.csv', '$@')"

data/iniciativas.csv:
	curl \
		--compressed \
		--output $@ \
		--progress-bar \
		"https://docs.google.com/spreadsheet/pub?key=0Au1_UCDowko-dGpDSEdzRGs5VkZsLUtWTzZRY1NPckE&single=true&gid=0&output=csv"

node_modules: package.json
	npm install
	touch $@

gh-pages:
	if [ ! -d $@ ]; then \
		mkdir $@; \
	fi;
	touch $@

SUBDIRS := \
	gh-pages/css \
	gh-pages/iniciativas \
	gh-pages/data \
	gh-pages/js

$(SUBDIRS): gh-pages
	if [ ! -d $@ ]; then \
		mkdir $@; \
	fi;
	touch $@

gh-pages/img: gh-pages
	cp -r img $@
	touch $@

.PHONY: pages
