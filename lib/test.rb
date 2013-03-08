# Rbot logging (crudely dumped from rbot @ http://ruby-rbot.org/).
# TODO: Complete.

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

irclog('wat')
irclog('blah blah')

# test:
sourcenick = 'bob'
nick = 'bobv2'
message = 'hello'
modestring = '+m'
targets = ''
topic = 'Welcome to #sdf! | etc'
message = 'slaps joe around a bit with a large trout'

irclog("@ #{sourcenick} is now known as #{nick}")
irclog("@ Quit: #{sourcenick}: #{message}")
irclog("@ Mode #{modestring} #{targets} by #{sourcenick}")
irclog("@ #{sourcenick} set topic \"#{topic}\"")
irclog("* #{nick} #{message}")

message = 'hello i am bob'
channel = '#sdf'

irclog("<#{sourcenick}> #{message}")
irclog("@ #{sourcenick} joined channel #{channel}")
irclog("@ #{sourcenick} left channel #{channel} (#{message})")
irclog("@ #{target} has been kicked from #{channel} by #{sourcenick} (#{message})")