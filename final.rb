# requer as bibliotecas para dar GET e pra converter JSON

require 'rest-client'
require 'json'

class App
	def initialize
		@http = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
		@key = 'trnsl.1.1.20181007T181925Z.92ee3a3c632fe5db.b7735a06fc9fd43d9d0391bf0b29a94d8ce6e8a7'
		puts 'digite o texto a ser traduzido'
		@text = gets
		puts 'digite o idioma do texto'
		@lang = gets.chomp
		puts 'por fim digite o idioma da tradução'
		@lang += "-" + gets.chomp
		@response = get_response

		generate_file

	end

	def get_response
		response = RestClient.get @http, {
			params: {
				key: @key,
				text: @text,
				lang: @lang,
			}
		}
		return response
	end

	def get_translation
		JSON.parse(@response)['text']
	end

	def generate_file
		file = File.open(Time.now.to_s, 'w') do |f|
			f.puts get_translation
		end
	end
end

app = App.new
