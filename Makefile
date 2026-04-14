.DEFAULT_GOAL:=preview

preview:
	docker run --rm -it \
		-v "${PWD}":/project \
		-p 1313:1313 \
		ghcr.io/gohugoio/hugo:v0.156.0 \
		server -w --bind=0.0.0.0

preview_finch:
	finch run --rm -it \
		-v "${PWD}":/project \
		-p 1313:1313 \
		ghcr.io/gohugoio/hugo:v0.156.0 \
		server -w --bind=0.0.0.0 --poll 700ms

mdlint:
	docker run --rm \
		-v "$$(pwd)":/workdir \
		ghcr.io/igorshubovych/markdownlint-cli:latest \
		"**/*.md"

mdlint_finch:
	finch run --rm \
		-v "$(pwd)":/workdir \
		ghcr.io/igorshubovych/markdownlint-cli:latest \
		"**/*.md"
