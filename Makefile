all:
	coffee -c src/*.coffee
	cat doc/credits > pxt.js
	browserify src/pxt.js >> pxt.js
	mv src/*.js src/compiled

test: all
	stylus src/test/css/*.styl
	cat src/test/css/*.css > web/test.css
	mv src/test/css/*.css src/test/css/compiled
	cp pxt.js web/pxt.js

clean:
	rm -f src/compiled/*.js
	rm -f src/test/css/compiled/*.css

cloc:
	cloc doc src/*.coffee src/css/test/*.styl web/*.html