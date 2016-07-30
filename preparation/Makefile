all: clean_up simplify

simplify:
	./simplify.rb

clean_up:
	head -n 1 input/* > cleaned/cleaned.csv
	./clean.rb >> cleaned/cleaned.csv	
