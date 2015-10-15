class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @special_word = @special_word.downcase

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split.count

    @occurrences = @text.downcase.split.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @months = @years*12
    @E_rate = @apr/1200




    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal*(@E_rate+(@E_rate / (((1 + @E_rate)**(@months))-1)))

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

    @seconds = @ending -   @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25

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

def sum(list_of_numbers)
  running_total = 0
  list_of_numbers.each do |number|
    running_total = running_total + number
  end


  return running_total
end

def mean(list_of_numbers)
    sum(@numbers) / @numbers.length
end

def variance(list_of_numbers)
    var = 0
    list_of_numbers.each do |number|
        var = var + ((number - mean(@numbers))**2)
end

return var /(@numbers.length).to_f
end


    @sorted_numbers = @numbers.sort

    @average = @sorted_numbers.sum / @sorted_numbers.count

    @count = @sorted_numbers.count

    @minimum = @sorted_numbers.min

    @maximum = @sorted_numbers.max

    @range = @sorted_numbers.max - @sorted_numbers.min
 
    @median = ( @sorted_numbers [((@sorted_numbers.length-1) / 2)]  + @sorted_numbers[(@sorted_numbers.length / 2 )]  ) / 2
                    
    @sum = sum(@numbers)

    @mean = mean(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = variance(@numbers)**(0.5)

        times = @sorted_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode =            @sorted_numbers.max_by { |v| times[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
