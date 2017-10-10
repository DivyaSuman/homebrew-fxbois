homebrew-fxbois
===============

Homebrew formulae for my devel needs.

Installation
------------

1. Install [Homebrew]
2. Tap dupes ```brew tap homebrew/dupes```
3. Tap this repository ```brew tap fxbois/fxbois```
4. Install a formula ```brew install php```

Sierra (new way)
----------------
1. ```brew install apr apr-util```
2. ```sudo apachectl stop```
3. ```brew tap homebrew/apache```
4. ```brew install httpd24 --with-privileged-ports --with-http2```
5. mettre à jour la conf d'apache : ```/usr/local/etc/apache2/2.4/httpd.conf``` (comment proxy_html_module, ssl_module, Include + add ```Include /usr/local/etc/apache2/2.4/extra/httpd.conf```)

Sierra (old way)
----------------

1. brew install apr apr-util
2. brew link apr-util --force
3. brew link apr --force
4. sudo mkdir -p /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.12.xctoolchain/usr/local/bin/
5. sudo ln -s /usr/local/opt/apr/bin/apr-1-config /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.12.xctoolchain/usr/local/bin/
6. sudo ln -s /usr/local/opt/apr-util/bin/apu-1-config /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.12.xctoolchain/usr/local/bin/

Issues
------

Issues with configure script (e.g. ZLIB)

```xcode-select --install```
