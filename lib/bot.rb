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

require 'cinch'
require './lib/markov'

# The actual bot.
class Bot

	LOGS_PATH = './logs/'

	def initialize()
		puts 'Starting up Skylord...'
		mkv = Markov.new
		log_files = ['#cats', '#runescape', '#skyrealm']
		log_files.each do |log|
			puts "Loading #{log}..."
			mkv.load_brain("#{LOGS_PATH}#{log}")
			puts "Finished loading #{log}."
		end
		puts "Sample sentence: " << mkv.generate_simple_sentence

		bot = Cinch::Bot.new do
			configure do |c|
				BotConfig.bot_conf(c)
			end

			on :message do |m|
				if BotConfig::REPLY_RATE >= rand(100)
					m.reply(mkv.generate_simple_sentence.strip)
				end
			end

			on :message, '!go' do |m|
				m.reply(mkv.generate_simple_sentence.strip)
			end
		end
		bot.start
	end
end