# clear implicit rule
.SUFFIXES:

SMLSHARP = smlsharp
SMLFLAGS = -O2
LIBS =
TARGET = sml2smi

all: $(TARGET)
$(TARGET): PrintInterface.smi main.smi PrintInterface.o main.o
	$(SMLSHARP) $(LDFLAGS) -o $(TARGET) main.smi $(LIBS)
PrintInterface.o: PrintInterface.sml PrintInterface.smi
	$(SMLSHARP) $(SMLFLAGS) -o PrintInterface.o -c PrintInterface.sml
main.o: main.sml PrintInterface.smi main.smi
	$(SMLSHARP) $(SMLFLAGS) -o main.o -c main.sml

clean:
	rm -f sml2smi main.o PrintInterface.o test_input.smi
