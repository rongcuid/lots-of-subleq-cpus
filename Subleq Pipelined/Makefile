GHDLI=ghdl "-i" "--workdir=work" "--ieee=synopsys" 
GHDLM=ghdl "-m" "--workdir=work" "--ieee=synopsys"
GHDLE=ghdl "-e" "--workdir=work" "--ieee=synopsys"
GHDLR=ghdl "-r" "--workdir=work" "--ieee=synopsys"
all: test_mmu

test_mmu_tb: test/simulation/test_mmu_tb.vhd src/mmu.vhd src/BRAM.vhd
	$(GHDLI) $^
	$(GHDLM) test_mmu_tb
	$(GHDLE) test_mmu_tb

test_mmu: test_mmu_tb
	$(GHDLR) test_mmu_tb --vcd=output/test_mmu_tb.vcd --wave=output/test_mmu_tb.ghw | tee output/test_mmu_tb.log

.PHONY: test_mmu
