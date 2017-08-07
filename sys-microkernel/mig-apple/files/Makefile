HOST_CPU := $(shell uname -m)
ifeq ($(HOST_CPU),i386)
	CPPFLAGS = -D__i386__ -DI386 -D__LITTLE_ENDIAN__
	CFLAGS = -m32 -O2
endif
ifeq ($(HOST_CPU),i686)
	CPPFLAGS = -D__i386__ -DI386 -D__LITTLE_ENDIAN__
	CFLAGS = -m32 -O2
endif
ifeq ($(HOST_CPU),x86_64)
	CPPFLAGS = -D__i386__ -DI386 -D__LITTLE_ENDIAN__
	CFLAGS = -m32 -O2
endif
ifeq ($(HOST_CPU),armv7l)
	CPPFLAGS = -D__arm__ -DARM -D__LITTLE_ENDIAN__
	CFLAGS = -O2
endif
ifeq ($(HOST_CPU),armv61)
	CPPFLAGS = -D__arm__ -DARM -D__LITTLE_ENDIAN__
	CFLAGS = -O2
endif
ifeq ($(HOST_CPU),powerpc)
	CPPFLAGS = -D__ppc__ -DPOWERPC -D__LITTLE_ENDIAN__
	CFLAGS = -O2
endif
ifeq ($(HOST_CPU),unknown)
	@echo "ERROR: Unknown host cpu type!"
	exit 1
endif

TARGET = migcom
OBJECTS = error.o global.o header.o lex.yy.o mig.o routine.o server.o \
	statement.o string.o type.o user.o utils.o parser.o
CPPFLAGS += -I include/ \
	-include include/compat.h
CFLAGS += -pipe
LDFLAGS +=

all: $(TARGET)

$(TARGET): y.tab.h $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET)

y.tab.h:
	yacc -d parser.y

lex.yy.o: y.tab.h
	lex lexxer.l
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o lex.yy.o lex.yy.c

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(TARGET) $(OBJECTS) lex.yy.c y.tab.h

install: $(TARGET)
	install -d $(DESTDIR)/$(DEVELOPER_DIR)/usr/bin
	install -d $(DESTDIR)/$(DEVELOPER_DIR)/usr/libexec
	install -d $(DESTDIR)/$(DEVELOPER_DIR)/usr/share/man/man1
	install -m 755 mig.sh $(DESTDIR)/$(DEVELOPER_DIR)/usr/bin/mig
	install -s -m 755 migcom $(DESTDIR)/$(DEVELOPER_DIR)/usr/libexec/migcom
	install -m 644 mig.1 $(DESTDIR)/$(DEVELOPER_DIR)/usr/share/man/man1/mig.1
	install -m 644 migcom.1 $(DESTDIR)/$(DEVELOPER_DIR)/usr/share/man/man1/migcom.1
