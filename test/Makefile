# Makefile for Pure Verilog Simulation
# 1. Source files
#    Adjust the filename if your src file is named differently!
SRC = ../src/tt_um_first_asic.v ../src/seven_seg.v
TB = tb.v

# 2. Tools
SIM = iverilog
RUN = vvp

# 3. Targets
.PHONY: test clean

test: sim.vvp
	$(RUN) sim.vvp

sim.vvp: $(SRC) $(TB)
	$(SIM) -o sim.vvp -s tb $(SRC) $(TB)

clean:
	rm -f sim.vvp tb.vcd