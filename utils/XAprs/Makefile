#
# Makefile for XAprs
#

PRJ := XAprs

CROSS_COMPILE ?= 

CC    ?= $(CROSS_COMPILE)gcc
CXX   ?= $(CROSS_COMPILE)g++




gcc -g  -o XAprs XAprs.c -ljpeg -l X11 -lm -lrt -lconfig -lpng `pkg-config gtk+-2.0 --cflags --libs`
