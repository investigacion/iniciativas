pages: gh-pages/iniciativas/index.html gh-pages/img

gh-pages/iniciativas/index.html: gh-pages/iniciativas node_modules html/iniciativas.ms data/iniciativas.json gh-pages/css/iniciativas.css
	node \
		-e "console.log(require('hogan.js') \
			.compile(require('fs').readFileSync('html/iniciativas.ms', {encoding: 'utf8'})) \
			.render({ \
				initiatives: require('./data/iniciativas.json') \
			}))" \
		> $@

gh-pages/css/%.css: gh-pages/css node_modules css/%.scss css/shared/*.scss
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
	gh-pages/iniciativas

$(SUBDIRS): gh-pages
	if [ ! -d $@ ]; then \
		mkdir $@; \
	fi;
	touch $@

gh-pages/img: gh-pages
	cp -r img $@
	touch $@

.PHONY: pages
