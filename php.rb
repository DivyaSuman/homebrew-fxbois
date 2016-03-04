#encoding: utf-8

require 'formula'

class Php < Formula
  
  # wget "http://php.net/get/php-7.0.X.tar.bz2/from/this/mirror" -O /Library/Caches/Homebrew/php-7.0.X
  url "http://php.net/get/php-7.0.4.tar.bz2/from/this/mirror"
  # openssl sha1 /Library/Caches/Homebrew/php-7.0.X
  sha1 "4e6ad0af73e9b8de66844dee2f14cc089cb5aea8"
  homepage "http://php.net"
  version "7.0.4"
  #revision 2
  
  # So PHP extensions don't report missing symbols
  skip_clean 'bin', 'sbin'
  
  depends_on 'curl'
  depends_on 'freetype'
  #depends_on 'homebrew/dupes/zlib'
  depends_on 'jpeg'
  depends_on 'libpng'
  #depends_on 'libressl'
  depends_on 'libtool'
  depends_on 'libxml2'
  depends_on 'mysql'
  depends_on 'openssl'
  depends_on 'readline'
  depends_on 'fxbois/fxbois/tidy'
  #depends_on 'tidy-html5'

  def install

    args = [
      "--prefix=#{prefix}",
      "--localstatedir=#{var}",
      #"--sysconfdir=#{config_path}",
      "--libexecdir=#{libexec}",
      "--mandir=#{man}",
      "--disable-cgi",
      "--disable-debug",
      "--disable-opcache",
      #"--enable-bcmath",
      "--enable-calendar",
      #"--enable-exif",
      #"--enable-ftp",
      "--enable-gd-native-ttf",
      #"--enable-intl=no",
      #"--enable-mbregex",
      "--enable-mbstring",
      "--enable-pcntl",
      #"--enable-shmop",
      "--enable-soap",
      "--enable-sockets",
      #"--enable-sysvmsg",
      #"--enable-sysvsem",
      #"--enable-sysvshm",
      #"--enable-wddx",
      "--enable-zip",
      "--with-apxs2=/usr/sbin/apxs",
      "--with-bz2=/usr",
      "--with-config-file-path=/etc",
      #"--with-config-file-scan-dir=#{config_path}/conf.d",
      "--with-curl",
      "--with-freetype-dir=#{Formula['freetype'].opt_prefix}",
      "--with-gd",
      #"--with-gettext=#{Formula['gettext'].opt_prefix}",
      #"--with-iconv-dir=/usr",
      #"--with-icu-dir=#{Formula['icu4c'].opt_prefix}",
      "--with-jpeg-dir=#{Formula['jpeg'].opt_prefix}",
      #"--with-kerberos=/usr",
      "--with-libedit",
      "--with-libxml-dir=#{Formula['libxml2'].opt_prefix}",
      #"--with-mhash",
      "--with-mysql-sock=/tmp/mysql.sock",
      #"--with-mysql=mysqlnd",
      #"--with-mysqli=mysqlnd",
      "--with-mysql=#{HOMEBREW_PREFIX}",
      "--with-mysqli=#{HOMEBREW_PREFIX}/bin/mysql_config",
      "--with-openssl=" + Formula['openssl'].opt_prefix.to_s,
      "--with-pdo-mysql=#{HOMEBREW_PREFIX}",
      "--with-png-dir=#{Formula['libpng'].opt_prefix}",
      "--with-readline=#{Formula['readline'].opt_prefix}",
      "--with-tidy=#{Formula['tidy'].opt_prefix}",
      #"--with-tidy=#{Formula['tidy-html5'].opt_prefix}",
      "--with-xmlrpc",
      "--with-zlib=/usr",
      #"--with-zlib=#{Formula['zlib'].opt_prefix}",
      "--without-pear",
    ]

    system "./configure", *args
    
    inreplace "Makefile",
              /^INSTALL_IT = \$\(mkinstalldirs\) '([^']+)' (.+) LIBEXECDIR=([^\s]+) (.+)$/,
              "INSTALL_IT = $(mkinstalldirs) '#{libexec}/apache2' \\2 LIBEXECDIR='#{libexec}/apache2' \\4"
    
    inreplace 'Makefile' do |s|
      s.change_make_var! "EXTRA_LIBS", "\\1 -lstdc++"
    end
    
    system "make"
    ENV.deparallelize # parallel install fails on some systems
    system "make install"

    chmod_R 0775, lib+"php"

  end

end
