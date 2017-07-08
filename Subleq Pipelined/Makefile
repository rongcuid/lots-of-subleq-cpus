GHDL="ghdl --workdir=work"
all: test_mmu

test_mmu_tb: test/simulation/test_mmu_tb.vhd src/mmu.vhd src/BRAM.vhd
	$(GHDL) -a $@
	$(GHDL) -e test_mmu_tb

.PHONY test_mmu
test_mmu: test_mmu_tb
	$(GHDL) -r test_mmu_tb
