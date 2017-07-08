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
	$(GHDL) --wave=output/test_mmu_tb.ghw -r test_mmu_tb | tee output/test_mmu_tb.log

.PHONY: test_mmu
