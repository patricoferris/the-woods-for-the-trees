

build:
	rm -rf dist && mkdir dist
	npm run build
	echo "<style> body { max-width: 50%; margin: auto; font-size: 1.2em; } </style>" > dist/notes.html
	omd notes.md >> dist/notes.html
	cp home/tree.jpg ./dist/tree.jpg
	cp home/index.html ./dist/index.html
	cp -r visualise ./dist/visualise
