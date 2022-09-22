.DEFAULT_GOAL:=preview

preview:
	docker run --rm -it \
		-v "${PWD}":/src \
		-p 1313:1313 \
		klakegg/hugo:0.101.0-ext-alpine \
		server -w --bind=0.0.0.0

mdlint:
	docker run --rm \
		-v "$$(pwd)":/workdir \
		ghcr.io/igorshubovych/markdownlint-cli:latest \
		"**/*.md"

