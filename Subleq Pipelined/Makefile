GHDLI=ghdl "-i" "--workdir=work" "--ieee=synopsys" 
GHDLM=ghdl "-m" "--workdir=work" "--ieee=synopsys"
GHDLE=ghdl "-e" "--workdir=work" "--ieee=synopsys"
GHDLR=ghdl "-r" "--workdir=work" "--ieee=synopsys"
all: test_mmu test_regfile

test_mmu_tb: test/simulation/test_mmu_tb.vhd src/mmu.vhd src/BRAM.vhd
	$(GHDLI) $^
	$(GHDLM) test_mmu_tb
	$(GHDLE) test_mmu_tb

test_mmu: test_mmu_tb
	$(GHDLR) test_mmu_tb --vcd=output/test_mmu_tb.vcd --wave=output/test_mmu_tb.ghw | tee output/test_mmu_tb.log

test_regfile_tb: test/simulation/test_regfile_tb.vhd src/regfile.vhd src/BRAM.vhd
	$(GHDLI) $^
	$(GHDLM) test_regfile_tb
	$(GHDLE) test_regfile_tb

test_regfile: test_regfile_tb
	$(GHDLR) test_regfile_tb --vcd=output/test_regfile_tb.vcd --wave=output/test_regfile_tb.ghw | tee output/test_regfile_tb.log

.PHONY: test_mmu test_regfile
