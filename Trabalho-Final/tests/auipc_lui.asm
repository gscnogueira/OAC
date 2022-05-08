.text

	auipc a0, 0xab
	lui a1, 0xab
	auipc a2, 0xab

loop:
	beq zero, zero, loop
