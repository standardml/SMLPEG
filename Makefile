BIN=bin
COMPILER=mlton

$(BIN)/smlpeg: smlpeg-first.kpg.k main.sml smlpeg.mlb smlpeg.first
	cp smlpeg-first.kpg.k smlpeg.kpg.sml
	$(COMPILER) -output $(BIN)/smlpeg smlpeg.mlb

smlpeg-first.kpg.k: smlpeg.first smlpeg.kpg
	./smlpeg.first -v smlpeg.kpg >/dev/null
	mv -f smlpeg.kpg.k smlpeg-first.kpg.k

smlpeg.first: smlpeg-selfhosted.kpg.k smlpeg.selfhosted main.sml smlpeg.mlb
	cp smlpeg-selfhosted.kpg.k smlpeg.kpg.sml
	$(COMPILER) -output smlpeg.first smlpeg.mlb

smlpeg-selfhosted.kpg.k: smlpeg.selfhosted smlpeg.kpg
	./smlpeg.selfhosted smlpeg.kpg
	mv -f smlpeg.kpg.k smlpeg-selfhosted.kpg.k

smlpeg.selfhosted: smlpeg-bootstrap.kpg.k main.sml smlpeg.mlb
	cp smlpeg-bootstrap.kpg.k smlpeg.kpg.sml
	$(COMPILER) -output smlpeg.selfhosted smlpeg.mlb 

smlpeg-bootstrap.kpg.k: smlpeg.bootstrap smlpeg.kpg
	./smlpeg.bootstrap smlpeg.kpg
	mv -f smlpeg.kpg.k smlpeg-bootstrap.kpg.k

smlpeg.bootstrap: bootstrap.sml
	$(COMPILER) -output smlpeg.bootstrap bootstrap.sml

.PRECIOUS: smlpeg.kpg.k

clean:
	rm -f $(BIN)/smlpeg \
		smlpeg.bootstrap smlpeg.selfhosted smlpeg.first \
		smlpeg-bootstrap.kpg.k smlpeg-selfhosted.kpg.k smlpeg-first.kpg.k\
		smlpeg.kpg.sml smlpeg.kpg.k smlpeg.sml

.PHONY: clean

.INTERMEDIATE: smlpeg.bootstrap smlpeg.selfhosted smlpeg.first \
		smlpeg-bootstrap.kpg.k smlpeg-selfhosted.kpg.k smlpeg-first.kpg.k
	
