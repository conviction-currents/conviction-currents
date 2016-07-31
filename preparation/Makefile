all: clean_up simplify jsonify

jsonify:
	./jsonify.rb > ../site/ships.js

simplify:
	./simplify.rb

clean_up:
	head -n 1 input/* > cleaned/cleaned.csv
	./clean.rb >> cleaned/cleaned.csv	
