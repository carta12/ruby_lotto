require 'httparty'
require 'json'

url = "http://www.nlotto.co.kr/common.do?method=getLottoNumber&drwNo="
response = HTTParty.get(url)
result = JSON.parse(response.body)

arr = Array.new

# for i in 1..6
#     arr << result["drwtNo#{i}"]
# end

# 6.times {|i| arr << result["drwtNo#{i.next}"]}

result.each do |key, value|
    arr << value if key.include? "drwtNo"
end

puts arr.sort
    