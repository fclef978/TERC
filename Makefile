COMPILER = iverilog
SOURCES  = $(wildcard src/*.v)
TARGET   = TERC

vvp: $(SOURCES)
	$(COMPILER) -o $(TARGET).vvp -s $(TARGET) $(SOURCES)

vcd: vvp
	vvp $(TARGET).vvp

all: 
	clean vcd

clean: 
	rm -f *.vcd *.vvp
