yarn:
	yarn

serve: yarn
	hugo server \
		--buildDrafts \
		--buildFuture \
		--bind=0.0.0.0 \
		--disableFastRender

clean:
	rm -rf resources/ node_modules/ public/

production-build:
	hugo \
		--minify

preview-build:
	hugo \
		--baseURL $(DEPLOY_PRIME_URL) \
		--buildDrafts \
		--buildFuture \
		--minify

update-governance:
	TMPDIR=$$(mktemp -d) ;\
	git clone git@github.com:servo/project.git $$TMPDIR ;\
	rsync -r $$TMPDIR/governance/CHARTER.md $$TMPDIR/governance/tsc content/governance/ ;\
	ls $$TMPDIR
