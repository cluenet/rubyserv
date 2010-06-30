class RubyServ
  class IRCd
    class Unreal < RubyServ::IRCd
      def on_connect
        raw("PASS #{config[:ircd][:pass]}")
        raw("PROTOCTL NICKv2 NICKIP")
        raw("SERVER #{config[:ircd][:server]} #{config[:ircd][:numeric]} :#{config[:ircd][:desc]}")
      end

      def on_line(prefix, command, *args)
        if command.downcase == "eos"
          raw("TSCTL SVSTIME #{Time.now.to_i}")
          raw(":#{config[:ircd][:server]} SMO o :\002(\002Burst\002)\002 [#{config[:ircd][:server]}] End of Incoming NetBurst.")
        else
          super
        end
      end
    end
  end
end
