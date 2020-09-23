yarn:
	yarn

serve: yarn
	hugo server \
		--buildDrafts \
		--buildFuture \
		--bind=0.0.0.0 \
		--disableFastRender

clean:
	rm -rf resources/ node_modules/

production-build:
	hugo \
		--minify

preview-build:
	hugo \
		--baseURL $(DEPLOY_PRIME_URL) \
		--buildDrafts \
		--buildFuture \
		--minify
