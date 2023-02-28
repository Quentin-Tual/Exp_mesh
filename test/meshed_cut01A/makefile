ENTITY=$1

simulate:
	ghdl -a *.vhd

svg:
	@$(MAKE) simulate
	-mkdir svg
	for en in $(ENTITY); do \
		yosys -m ghdl -p "ghdl $$en; prep -top $$en; write_json -compat-int svg.json"; \
		netlistsvg svg.json -o svg/$$en.svg; \
	done
