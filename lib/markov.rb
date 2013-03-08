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

# Another implementation of Markov chains. Converted and based off
# of a bot named PartyChat I found out GitHub (originally in Python):
# https://github.com/harperreed/partychat-markovchain-bot (thx!).
class Markov

	attr_accessor :markov_table

	# String used to separate sentences.
	STOP_WORD = "\n"

	# Causes a "new sentence" if found at the end of a word.
	STOP_SENTENCE = ['.', '!', '?', "\n"]

	# How many chars in front of the string to strip.
	SUBSTR_LEN = 22

	# The maximum amount of sentences.
	MAX_SENTENCES = 2

	# The maximum amount of words in a sentence.
	MAX_WORDS = 20

	# The max letter length before terminating.
	MAX_STR_LEN = 400

	# Hmm. :(
	FAIL_MSG = 'I can\'t. :('

	def initialize()
		@markov_table = {}

		# To reduce the severity of headaches.
		@markov_table.default = []

		@w1 = STOP_WORD
		@w2 = STOP_WORD
	end

	# Loads a file into the brain of the bot.
	def load_brain(path)
		text = nil
		File.open(path, 'r+') do |f|
			text = f.readlines
		end
		raise "Unable to read #{path}!" if text == nil
		text.each do |line|
			# Trim out the excess info (the date; thank
			# goodness the rbot log formatting is constant).
			line = line[SUBSTR_LEN..-1].strip

			# Ignore comments.
			next if line.start_with?('@')

			# Crudely parse out the name.
			if line.start_with?('<')
				end_idx = line.index('>') + 2

				if not line[end_idx..-1] == nil and line[end_idx..-1].include?(' ')
					add_to_brain(line[end_idx..-1])
				end
			end
		end
		# @markov_table[[@w1, @w2]] = STOP_WORD
	end

	# Adds a phrase (line) to the brain.
	def add_to_brain(line)
		line.split.each do |word|
			next if word.length < 1
			if @markov_table[[@w1, @w2]].length == 0
				@markov_table[[@w1, @w2]] = [word]
			else
				@markov_table[[@w1, @w2]] << word
			end
			@w1 = @w2
			@w2 = word
		end
	end

	# Finds a matching word.
	def find_word()
		if not @markov_table[[@w1, @w2]] == nil
			size = @markov_table[[@w1, @w2]].length
			if size == 1
				@markov_table[[@w1, @w2]][0]
			elsif size > 1
				num = rand(size)
				@markov_table[[@w1, @w2]][num]
			end
		else
			nil
		end
	end

	# Generates a simple random sentence based on
	# the existing markov table structure.
	def generate_simple_sentence()
		sentence_count = 0
		sentence = []
		@w1 = STOP_WORD
		@w2 = STOP_WORD
		final_sentence = ''

		# Repeat until max sentences req is satisfied.
		while sentence_count < MAX_SENTENCES
			new_word = find_word

			if @w1 == "\n" and @w2 == "\n"
				@w1 = @w2
				@w2 = new_word
			end

			# return FAIL_MSG if new_word == @STOP_WORD

			new_word = find_word

			return final_sentence if new_word == nil

			found = false
			STOP_SENTENCE.each do |c|
				if new_word.end_with?(c)
					found = true
					break
				end
			end

			if found or sentence.length > MAX_WORDS
			# if STOP_SENTENCE.include?(new_word)
				final_sentence = sentence.join(' ') << ' ' << new_word
				sentence = []
				sentence_count += 1
			else
				sentence << new_word
			end
			@w1 = @w2
			@w2 = new_word
			# return final_sentence if final_sentence.length > MAX_WORDS
		end
		final_sentence
	end
end