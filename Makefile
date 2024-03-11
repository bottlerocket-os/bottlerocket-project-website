.DEFAULT_GOAL:=preview

preview:
	docker run --rm -it \
		-v "${PWD}":/src \
		-p 1313:1313 \
		hugomods/hugo:exts-0.123.8 \
		hugo server -w --bind=0.0.0.0

preview_finch:
	finch run --rm -it \
		-v "${PWD}":/src \
		-p 1313:1313 \
		hugomods/hugo:exts-0.123.8 \
		hugo server -w --bind=0.0.0.0


mdlint:
	docker run --rm \
		-v "$$(pwd)":/workdir \
		ghcr.io/igorshubovych/markdownlint-cli:latest \
		"**/*.md"

