class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/\s+/, "").length
    
    @search = @special_word.gsub(/[^a-z0-9\s]/i, "").downcase
    @occurrences = @text.gsub(/[^a-z0-9\s]/i, "").downcase.split.count(@search)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    
    @monthly_rate = @apr / 100 / 12
    @months = @years * 12
    @monthly_payment = @principal * @monthly_rate / (1 - (1 + @monthly_rate) ** - @months)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @position = @count - 1
    if @count.even?
    @median = (@sorted_numbers[@position / 2] + @sorted_numbers[@position / 2 + 1]) / 2
    else
    @median = @sorted_numbers[(@position + 1) / 2]
    end 
    
    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.count

    squared_numbers = []
    @numbers.each do |num|
      var = num - @mean
      squared_numbers.push(var**2)
    end
    
    @variance = squared_numbers.sum / @numbers.count  

    @standard_deviation = @variance**0.5

    @mode = @numbers.sort
    

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
