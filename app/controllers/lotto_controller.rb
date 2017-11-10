class LottoController < ApplicationController
  def index
  end

  def show
    @lotto = [*1..45].sample(6).sort
  end
  
  def api
    require 'json'
    
    url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
    response = HTTParty.get(url)
    @result = JSON.parse(response.body)
    
    @lotto = [*1..45].sample(6).sort
    #@lotto = [6, 12, 19, 24, 4, 41] #test code
    @arr = []
    @bonus = @result["bnusNo"]
    p @bonus
    6.times {|i| @arr << @result["drwtNo#{i.next}"]}
    
    #"lotto 담긴 숫자와 arr안에 담긴 숫자를 비교"
    @matching = @lotto & @arr
    @msg =""
    #6개 맞으면 1등
    #5개 맞으면 2등
    #4개 맞으면 3등
    #3개 맞으면 4등
    #2개 맞으면 5등
    #1개 맞으면 6등
    if @matching.size == 6
      @msg = "1등 (15억)"
      elsif @matching.size == 5 && @lotto.include?(@bonus)
        @msg = "2등 (4천만원)"
        elsif @matching.size == 4
          @msg = "3등 (120만원)"
          elsif @matching.size == 3
            @msg = "4등 (5만원)"
            elsif @matching.size == 2
              @msg = "5등 (5천원)"
              else  
                @msg = "꽝"
    end
    
    

  end
    
end


