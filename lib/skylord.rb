# Copyright (C) 2013  Justin Zeng (Whackatre)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require './lib/bot'

# Provides the configuration for the bot.
class BotConfig

	# Reply rate, in percent, of how often the bot will chip in
	# to the conversation (TODO: make sure the words LINK).
	REPLY_RATE = 5

	def self.bot_conf(c)
		c.server = 'irc.rizon.net'
		c.port = 6660
		c.nick = 'lordsky'
		c.realname = 'i am a cute cats_'
		c.authname = 'skyl0rd'
		c.user = 'catscute'
		c.channels = ['#cats', '#iForums', '#runescape', '#skyrealm']
	end
end

Bot.new