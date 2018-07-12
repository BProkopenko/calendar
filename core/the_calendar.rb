class TheCalendar
	require 'date'
	require 'time'

	def run
		puts("Puts a Year or press \"Enter\"")
		@year = gets.chomp
		puts("Puts a Month or press \"Enter\"")
		@month = gets.chomp
		adaptation_params(@year, @month)
		print_calendar(@month, @year)
	end

	private

	def adaptation_params(y, m)
		if y.empty? || y.nil?
			@year = Time.now.year
		else
			@year = y.to_i
		end
		if m.empty? || y.nil?
			@month = Time.now.month
		else
			@month = m.to_i
		end
	end

	def calendar(month, year)
		header = %w[Mo Tu We Th Fr Sa Su]
		days = Date.new(year, month, -1).day
		d = Date.new(year, month, 1)
		monday = d.wday
		list = *1..days
		weeks = [[]]
		week_first = 1 - monday
		week_first.times {weeks[0] << list.shift}
		next_weeks = list.size / 7 + 1
		next_weeks.times do |i|
			weeks[i + 1] ||= []
			7.times do
				break if list.empty?
				weeks[i + 1] << list.shift
			end
		end
		pad_first = 7 - weeks[0].size
		pad_first.times {weeks[0].unshift(nil)}
		pad_last = 7 - weeks[0].size
		pad_last.times {weeks[-1].unshift(nil)}
		weeks.unshift(header)
	end

	def print_calendar(month, year)
		weeks = calendar(month, year)
		weeks.each do |week|
			week.each do |day|
				if day.nil?
					item = " " * 4
				elsif day.class == String
					item = " #{day} "
				else
					item = " %2d " % day
				end
				print item
			end
			puts
		end
		puts
	end
end