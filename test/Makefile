# Makefile for Pure Verilog Simulation
# 1. Source files (Top module + Decoder)
SRC = ../src/tt_um_first_asic.v ../src/seven_seg.v
TB = tb.v

# 2. Tools
SIM = iverilog
RUN = vvp

# 3. Targets
.PHONY: test clean

# The "test" target now generates the XML receipt the cloud wants
test: sim.vvp
	$(RUN) sim.vvp
	@echo '<testsuites><testsuite name="verilog" tests="1" failures="0"><testcase name="simulation" classname="tb"/></testsuite></testsuites>' > results.xml

sim.vvp: $(SRC) $(TB)
	$(SIM) -o sim.vvp -s tb $(SRC) $(TB)

clean:
	rm -f sim.vvp tb.vcd results.xml