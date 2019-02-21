NUM_BINS ?= 30
TIMING_SAMPLES ?= 20
ROOT_DIR ?=/app/experiments
TEST_DIR=test
BENCHMARK_DIR ?=fresh
IDEAL_CONFIGS ?=17
CONFIGS ?=17 7
DYNAMIC_GRIFT_CONFIG ?=17

.PHONY: external fine coarse all plot clean test-clean outputs

all: coarse plot_coarse fine plot_fine external

plot_coarse:
	./plot_lattice.sh $(ROOT_DIR) coarse $(DYNAMIC_GRIFT_CONFIG) $(CONFIGS)

plot_fine:
	./plot_lattice.sh $(ROOT_DIR) fine $(DYNAMIC_GRIFT_CONFIG) $(CONFIGS)

external:
	./extremes.sh $(TIMING_SAMPLES) $(ROOT_DIR) $(BENCHMARK_DIR) $(IDEAL_CONFIGS)

fine:
	./partial.sh $(ROOT_DIR) $(TIMING_SAMPLES) $(BENCHMARK_DIR) true fine \
		$(NUM_BINS) $(CONFIGS)

coarse:
	./coarse_racket.sh $(ROOT_DIR) $(TIMING_SAMPLES) $(BENCHMARK_DIR)
	./partial.sh $(ROOT_DIR) $(TIMING_SAMPLES) $(BENCHMARK_DIR) true coarse \
		$(NUM_BINS) $(CONFIGS)

test:
	TIMING_SAMPLES=1 BIN_SAMPLES=1 NUM_BINS=20 BENCHMARK_DIR=$(TEST_DIR) ROOT_DIR=".." \
		$(MAKE) all

clean:
	find extremes partial -executable -and \( -not -type d \) -delete
	find extremes partial -type d -and -name "compiled" -exec rm -r {} \;
	$(MAKE) -C src clean

test-clean:
	rm -rf $(ROOT_DIR)/extremes/$(TEST_DIR) $(ROOT_DIR)/partial/$(TEST_DIR)

outputs:
	$(MAKE) -C outputs
