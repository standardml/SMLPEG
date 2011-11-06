BIN=bin
COMPILER=mlton

$(BIN)/smlpeg: smlpeg-first.peg.sml main.sml smlpeg.mlb smlpeg.first
	cp smlpeg-first.peg.sml smlpeg.peg.sml
	$(COMPILER) -output $(BIN)/smlpeg smlpeg.mlb

smlpeg-first.peg.sml: smlpeg.first smlpeg.peg
	./smlpeg.first -v smlpeg.peg >/dev/null
	mv -f smlpeg.peg.sml smlpeg-first.peg.sml

smlpeg.first: smlpeg-selfhosted.peg.sml smlpeg.selfhosted main.sml smlpeg.mlb
	cp smlpeg-selfhosted.peg.sml smlpeg.peg.sml
	$(COMPILER) -output smlpeg.first smlpeg.mlb

smlpeg-selfhosted.peg.sml: smlpeg.selfhosted smlpeg.peg
	./smlpeg.selfhosted smlpeg.peg
	mv -f smlpeg.peg.sml smlpeg-selfhosted.peg.sml

smlpeg.selfhosted: smlpeg-bootstrap.peg.sml main.sml smlpeg.mlb
	cp smlpeg-bootstrap.peg.sml smlpeg.peg.sml
	$(COMPILER) -output smlpeg.selfhosted smlpeg.mlb 

smlpeg-bootstrap.peg.sml: smlpeg.bootstrap smlpeg.peg
	./smlpeg.bootstrap smlpeg.peg
	mv -f smlpeg.peg.sml smlpeg-bootstrap.peg.sml

smlpeg.bootstrap: bootstrap.sml
	$(COMPILER) -output smlpeg.bootstrap bootstrap.sml

install: $(BIN)/smlpeg
	mv $(BIN)/smlpeg ../../../bin

.PRECIOUS: smlpeg.peg.sml

clean:
	rm -f $(BIN)/smlpeg \
		smlpeg.bootstrap smlpeg.selfhosted smlpeg.first \
		smlpeg-bootstrap.peg.sml smlpeg-selfhosted.peg.sml smlpeg-first.peg.sml\
		smlpeg.peg.sml smlpeg.peg.sml smlpeg.sml

.PHONY: clean

.INTERMEDIATE: smlpeg.bootstrap smlpeg.selfhosted smlpeg.first \
		smlpeg-bootstrap.peg.sml smlpeg-selfhosted.peg.sml smlpeg-first.peg.sml
	
