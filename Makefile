mdlint:
	docker run --rm \
		-v "$$(pwd)":/workdir \
		ghcr.io/igorshubovych/markdownlint-cli:latest \
		"**/*.md"
