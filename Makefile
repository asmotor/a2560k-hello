SRCS_ASM = hello.asm
SRCS_C = strings.c
OBJS = $(SRCS_ASM:asm=obj) $(SRCS_C:c=obj)
LIBS =
CC_FLAGS = -O2 -g -c --char-is-unsigned
ASM_FLAGS = -g -mc3 -mgf
LINK_FLAGS = -sEntry -cfxa2560x 
TARGET = hello.pgz

CLEAN = $(addsuffix .clean,$(dir $(LIBS)))

ASM = motor68k
CC = cc68k
LIB = xlib
LINK = xlink

DEPDIR := .d
DEPFLAGS = -d$(DEPDIR)/$*.Td

ifeq ($(MAKE_HOST),Windows32)
$(shell mkdir $(DEPDIR) >NUL 2>&1)
POSTCOMPILE = @move /Y $(DEPDIR)\$*.Td $(DEPDIR)\$*.d >NUL && type NUL >>$@
REMOVEALL = del /S /Q *.sym $(TARGET) $(notdir $(OBJS)) $(DEPDIR) >NUL
else
$(shell mkdir -p $(DEPDIR) >/dev/null)
POSTCOMPILE = @mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d && touch $@
REMOVEALL = rm -rf *.sym $(TARGET) $(notdir $(OBJS)) $(DEPDIR)
endif

ASSEMBLE = $(ASM) $(DEPFLAGS) $(ASM_FLAGS)
COMPILE_C = $(CC) $(CC_FLAGS)

$(TARGET) : $(notdir $(OBJS)) $(LIBS)
	$(LINK) $(LINK_FLAGS) -m$@.sym -o$@ $+

%.obj : %.asm
%.obj : %.asm $(DEPDIR)/%.d
	$(ASSEMBLE) -o$@ $<
	$(POSTCOMPILE)

%.obj : %.c
	$(COMPILE_C) -o $@ $<

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

clean : $(CLEAN)
	$(REMOVEALL)

%.clean:
	@$(MAKE) -C $* clean

# Make subdirs

SUBDIRS = $(dir $(LIBS))

subdirs: $(SUBDIRS)

.PHONY: subdirs $(SUBDIRS)

$(LIBS): subdirs

$(SUBDIRS):
	@$(MAKE) -C $(@D)

# Include dependency info

include $(wildcard $(patsubst %,$(DEPDIR)/%.d,$(basename $(notdir $(SRCS_ASM)))))
