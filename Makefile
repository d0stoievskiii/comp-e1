ifeq ($(OS),Windows_NT)
    RM = del /Q /F
    EXT = .exe
    FIX_PATH = $(subst /,\,$1)
else
    RM = rm -f
    EXT =
    FIX_PATH = $1
endif

SCANNER_DIR := scanner_generator/scanner_generator
PARSER_DIR := parser
EXAMPLES_DIR := examples

PYTHON ?= python3
SPEC ?= racket_specs.txt
OUT_SCANNER := ./out_scanner

EXAMPLES := $(wildcard $(EXAMPLES_DIR)/*.rkt)

.PHONY: all init build-generator generate-scanner build-scanner scan parse clean

all: init build-generator generate-scanner build-scanner scan parse

init:
	git submodule update --init --recursive

build-generator:
	$(MAKE) -C $(SCANNER_DIR) scanner

generate-scanner: build-generator
	cd $(SCANNER_DIR) && ./scanner generate-scanner $(SPEC) $(OUT_SCANNER)

build-scanner: generate-scanner
	$(MAKE) -C $(SCANNER_DIR) scanner_tokens_json

scan: build-scanner
	mkdir -p token_lists
	@for file in $(EXAMPLES); do \
		echo "Scanning $$file"; \
		cd $(PARSER_DIR) && ../$(SCANNER_DIR)/scanner_tokens_json ../$$file; \
		cd ..; \
	done

parse:
	cd $(PARSER_DIR) && $(PYTHON) main.py

clean:
	$(MAKE) -C $(SCANNER_DIR) clean
	rm -rf token_lists trees
