FROM tomcat:latest
ENV TZ 'America/New_York'

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone    
RUN   sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN   sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list 
RUN apt-get update
RUN apt-get install -y sudo time git-core subversion build-essential gcc-multilib \
    build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch  python2.7 unzip zlib1g-dev  libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf vim screen \
                       libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python3 
RUN apt install -y ack antlr3 asciidoc autoconf automake autopoint binutils bison build-essential \
       bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
    git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
    libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
    mkisofs  nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pyelftools \
    libpython3-dev qemu-utils rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip \
    vim wget xmlto xxd zlib1g-dev
RUN apt-get clean
RUN git clone https://github.com/coolsnowwolf/lede
RUN git clone https://github.com/zater/dockertest
RUN cp dockertest/.config lede/
RUN cd lede;./scripts/feeds update -a;./scripts/feeds install -a; make download -j8
RUN  make V=s -j1
  #&&\
 #   echo -ne "
#src-git lienol https://github.com/TinyTitanPro/lienol-openwrt-package" >> openwrt/feeds.conf.default &&\
 #  openwrt/scripts/feeds clean &&\
 #   openwrt/scripts/feeds update -a &&\
 #   openwrt/scripts/feeds  install -a
