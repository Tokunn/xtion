include CommonDefs.mak

BIN_DIR = Bin

INC_DIRS = \
    /usr/loca/include/ni2/Include
	#../../Include \
	#../Common

SRC_FILES = *.cpp

ifeq ("$(OSTYPE)","Darwin")
	CFLAGS += -DMACOS
	LDFLAGS += -framework OpenGL -framework GLUT
else
	CFLAGS += -DUNIX -DGLX_GLXEXT_LEGACY
	USED_LIBS += glut GL
endif

USED_LIBS += OpenNI2 opencv_core opencv_highgui opencv_imgproc

EXE_NAME = ColorStream

CFLAGS += -Wall


ifndef OPENNI2_INCLUDE
    $(error OPENNI2_INCLUDE is not defined. Please define it or 'source' the OpenNIDevEnvironment file from the installation)
else ifndef OPENNI2_REDIST
    $(error OPENNI2_REDIST is not defined. Please define it or 'source' the OpenNIDevEnvironment file from the installation)
endif

INC_DIRS += $(OPENNI2_INCLUDE)

include CommonCppMakefile

.PHONY: copy-redist
copy-redist:
	cp -R $(OPENNI2_REDIST)/* $(OUT_DIR)
	
$(OUTPUT_FILE): copy-redist

