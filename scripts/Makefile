BIN_SAMPLES ?= 30
NUM_BINS ?= 30
TIMING_SAMPLES ?= 5
ROOT_DIR ?=/app/experiments
TEST_DIR=test
BENCHMARK_DIR ?=fresh
IDEAL_CONFIGS ?=17
CONFIGS ?=17 7

.PHONY: external fine coarse all clean test-clean outputs

all: coarse fine external

external:
	./extremes.sh $(TIMING_SAMPLES) $(ROOT_DIR) $(BENCHMARK_DIR) $(IDEAL_CONFIGS)

fine:
	./lattice_bins.sh $(ROOT_DIR) $(TIMING_SAMPLES) $(BENCHMARK_DIR) true fine \
		$(BIN_SAMPLES) $(NUM_BINS) $(CONFIGS)

coarse:
	./lattice_bins.sh $(ROOT_DIR) $(TIMING_SAMPLES) $(BENCHMARK_DIR) true coarse \
		$(BIN_SAMPLES) $(NUM_BINS) $(CONFIGS)

test:
	TIMING_SAMPLES=1 BIN_SAMPLES=1 NUM_BINS=20 BENCHMARK_DIR=$(TEST_DIR) ROOT_DIR=".." \
		$(MAKE) all

clean:
	find extremes lattice_bins -executable -and \( -not -type d \) -delete
	find extremes lattice_bins -type d -and -name "compiled" -exec rm -r {} \;
	$(MAKE) -C src clean

test-clean:
	rm -rf $(ROOT_DIR)/extremes/$(TEST_DIR) $(ROOT_DIR)/lattice_bins/$(TEST_DIR)

outputs:
	$(MAKE) -C outputs
