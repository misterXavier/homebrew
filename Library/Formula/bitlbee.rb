require 'formula'

class Bitlbee <Formula
  url 'http://get.bitlbee.org/src/bitlbee-1.2.7.tar.gz'
  homepage 'http://www.bitlbee.org/'
  md5 '46cb8c0a930970cccd09dce4b3155cae'

  depends_on 'glib'
  depends_on 'gnutls'

  def install
    # By default Homebrew will set ENV['LD'] to the same as ENV['CC'] which
    # defaults to /usr/bin/cc (see Library/Homebrew/extend/ENV.rb:39) However
    # this will break as bitlbee uses one of those odd and rare Makefiles that
    # can't handle the linker being 'cc' and must be 'ld' (don't ask me some C
    # magician will know).
    ENV['LD'] = '/usr/bin/ld'

    # Homebrew should handlle the stripping.
    # Should we use --config=/usr/local/var/lib/bitlbee/ ?
    system "./configure", "--debug=0", "--strip=0", "--ssl=gnutls", "--pidfile=#{var}/bitlbee/run/bitlbee.pid", "--config=#{var}/bitlbee/lib/", "--ipsocket=#{var}/bitlbee/run/bitlbee.sock", "--prefix=#{prefix}"
    # This build depends on make running first.
    system "make"
    system "make install"
    # This build has an extra step.
    system "make install-etc"

    (var+"bitlbee").mkpath
    (var+"bitlbee"+"run").mkpath
    (var+"bitlbee"+"lib").mkpath
  end
end
