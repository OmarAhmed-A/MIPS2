# make file for mips processor
#using ghdl

#compiler
GHDL=ghdl

#compiler flags
GHDLFLAGS=--ieee=synopsys -fexplicit

#source files
SRC= *.vhd
#DataMemory.vhd InstructionMemory.vhd MUX2.vhd MUX4.vhd MUX8.vhd MUX32.vhd PC.vhd Register.vhd RegisterFile.vhd SignExtend.vhd ALU_tb.vhd
#target files
TARGET=TB

#target rules
all: $(TARGET)

$(TARGET): $(SRC)
	$(GHDL) -a $(GHDLFLAGS) $(SRC)
	$(GHDL) -e $(GHDLFLAGS) $(TARGET)
	$(GHDL) -r $(GHDLFLAGS) $(TARGET) --stop-time=3us --vcd=sim.vcd
	gtkwave sim.vcd
clean:
	rm -f *.o *.cf *.vcd $(TARGET) make.log

cleanwin:
	del *.o *.cf *.vcd $(TARGET) make.log
#end of file
