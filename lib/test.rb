# Rbot logging. TODO: Complete.
# sdf

# log IRC-related message +message+ to a file determined by +where+.
# +where+ can be a channel name, or a nick for private message logging
def irclog(message, where="server")
	message = message.chomp
	stamp = Time.now.strftime("%Y/%m/%d %H:%M:%S")
	where = where.gsub(/[:!?$*()\/\\<>|"']/, "_")
	# unless(@logs.has_key?(where))
		# @logs[where] = File.new("#{@botclass}/logs/#{where}", "a")
		# @logs[where].sync = true
	# end
	# @logs[where].puts "[#{stamp}] #{message}"
	puts "[#{stamp}] #{message}"
end

irclog('hi')

'''
irclog "@ #{sourcenick} is now known as #{nick}", k
irclog "@ Quit: #{sourcenick}: #{message}", k
irclog "@ Mode #{modestring} #{targets} by #{sourcenick}", channel
irclog "@ #{sourcenick} set topic \"#{topic}\"", channel
irclog "* #{@nick} #{message}", where
irclog "<#{m.sourcenick}> #{m.message}", m.target
irclog "-=#{@nick}=- #{message}", where
irclog "@ #{m.sourcenick} joined channel #{m.channel}", m.channel
irclog "@ #{m.sourcenick} left channel #{m.channel} (#{m.message})", m.channel
irclog "@ #{m.target} has been kicked from #{m.channel} by #{m.sourcenick} (#{m.message})", m.channel
'''