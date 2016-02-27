BINUTILS_VERSION=2.26
GCC_VERSION=5.3.0

i386: binutils gcc
	./bld.sh i386 i386-linux

x86_64: binutils gcc
	./bld.sh x86_64 x86_64-linux

arm: binutils gcc
	./bld.sh arm arm-linux-gnueabi

aarch64: binutils gcc
	./bld.sh aarch64 aarch64-linux

mips: binutils gcc
	./bld.sh mips mips-linux

clean:
	rm -rf build

distclean: clean
	rm -rf toolchains
	rm -rf src

binutils: src/binutils-$(BINUTILS_VERSION)

gcc: src/gcc-$(GCC_VERSION)

src/binutils-$(BINUTILS_VERSION): src
	wget -P src https://ftp.gnu.org/gnu/binutils/binutils-$(BINUTILS_VERSION).tar.bz2
	tar xf src/binutils-$(BINUTILS_VERSION).tar.bz2 -C src/

src/gcc-$(GCC_VERSION): src
	wget -P src http://www.netgull.com/gcc/releases/gcc-$(GCC_VERSION)/gcc-$(GCC_VERSION).tar.bz2
	tar xf src/gcc-$(GCC_VERSION).tar.bz2 -C src/
	cd src/gcc-$(GCC_VERSION); ./contrib/download_prerequisites

src:
	mkdir -p src
