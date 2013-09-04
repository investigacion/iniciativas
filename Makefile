INICIATIVAS := $(shell \
		cat data/iniciativas.csv | \
		grep -oE "^[0-9]+")

pages: \
	gh-pages/img \
	gh-pages/index.html \
	gh-pages/css/iniciativa.css \
	gh-pages/css/index.css \
	gh-pages/js/index.js \
	gh-pages/data/iniciativas.json \
	$(INICIATIVAS:%=gh-pages/%.html)

build/templates/%.js: html/%.ms build/templates node_modules
	echo "var Hogan = require('hogan.js/lib/template');" \
		> $@
	./node_modules/hogan.js/bin/hulk \
		html/*.ms \
		>> $@
	echo "module.exports = templates;" \
		>> $@

gh-pages/index.html: gh-pages build/templates/index.js
	node \
		-e "console.log(require('./build/templates/index').index.render({ \
				initiatives: require('./data/iniciativas.json') \
			}))" \
		> $@

$(INICIATIVAS:%=gh-pages/%.html): gh-pages build/templates/iniciativa.js
	node \
		-e "require('./data/iniciativas.json').some(function(c) { \
				if ($(patsubst %.html,%,$(@F)) === c['número']) { \
					c.asunto = '<p>' + c.asunto.split('\n').join('</p>\n<p>').replace(/<p>\s/g, '<p>') + '</p>'; \
					console.log(require('./build/templates/iniciativa').iniciativa.render(c)); \
					return true; \
				} \
			});" \
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
	./node_modules/uglify-js/bin/uglifyjs \
		$@ \
		--compress \
		--output $@
	cat js/vendor/classList.min.js \
		>> $@

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
	if [ ! -d gh-pages ]; then \
		if git ls-remote --heads https://github.com/investigacion/iniciativas.git | grep --quiet gh-pages; then \
			git clone git@github.com:investigacion/iniciativas.git -b gh-pages gh-pages; \
		else \
			mkdir gh-pages; \
			cd gh-pages; \
			git clone git@github.com:investigacion/iniciativas.git .; \
			git checkout --orphan gh-pages; \
			git rm -rf .; \
			echo ".DS_Store" > .gitignore; \
			git add .gitignore; \
			git ci -m "Initial commit"; \
			git push --set-upstream origin gh-pages; \
		fi; \
	else \
		cd gh-pages && git pull; \
		touch $@; \
	fi;

PAGES_SUBDIRS := \
	gh-pages/css \
	gh-pages/data \
	gh-pages/js

$(PAGES_SUBDIRS): gh-pages
	if [ ! -d $@ ]; then \
		mkdir $@; \
	fi;
	touch $@

BUILD_SUBDIRS := \
	build/templates

$(BUILD_SUBDIRS): build
	if [ ! -d $@ ]; then \
		mkdir $@; \
	fi;
	touch $@

gh-pages/img: gh-pages img gh-pages/img/nacion-logo.png
	cp -r img $@
	touch $@

gh-pages/img/nacion-logo.png: img/nacion-logo.svg
	inkscape \
		--without-gui \
		--export-png $@ \
		-h 24 \
		$<

publish: pages
	cd gh-pages && git add . --all && \
	git ci \
		-m "Automated commit from make" && \
	git push

clean:
	if [ -d gh-pages ]; then \
		cd gh-pages && git reset --hard && git clean -df
	fi;

.PHONY: pages clean publish
