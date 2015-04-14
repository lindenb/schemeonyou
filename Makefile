.PHONY:all clean

%.md:%.m4
	m4 --debug --fatal-warnings -P $< > $@
	@cat $@

all :

clean:

	




